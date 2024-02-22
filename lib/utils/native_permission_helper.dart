import 'package:flutter/services.dart';
import 'package:gallery_app/utils/permission_helper.dart';

class NativePermissionHelper extends PermissionHandler {
  final _permissionMethodChannel =
      const MethodChannel('com.example.gallery/permission');

  @override
  Future<bool> requestImagesPermission() async {
    try {
      final bool result = await _permissionMethodChannel
          .invokeMethod('requestImagesPermission');
      print("Request permission success: $result");
      return result;
    } catch (e) {
      print("Request permission failed: '${e}'.");
      return false;
    }
  }
}
