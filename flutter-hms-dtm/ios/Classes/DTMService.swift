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

import HiAnalytics

final class DTMService {
    static let shared = DTMService()
    
    private init(){
        HiAnalytics.config()
    }
    
    func onEvent(call: FlutterMethodCall, result: @escaping FlutterResult){
        guard let args = call.arguments as? [String: Any] else {
            result(FlutterError(code: "", message: "invalid arguments", details: nil))
            return
        }
        guard let key = args["key"] as? String,
              let value = args["value"] as? [String: Any] else {
            result(FlutterError(code: "", message: "invalid call", details: nil))
            return
        }
        HiAnalytics.onEvent(key, setParams: value)
        result(nil)
    }
    
    func setCustomVariable(call: FlutterMethodCall, result: @escaping FlutterResult){
        guard let args = call.arguments as? [String: Any] else {
            result(FlutterError(code: "", message: "invalid arguments", details: nil))
            return
        }
        guard let key = args["key"] as? String,
              let value = args["value"] as? String else {
            result(FlutterError(code: "", message: "invalid call", details: nil))
            return
        }

        DTMPlugin.setReturnValue(key: key, value: value)
        result(nil)
    }
    
    func enableLogger(result: @escaping FlutterResult){
        Logger.shared.enableLogger()
        result(nil)
    }
    
    func disableLogger(result: @escaping FlutterResult){
        Logger.shared.disableLogger()
        result(nil)
    }
}
