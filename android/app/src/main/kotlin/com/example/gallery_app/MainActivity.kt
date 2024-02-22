package com.example.gallery_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            SHARED_PREF_METHOD_CHANNEL
        ).setMethodCallHandler(SharedPreferenceHandler(context = context))

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            PERMISSION_METHOD_CHANNEL
        ).setMethodCallHandler(PermissionHandler(activity = this))
    }

    companion object {
        private const val SHARED_PREF_METHOD_CHANNEL = "com.example.gallery/sharedpref"
        private const val PERMISSION_METHOD_CHANNEL = "com.example.gallery/permission"
    }
}
