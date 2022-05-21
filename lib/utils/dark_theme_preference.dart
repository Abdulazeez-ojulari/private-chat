import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const THEME_STATUS = "THEMESTATUS";

    static const STATUS = "BUTTONSTATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    
    final serviceStatus = await Permission.storage.isGranted ;
 
    bool isCameraOn = serviceStatus == ServiceStatus.enabled;
 
    final status = await Permission.storage.request();
 
    if (status == PermissionStatus.granted) {
     prefs.setBool(THEME_STATUS, value);
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
      prefs.setBool(THEME_STATUS, value);
    }
  
    
    prefs.setBool(THEME_STATUS, value);
   
  }

   setButtonStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   Future<void> requestCameraPermission() async {
    
    final serviceStatus = await Permission.storage.isGranted ;
 
    bool isCameraOn = serviceStatus == ServiceStatus.enabled;
 
    final status = await Permission.storage.request();
 
    if (status == PermissionStatus.granted) {
     prefs.setBool(STATUS, value);
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
      prefs.setBool(STATUS, value);
    }
  }
    prefs.setBool(STATUS, value);
   
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
 
    final serviceStatus = await Permission.storage.isGranted ;
 
    bool isCameraOn = serviceStatus == ServiceStatus.enabled;
 
    final status = await Permission.storage.request();
 
    if (status == PermissionStatus.granted) {
     prefs.getBool(THEME_STATUS);
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
      prefs.get(THEME_STATUS);
    }

    debugPrint(prefs.getBool(THEME_STATUS).toString());
  
    return prefs.getBool(THEME_STATUS) ?? false;

  }

   Future<bool> getButtonStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  
    
    final serviceStatus = await Permission.storage.isGranted ;
 
    bool isCameraOn = serviceStatus == ServiceStatus.enabled;
 
    final status = await Permission.storage.request();
 
    if (status == PermissionStatus.granted) {
     prefs.getBool(STATUS);
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
      prefs.getBool(STATUS);
    
  }
    return prefs.getBool(STATUS) ?? false;
  }
}