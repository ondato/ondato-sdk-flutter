
import 'ondato_flutter_nfc_reader_platform_interface.dart';

class OndatoFlutterNfcReader {
  Future<String?> getPlatformVersion() {
    return OndatoFlutterNfcReaderPlatform.instance.getPlatformVersion();
  }
}
