import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ondato_flutter_screen_recorder_method_channel.dart';

abstract class OndatoFlutterScreenRecorderPlatform extends PlatformInterface {
  /// Constructs a OndatoFlutterScreenRecorderPlatform.
  OndatoFlutterScreenRecorderPlatform() : super(token: _token);

  static final Object _token = Object();

  static OndatoFlutterScreenRecorderPlatform _instance = MethodChannelOndatoFlutterScreenRecorder();

  /// The default instance of [OndatoFlutterScreenRecorderPlatform] to use.
  ///
  /// Defaults to [MethodChannelOndatoFlutterScreenRecorder].
  static OndatoFlutterScreenRecorderPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OndatoFlutterScreenRecorderPlatform] when
  /// they register themselves.
  static set instance(OndatoFlutterScreenRecorderPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
