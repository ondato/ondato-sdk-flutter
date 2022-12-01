import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:ondato_flutter/ondato_config.dart';

class OndatoFlutter {
  static const MethodChannel _channel = const MethodChannel('ondato_flutter');

  static bool? _isInit = false;

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod(_OndatoSdkChannel.getPlatformVersion);
    return version;
  }

  static Future<bool?> init(OndatoServiceConfiguration config) async {
    // log('Hello there!');
    _isInit = await _channel.invokeMethod<bool>(_OndatoSdkChannel.initialSetup, config.toMap());
    return _isInit;
  }

  static Future<String?> startIdentification() async {
    // log('Starting!');
    final result = await _channel.invokeMethod(_OndatoSdkChannel.startIdentification);
    // log(result);
    if (result.containsKey('error')) {
      log('Throwing it!');
      throw OndatoException(result['identificationId'], result['error']);
    }
    return result['identificationId'];
  }
}

class _OndatoSdkChannel {
  _OndatoSdkChannel._();
  static const String getPlatformVersion = 'getPlatformVersion';
  static const String initialSetup = 'initialSetup';
  static const String startIdentification = 'startIdentification';
}
