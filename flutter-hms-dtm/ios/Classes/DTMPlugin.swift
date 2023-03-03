/*
 * Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Flutter
import DTMSDK

public class DTMPlugin: NSObject, FlutterPlugin {
    private static let methodChannelName = "com.huawei.hms.flutter.dtm/method"
    private(set) static var allReturnValues = [String:String]()
    public static var channels = [FlutterMethodChannel]()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: methodChannelName, binaryMessenger: registrar.messenger())
        let instance = DTMPlugin()
        channels.append(channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let method = call.method
        let service = DTMService.shared
        switch method {
        case "onEvent":
            service.onEvent(call: call, result: result)
            break
        case "setCustomVariable":
            service.setCustomVariable(call: call, result: result)
            break
        case "disableLogger":
            service.disableLogger(result: result)
            break
        case "enableLogger":
            service.enableLogger(result: result)
            break
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    static func setReturnValue(key: String, value: String){
        allReturnValues[key] = value
    }
    
    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        Self.channels.removeAll()
        Self.allReturnValues.removeAll()
    }
}

