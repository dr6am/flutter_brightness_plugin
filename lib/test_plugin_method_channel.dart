import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'test_plugin_platform_interface.dart';

/// An implementation of [TestPluginPlatform] that uses method channels.
class MethodChannelTestPlugin extends TestPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel methodChannel = const MethodChannel('test_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final String? version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<double> getDeviceBrightness() async {
    final double brightness =
        await methodChannel.invokeMethod<double?>('getBrightnessLevel') ?? 0.0;
    return brightness;
  }

  @override
  Future<void> setDeviceBrightness(double value) async {
    assert(value <= 1 && value >= 0);
    await methodChannel.invokeMethod<bool>(
        'setBrightnessLevel', <String, double>{'value': value});
    return;
  }
}
