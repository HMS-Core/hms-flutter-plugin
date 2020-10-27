/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import Flutter
import UIKit
import Foundation

public class AnalyticsPluginSwift: NSObject, FlutterPlugin {
    let analytics: Analytics = Analytics.init()
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.huawei.hms.flutter.analytics", binaryMessenger: registrar.messenger())
        let instance = AnalyticsPluginSwift()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any] else {
            return
        }
        let method = Methods.init()

        switch call.method {
        case method.CLEAR_CACHED_DATA:
            analytics.clearCachedData(result)
        case method.SET_ANALYTICS_ENABLED:
            guard let enabled = args["enabled"] as? Bool else { return }
            analytics.setAnalyticsEnabled(enabled, resolve: result)
        case method.GET_AAID:
            analytics.aaid(result)
        case method.GET_USER_PROFILES:
            guard let predefined = args["predefined"] as? Bool else { return }
            analytics.userProfiles(predefined, resolve: result)
        case method.SET_SESSIONS_DURATION:
            guard let milisecond = args["duration"] as? Int else { return }
            analytics.setSessionDuration(milisecond, resolve: result)
        case method.SET_USER_PROFILE:
            guard let name = args["key"] as? String else { return }
            guard let value = args["value"] as? String else { return }
            analytics.setUserProfile(name, value: value , resolve: result)
        case method.ON_EVENT:
            guard let name = args["key"] as? String else { return }
            guard let value = args["value"] as? NSDictionary else { return }
            analytics.onEvent(name, params: value,resolve: result)
        case method.SET_USER_ID:
            guard let userId = args["userId"] as? String else { return }
            analytics.setUserId(userId,resolve: result)
        case method.SET_REPORT_POLICIES:
            guard let policyType = args["policyType"] as? NSDictionary else { return }
            analytics.setReportPolicies(policyType, resolve: result)
        default:
            result(FlutterError(code: "platformError", message: "Not supported on iOS platform", details: ""));
        }
    }

    struct Methods {
        let CLEAR_CACHED_DATA = "clearCachedData"
        let SET_ANALYTICS_ENABLED = "setAnalyticsEnabled"
        let GET_AAID = "getAAID"
        let GET_USER_PROFILES = "getUserProfiles"
        let SET_SESSIONS_DURATION = "setSessionDuration"
        let SET_USER_ID = "setUserId"
        let SET_USER_PROFILE = "setUserProfile"
        let ON_EVENT = "onEvent"
        let PAGE_START = "pageStart"
        let PAGE_END = "pageEnd"
        let SET_MIN_ACTIVITY_SESSIONS = "setMinActivitySessions"
        let SET_PUSH_TOKEN = "setPushToken"
        let ENABLE_LOG = "enableLog"
        let ENABLE_LOG_WITH_LEVEL = "enableLogWithLevel"
        let SET_REPORT_POLICIES = "setReportPolicies"
        let ENABLE_LOGGER = "enableLogger"
        let DISABLE_LOGGER = "disableLogger"
    }
}
