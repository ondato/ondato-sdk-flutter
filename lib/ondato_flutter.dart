import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ondato_flutter/ondato_config.dart';

class OndatoFlutter {
  static const MethodChannel _channel = const MethodChannel('ondato_flutter');

  static bool _isInit = false;

  static Future<String> get platformVersion async {
    final String version =
        await _channel.invokeMethod(_OndatoSdkChannel.getPlatformVersion);
    return version;
  }

  static Future<bool> init(OndatoServiceConfiguration config) async {
    _isInit = await _channel.invokeMethod<bool>(
        _OndatoSdkChannel.initialSetup, config.toMap());
    return _isInit;
  }

  static Future<String> startIdentification() async {
    final result =
        await _channel.invokeMethod(_OndatoSdkChannel.startIdentification);
    // if (result.containsKey('error')) {
    //   throw OndatoException(result['identificationId'], result['error']);
    // }
    return result;
  }
}

class _OndatoSdkChannel {
  _OndatoSdkChannel._();
  static const String getPlatformVersion = 'getPlatformVersion';
  static const String initialSetup = 'initialSetup';
  static const String startIdentification = 'startIdentification';
}
