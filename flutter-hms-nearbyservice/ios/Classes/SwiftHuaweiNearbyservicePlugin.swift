import Flutter
import UIKit

public class SwiftHuaweiNearbyservicePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "huawei_nearbyservice", binaryMessenger: registrar.messenger())
    let instance = SwiftHuaweiNearbyservicePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
