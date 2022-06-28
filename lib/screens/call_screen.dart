import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:privatechat/controllers/themeNotifier.dart';
import 'package:privatechat/models/call.dart';
import 'package:privatechat/models/token.dart';
import 'package:privatechat/screens/friends_chat.dart';
import 'package:privatechat/utils/log.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

var appId = '39b7feed0e404fbc8f2235b0c8359bab';

String channelId = 'PrivateChat';

/// CallScreen Example
class CallScreen extends StatefulWidget {
  final Call call;

  /// Construct the [CallScreen]
  const CallScreen({
    Key? key,
    required this.call,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CallScreen> {
  late final RtcEngine _engine;
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = true,
      playEffect = false;
  bool _enableInEarMonitoring = false;
  double _recordingVolume = 100,
      _playbackVolume = 100,
      _inEarMonitoringVolume = 100;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.call.channelId);
    _initEngine();
  }

  Future<Token> createToken() async {
    final response = await http.post(
      Uri.parse('https://agora-token-gene.herokuapp.com/api/agora/token-id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(
          {'channelName': widget.call.channelId, 'uid': widget.call.callId}),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Token.fromJson(convert.jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception(response);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(appId));
    _addListeners();
    _joinChannel();

    await _engine.enableAudio();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  void _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        logSink.log('warning $warningCode');
      },
      error: (errorCode) {
        logSink.log('error $errorCode');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        logSink.log('joinChannelSuccess $channel $uid $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      leaveChannel: (stats) async {
        logSink.log('leaveChannel ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
    ));
  }

  _joinChannel() async {
    final res = await createToken();
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }
    if (res.token.isNotEmpty) {
      await _engine
          .joinChannel(res.token, _controller.text, null, widget.call.callId)
          .catchError((onError) {
        logSink.log('error ${onError.toString()}');
      });
    }
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
    setState(() {
      isJoined = false;
      openMicrophone = true;
      enableSpeakerphone = true;
      playEffect = false;
      _enableInEarMonitoring = false;
      _recordingVolume = 100;
      _playbackVolume = 100;
      _inEarMonitoringVolume = 100;
    });
    return const FriendsChat();
  }

  _switchMicrophone() async {
    // await _engine.muteLocalAudioStream(!openMicrophone);
    await _engine.enableLocalAudio(!openMicrophone).then((value) {
      setState(() {
        openMicrophone = !openMicrophone;
      });
    }).catchError((err) {
      logSink.log('enableLocalAudio $err');
    });
  }

  _switchSpeakerphone() {
    _engine.setEnableSpeakerphone(!enableSpeakerphone).then((value) {
      setState(() {
        enableSpeakerphone = !enableSpeakerphone;
      });
    }).catchError((err) {
      logSink.log('setEnableSpeakerphone $err');
    });
  }

  _switchEffect() async {
    if (playEffect) {
      _engine.stopEffect(1).then((value) {
        setState(() {
          playEffect = false;
        });
      }).catchError((err) {
        logSink.log('stopEffect $err');
      });
    } else {
      final path =
          (await _engine.getAssetAbsolutePath("assets/Sound_Horizon.mp3"))!;
      _engine.playEffect(1, path, 0, 1, 1, 100, openMicrophone).then((value) {
        setState(() {
          playEffect = true;
        });
      }).catchError((err) {
        logSink.log('playEffect $err');
      });
    }
  }

  _onChangeInEarMonitoringVolume(double value) async {
    _inEarMonitoringVolume = value;
    await _engine.setInEarMonitoringVolume(_inEarMonitoringVolume.toInt());
    setState(() {});
  }

  _toggleInEarMonitoring(value) async {
    _enableInEarMonitoring = value;
    await _engine.enableInEarMonitoring(_enableInEarMonitoring);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // return Stack(
    //   children: [
    //     Column(
    //       children: [
    //         Row(
    //           children: [
    //             Expanded(
    //               flex: 1,
    //               child: ElevatedButton(
    //                 onPressed: isJoined ? _leaveChannel : _joinChannel,
    //                 child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
    //               ),
    //             )
    //           ],
    //         ),
    //       ],
    //     ),
    //     Align(
    //         alignment: Alignment.bottomRight,
    //         child: Padding(
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             crossAxisAlignment: CrossAxisAlignment.end,
    //             children: [
    //               ElevatedButton(
    //                 onPressed: _switchMicrophone,
    //                 child: Text('Microphone ${openMicrophone ? 'on' : 'off'}'),
    //               ),
    //               ElevatedButton(
    //                 onPressed: isJoined ? _switchSpeakerphone : null,
    //                 child:
    //                     Text(enableSpeakerphone ? 'Speakerphone' : 'Earpiece'),
    //               ),
    //               if (!kIsWeb)
    //                 ElevatedButton(
    //                   onPressed: isJoined ? _switchEffect : null,
    //                   child: Text('${playEffect ? 'Stop' : 'Play'} effect'),
    //                 ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.end,
    //                 children: [
    //                   const Text('RecordingVolume:'),
    //                   Slider(
    //                     value: _recordingVolume,
    //                     min: 0,
    //                     max: 400,
    //                     divisions: 5,
    //                     label: 'RecordingVolume',
    //                     onChanged: isJoined
    //                         ? (double value) {
    //                             setState(() {
    //                               _recordingVolume = value;
    //                             });
    //                             _engine
    //                                 .adjustRecordingSignalVolume(value.toInt());
    //                           }
    //                         : null,
    //                   )
    //                 ],
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.end,
    //                 children: [
    //                   const Text('PlaybackVolume:'),
    //                   Slider(
    //                     value: _playbackVolume,
    //                     min: 0,
    //                     max: 400,
    //                     divisions: 5,
    //                     label: 'PlaybackVolume',
    //                     onChanged: isJoined
    //                         ? (double value) {
    //                             setState(() {
    //                               _playbackVolume = value;
    //                             });
    //                             _engine
    //                                 .adjustPlaybackSignalVolume(value.toInt());
    //                           }
    //                         : null,
    //                   )
    //                 ],
    //               ),
    //               Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 crossAxisAlignment: CrossAxisAlignment.end,
    //                 children: [
    //                   Row(mainAxisSize: MainAxisSize.min, children: [
    //                     const Text('InEar Monitoring Volume:'),
    //                     Switch(
    //                       value: _enableInEarMonitoring,
    //                       onChanged: isJoined ? _toggleInEarMonitoring : null,
    //                       activeTrackColor: Colors.grey[350],
    //                       activeColor: Colors.white,
    //                     )
    //                   ]),
    //                   if (_enableInEarMonitoring)
    //                     SizedBox(
    //                         width: 300,
    //                         child: Slider(
    //                           value: _inEarMonitoringVolume,
    //                           min: 0,
    //                           max: 100,
    //                           divisions: 5,
    //                           label:
    //                               'InEar Monitoring Volume $_inEarMonitoringVolume',
    //                           onChanged: isJoined
    //                               ? _onChangeInEarMonitoringVolume
    //                               : null,
    //                         ))
    //                 ],
    //               ),
    //             ],
    //           ),
    //           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
    //         ))
    //   ],
    // );
    final darkTheme = Provider.of<ThemeNotifier>(context).darkTheme;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff201F24),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.network(
                  widget.call.callerPic ?? '',
                  height: 300,
                  width: 200,
                ),
                Text(
                  widget.call.callerName ?? '',
                  style:
                      const TextStyle(fontSize: 25, color: Color(0xffFE9AAB)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.15, vertical: 5),
                    width: width,
                    height: height * 0.1,
                    color: Color(0xff201F24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                primary: enableSpeakerphone
                                    ? Colors.white
                                    : Color(0xff201F24),
                              ),
                              onPressed: _switchSpeakerphone,
                              child: Icon(
                                Icons.volume_up,
                                color: Color(0xffFE9AAB),
                                size: width * 0.06,
                              ),
                            ),
                            const Text(
                              'Speaker',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xffFE9AAB),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff201F24),
                                shape: const CircleBorder(),
                              ),
                              onPressed: _switchMicrophone,
                              child: Icon(
                                openMicrophone ? Icons.mic_off : Icons.mic,
                                color: Color(0xffFE9AAB),
                                size: width * 0.06,
                              ),
                            ),
                            const Text(
                              'Mic',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xffFE9AAB),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: playEffect
                                    ? Colors.white
                                    : Color(0xff201F24),
                                shape: const CircleBorder(),
                              ),
                              onPressed: _switchEffect,
                              child: Icon(
                                Icons.pause,
                                color: Color(0xffFE9AAB),
                                size: width * 0.06,
                              ),
                            ),
                            const Text(
                              'Hold',
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xffFE9AAB)),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: const CircleBorder(),
                              ),
                              onPressed: _leaveChannel,
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: width * 0.06,
                              ),
                            ),
                            const Text(
                              'End Call',
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xffFE9AAB)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
