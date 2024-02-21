package com.example.gallery_app

import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.gallery/sharedpref"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method.equals("setValue")) {
                val key = call.argument<String>("key")
                val value = call.argument<String?>("value")
                savePreference(key, value)
            } else if (call.method.equals("getValue")) {
                val key = call.argument<String>("key")
                val value = getPreference(key)
                result.success(value)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun savePreference(key: String?, value: String?) {
        try {
            context.getSharedPreferences("my_prefs", Context.MODE_PRIVATE).edit().putString(key, value).apply()
        } catch (e: Exception) {
            println("Save failed native $e")
        }
    }

    private fun getPreference(key: String?): String? {
        try {
            return context.getSharedPreferences("my_prefs", Context.MODE_PRIVATE).getString(key, "")
        } catch (e: Exception) {
            println("get failed native $e")
            return null
        }
    }
}
