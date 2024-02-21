import 'package:flutter/services.dart';

class NativePreferenceHelper {
  static const MethodChannel _methodChannel =
      MethodChannel('com.example.gallery/sharedpref');

  static Future<String?> getValue(String key) async {
    try {
      final getValue =
          await _methodChannel.invokeMethod('getValue', {'key': key});
      print("getValue $getValue");
      return getValue;
    } catch (e) {
      print('Error getting value: $e');
      return null;
    }
  }

  static Future<void> setValue(String key, String value) async {
    try {
      await _methodChannel
          .invokeMethod('setValue', {'key': key, 'value': value});
      print("setValue done success key $key , value $value");

    } catch (e) {
      print('Error setting value: $e');
      return;
    }
  }
}


