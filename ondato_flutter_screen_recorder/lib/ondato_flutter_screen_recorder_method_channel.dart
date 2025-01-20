import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ondato_flutter_screen_recorder_platform_interface.dart';

/// An implementation of [OndatoFlutterScreenRecorderPlatform] that uses method channels.
class MethodChannelOndatoFlutterScreenRecorder extends OndatoFlutterScreenRecorderPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ondato_flutter_screen_recorder');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
