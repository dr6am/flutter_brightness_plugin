import Flutter
import UIKit

enum CallMethods: String {
    case getPlatformVersion = "getPlatformVersion"
    case getBrightnessLevel = "getBrightnessLevel"
    case setBrightnessLevel = "setBrightnessLevel"
}

public class SwiftTestPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "test_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftTestPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch(call.method) {
    case CallMethods.getBrightnessLevel.rawValue:
        result(UIScreen.main.brightness)
    case CallMethods.setBrightnessLevel.rawValue:
        if let args = call.arguments as? Dictionary<String, Any>,
            let value = args["value"] as? CGFloat {
              
            
            UIScreen.main.brightness = value
            result(nil)
          } else {
            result(FlutterError.init(code: "errorSetDebug", message: "data or format error", details: nil))
          }
        
        result(true)
    case CallMethods.getPlatformVersion.rawValue:
        result("iOS " + UIDevice.current.systemVersion)
    default:
        result("Default called")
    }
  }
}
