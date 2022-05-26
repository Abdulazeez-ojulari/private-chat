import 'package:intl/intl.dart';

class TimeFormat {
  static String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'DAY AGO';
      } else {
        time = diff.inDays.toString() + 'DAYS AGO';
      }
    }
    return time;
  }
}
