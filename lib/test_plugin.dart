import 'test_plugin_platform_interface.dart';

class TestPlugin {
  Future<String?> getPlatformVersion() {
    return TestPluginPlatform.instance.getPlatformVersion();
  }

  Future<double?> getDeviceBrightness() {
    return TestPluginPlatform.instance.getDeviceBrightness();
  }

  Future<void> setDeviceBrightness(double value) {
    return TestPluginPlatform.instance.setDeviceBrightness(value);
  }
}
