package com.example.gallery_app

import android.Manifest
import android.app.Activity
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry

class PermissionHandler(private val activity: Activity) : MethodCallHandler,
    PluginRegistry.RequestPermissionsResultListener, ActivityAware {

    private var currentActivity: Activity? = null
    private var activeResult: MethodChannel.Result? = null
    private var isPermissionGranted: Boolean = false

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method.equals("requestImagesPermission")) {
            activeResult = result
            requestImagePermission()
        } else {
            result.notImplemented();
        }
    }

    private fun requestImagePermission() {
        val readImagePermission =
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU)
                Manifest.permission.READ_MEDIA_IMAGES
            else
                Manifest.permission.READ_EXTERNAL_STORAGE

        if (ContextCompat.checkSelfPermission(
                activity,
                readImagePermission
            ) == PackageManager.PERMISSION_GRANTED
        ) {
            isPermissionGranted = true
            sendResponse()
        } else {
            ActivityCompat.requestPermissions(
                activity,
                arrayOf(readImagePermission),
                IMAGE_PERMISSION_REQUEST_CODE
            )
        }
    }

    private fun sendResponse() {
        activeResult?.success(isPermissionGranted)
        activeResult = null
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ): Boolean {
        when (requestCode) {
            IMAGE_PERMISSION_REQUEST_CODE -> {
                isPermissionGranted = grantResults.isNotEmpty() &&
                        grantResults[0] == PackageManager.PERMISSION_GRANTED
                sendResponse()
                return true
            }
        }
        return false
    }
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        currentActivity = binding.activity
        binding.addRequestPermissionsResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        currentActivity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        currentActivity = binding.activity
        binding.addRequestPermissionsResultListener(this)
    }

    override fun onDetachedFromActivity() {
        currentActivity = null
    }

    companion object {
        private const val IMAGE_PERMISSION_REQUEST_CODE = 100
    }
}