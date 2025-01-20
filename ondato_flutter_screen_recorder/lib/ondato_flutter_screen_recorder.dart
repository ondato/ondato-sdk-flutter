
import 'ondato_flutter_screen_recorder_platform_interface.dart';

class OndatoFlutterScreenRecorder {
  Future<String?> getPlatformVersion() {
    return OndatoFlutterScreenRecorderPlatform.instance.getPlatformVersion();
  }
}
