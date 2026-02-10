
import 'ondato_flutter_document_autoresolver_platform_interface.dart';

class OndatoFlutterDocumentAutoresolver {
  Future<String?> getPlatformVersion() {
    return OndatoFlutterDocumentAutoresolverPlatform.instance.getPlatformVersion();
  }
}
