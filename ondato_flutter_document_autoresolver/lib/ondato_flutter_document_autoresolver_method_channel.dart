import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ondato_flutter_document_autoresolver_platform_interface.dart';

/// An implementation of [OndatoFlutterDocumentAutoresolverPlatform] that uses method channels.
class MethodChannelOndatoFlutterDocumentAutoresolver extends OndatoFlutterDocumentAutoresolverPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ondato_flutter_document_autoresolver');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
