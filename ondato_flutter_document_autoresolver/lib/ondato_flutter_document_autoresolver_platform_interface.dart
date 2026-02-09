import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ondato_flutter_document_autoresolver_method_channel.dart';

abstract class OndatoFlutterDocumentAutoresolverPlatform extends PlatformInterface {
  /// Constructs a OndatoFlutterDocumentAutoresolverPlatform.
  OndatoFlutterDocumentAutoresolverPlatform() : super(token: _token);

  static final Object _token = Object();

  static OndatoFlutterDocumentAutoresolverPlatform _instance = MethodChannelOndatoFlutterDocumentAutoresolver();

  /// The default instance of [OndatoFlutterDocumentAutoresolverPlatform] to use.
  ///
  /// Defaults to [MethodChannelOndatoFlutterDocumentAutoresolver].
  static OndatoFlutterDocumentAutoresolverPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OndatoFlutterDocumentAutoresolverPlatform] when
  /// they register themselves.
  static set instance(OndatoFlutterDocumentAutoresolverPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
