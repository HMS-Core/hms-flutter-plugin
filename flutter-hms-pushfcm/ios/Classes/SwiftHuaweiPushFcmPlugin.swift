import Flutter
import UIKit

public class SwiftHuaweiPushFcmPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "huawei_push_fcm", binaryMessenger: registrar.messenger())
    let instance = SwiftHuaweiPushFcmPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
