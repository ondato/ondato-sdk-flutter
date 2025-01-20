import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ondato_flutter_nfc_reader_method_channel.dart';

abstract class OndatoFlutterNfcReaderPlatform extends PlatformInterface {
  /// Constructs a OndatoFlutterNfcReaderPlatform.
  OndatoFlutterNfcReaderPlatform() : super(token: _token);

  static final Object _token = Object();

  static OndatoFlutterNfcReaderPlatform _instance = MethodChannelOndatoFlutterNfcReader();

  /// The default instance of [OndatoFlutterNfcReaderPlatform] to use.
  ///
  /// Defaults to [MethodChannelOndatoFlutterNfcReader].
  static OndatoFlutterNfcReaderPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OndatoFlutterNfcReaderPlatform] when
  /// they register themselves.
  static set instance(OndatoFlutterNfcReaderPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
