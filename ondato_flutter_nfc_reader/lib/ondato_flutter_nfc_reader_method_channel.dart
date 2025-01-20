import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ondato_flutter_nfc_reader_platform_interface.dart';

/// An implementation of [OndatoFlutterNfcReaderPlatform] that uses method channels.
class MethodChannelOndatoFlutterNfcReader extends OndatoFlutterNfcReaderPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ondato_flutter_nfc_reader');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
