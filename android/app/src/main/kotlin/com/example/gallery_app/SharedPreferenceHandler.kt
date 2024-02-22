package com.example.gallery_app

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class SharedPreferenceHandler(val context: Context) : MethodChannel.MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "setValue" -> {
                val key = call.argument<String>("key")
                val value = call.argument<String?>("value")
                savePreference(
                    key = key,
                    value = value
                )
            }

            "getValue" -> {
                val key = call.argument<String>("key")
                val value = getPreference(key)
                result.success(value)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    private fun savePreference(key: String?, value: String?) {
        try {
            context.getSharedPreferences("my_prefs", Context.MODE_PRIVATE).edit()
                .putString(key, value).apply()
        } catch (e: Exception) {
            println("Save failed native $e")
        }
    }

    private fun getPreference(key: String?): String? {
        return try {
            context.getSharedPreferences("my_prefs", Context.MODE_PRIVATE).getString(key, "")
        } catch (e: Exception) {
            println("get failed native $e")
            null
        }
    }
}