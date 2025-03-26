import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermissions() async {
  // Check and request storage permissions
  if (await Permission.storage.isGranted) {
    return true;
  }

  if (await Permission.storage.request().isGranted) {
    return true;
  }
  if (await Permission.audio.request().isGranted) {
    return true;
  }

  // For Android 11+ scoped storage
  if (await Permission.manageExternalStorage.isGranted) {
    return true;
  }

  if (await Permission.manageExternalStorage.request().isGranted) {
    return true;
  }

  // Permission denied
  return false;
}
