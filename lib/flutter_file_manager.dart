import 'dart:async';

import 'package:flutter/services.dart';

class FlutterFileManager {
  static const MethodChannel _channel =
      const MethodChannel('flutter_file_manager');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }


  static openFile(Map args){
    _channel.invokeMethod('openFile',args);
  }

  static install(String path){
    _channel.invokeMethod('install',path);
  }

}
