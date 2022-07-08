package com.example.test_plugin


import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.content.ContentResolver as contentResolver
import android.os.Build
import android.provider.Settings
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result as FlutterResult
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler


/** TestPlugin */
class TestPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var context: Context

    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "test_plugin")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: FlutterResult) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${Build.VERSION.RELEASE}")
            }
            "getBrightnessLevel" -> {
          val value = Settings.System.getInt(context.contentResolver,
            Settings.System.SCREEN_BRIGHTNESS, 0)
                result.success(value.toFloat())
            }
            "setBrightnessLevel" -> {

                val value = call.argument<Double>("value")
                val brightness: Float = normalize(value?.toFloat() , 0F, 100F, 0.0f, 255.0f)
                if (value != null) {
                    Settings.System.putInt(
                        context.contentResolver, Settings.System.SCREEN_BRIGHTNESS,
                        brightness.toInt()
                    )
                }
                result.success(true)
            }
            else -> {
                result.notImplemented()
            }
        }

    }

    private fun hasPermissionsToWriteSettings(context: Activity): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            Settings.System.canWrite(context)
        } else {
            ContextCompat.checkSelfPermission(
                context,
                Manifest.permission.WRITE_SETTINGS
            ) == PackageManager.PERMISSION_GRANTED
        }
    }

    private fun normalize(
        x: Float?,
        inMin: Float,
        inMax: Float,
        outMin: Float,
        outMax: Float
    ): Float {
        val outRange = outMax - outMin
        val inRange = inMax - inMin
        val value: Float = x ?: 1f
        return ((value * 100) - inMin) * outRange / inRange + outMin
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
