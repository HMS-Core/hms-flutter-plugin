/*
 Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.
 
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

import HiAnalytics

/// HAReportPolicy Types.
enum ReportPolicyType: String {
    case scheduledTime, appLaunch, moveBackground, cacheThreshold
}

/// All the Analytics API's can be reached via AnalyticsViewModel class instance.
public class AnalyticsViewModel {
    /// **CompletionHandler** is a typealias that provides result and error when the request is completed.
    /// - Parameters:
    ///   - result: Any Object that will be returned when the result comes.
    ///   - error: NSError that will be returned when there is an error.
    public typealias CompletionHandler = (_ result: Any?, _ error: NSError?) -> Void

    private var completionHandler: CompletionHandler?
    
    func getInstance(_ routePolicy: String) {
        if (routePolicy.isEmpty) {
            HiAnalytics.config()
        } else {
            HiAnalytics.config(withRoutePolicy: routePolicy)
        }
    }
 
    ///   - reportPolicyType: HAReportPolicy type.
    /// - Important:
    /// - **onScheduledTimePolicy**  -> Event reporting at scheduled time.
    /// - **onAppLaunchPolicy** -> Event reporting on app launch.
    /// - **onMoveBackgroundPolicy** -> Event reporting when the app moves to the background (enabled by default).
    /// - **onCacheThresholdPolicy** -> Event reporting when the specified threshold is reached (enabled by default). The default value is 200 (value range: 30 to 1000). This policy remains effective after being enabled.
    /// - Returns: Void
    func setReportPolicies(_ reportPolicyType: NSDictionary) {
        var reportPolicyList = [HAReportPolicy]()
        for type in reportPolicyType.allKeys {
            let sType = type as! String
            switch  sType {
            case ReportPolicyType.scheduledTime.rawValue:
                let scheduledTime = reportPolicyType[sType] as! Int
                reportPolicyList.append(HAReportPolicy.onScheduledTime(scheduledTime))
            case ReportPolicyType.appLaunch.rawValue:
                let appLaunch = reportPolicyType[sType] as! Bool
                if appLaunch {
                    reportPolicyList.append(HAReportPolicy.onAppLaunch())
                }
            case ReportPolicyType.cacheThreshold.rawValue:
                let cacheThreshold = reportPolicyType[sType] as? Int
                reportPolicyList.append(HAReportPolicy.onCacheThresholdPolicy(cacheThreshold!))
            case ReportPolicyType.moveBackground.rawValue:
                let moveBackground = reportPolicyType[sType] as! Bool
                if moveBackground {
                    reportPolicyList.append(HAReportPolicy.onMoveBackground())
                }
            default:
                return
            }
        }
        HiAnalytics.setReportPolicies(reportPolicyList)
    }

    /// Report custom events.
    ///
    /// - Parameters:
    ///   - eventId: Event ID, a string that contains a maximum of 256 characters excluding spaces and invisible characters. The value cannot be empty or set to the ID of an automatically collected event.
    ///   - params: Information carried in the event. The key value cannot contain spaces or invisible characters.
    /// - Returns: Void
    func onEvent(_ eventId: String, params: NSDictionary) {
        if let params = (params as? [String: Any]) {
            HiAnalytics.onEvent(eventId, setParams: params)
        }
    }

    /// User attribute values remain unchanged throughout the app's lifecycle and session. A maximum of 25 user attribute names are supported. If an attribute name is duplicate with an existing one, the attribute names needs to be changed.
    /// - Parameters:
    ///   - name: User attribute name, a string that contains a maximum of 256 characters excluding spaces and invisible characters. The value cannot be empty.
    ///   - value: Attribute value, a string that contains a maximum of 256 characters. The value cannot be empty.
    /// - Returns: Void
    func setUserProfile(_ name: String, value: String) {
        HiAnalytics.setUserProfile(name, setValue: value)
    }

    /// Deletes user profile.
    /// - Parameters:
    ///   - name: User attribute name, a string that contains a maximum of 256 characters excluding spaces and invisible characters. The value cannot be empty.
    /// - Returns: Void
    func setUserProfile(_ name: String) {
        HiAnalytics.setUserProfile(name, setValue: nil)
    }

    /// Enable AB Testing. Predefined or custom user attributes are supported.
    /// - Parameters:
    ///   - predefined: Indicates whether to obtain predefined user attributes.
    ///   - completion: A closer in the form of CompletionHandler will be called after request is completed.
    /// - Returns: Predefined or custom user attributes.
    func userProfiles(_ predefined: Bool, completion: @escaping CompletionHandler) {
        self.completionHandler = completion
        if let result =  HiAnalytics.userProfiles(predefined) {
            self.postData(result: result)
        } else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "User attributes are nil"])
            self.postError(error: error)
        }
    }

    /// Enable event collection. No data will be collected when this function is disabled.
    /// - Parameters:
    ///   - enabled: Indicates whether to enable event collection. **YES: enabled (default); NO: disabled.**
    /// - Returns: Void
    func setAnalyticsEnabled(_ enabled: Bool) {
        HiAnalytics.setAnalyticsEnabled(enabled)
    }

    /// Obtain the app instance ID from AppGallery Connect.
    func aaid() -> String {
        return HiAnalytics.aaid()
    }

    /// Set a user ID.
    /// - Parameters:
    ///   - userId: User ID, a string that contains a maximum of 256 characters. The value cannot be empty.
    ///  - Important: When the setUserId API is called, if the old userId is not empty and is different from the new userId, a new session is generated. If you do not want to use setUserId to identify a user (for example, when a user signs out), set userId to **nil**.
    /// - Returns: Void
    func setUserId(_ userId: String) {
        HiAnalytics.setUserId(userId)
    }
    
    /// Delete user ID.
    /// - Returns: Void
    func setUserId() {
        HiAnalytics.setUserId(nil)
    }
    
    /// Set the session timeout interval. The app is running in the foreground. When the interval between two adjacent events exceeds the specified timeout interval, a new session is generated.
    /// - Parameters:
    ///   - milliseconds: Session timeout interval, in milliseconds.
    ///  - Important: The default value is 30 minutes.
    /// - Returns: Void
    func setSessionDuration(_ milliseconds: TimeInterval) {
        HiAnalytics.setSessionDuration(TimeInterval(milliseconds))
    }

    /// Delete all collected data in the local cache, including the cached data that fails to be sent.
    func clearCachedData() {
        HiAnalytics.clearCachedData()
    }

    /// Specifies whether to enable restriction of HUAWEI Analytics. The default value is false, which indicates that HUAWEI Analytics is enabled by default.
    /// - Parameters:Indicates whether to enable restriction of HUAWEI Analytics. The default value is false, which indicates that HUAWEI Analytics is enabled by default. **true:** Enables restriction of HUAWEI Analytics. **false:** Disables restriction of HUAWEI Analytics.Indicates whether to enable event collection. **YES: enabled (default); NO: disabled.**
    /// - Returns: Void
    func setRestrictionEnabled(_ enabled: Bool) {
        HiAnalytics.setRestrictionEnabled(enabled)
    }

    /// Obtains the restriction status of HUAWEI Analytics.
    func isRestrictionEnabled() -> Bool {
        return HiAnalytics.isRestrictionEnabled()
    }
    
    func setMinActivitySession(_ interval: Int64) {
        HiAnalytics.setMinActivitySession(TimeInterval(interval))
    }
    
    func setCollectAdsIdEnabled(_ enabled: Bool) {
        HiAnalytics.setCollectAdsIdEnabled(enabled)
    }
    
    func addDefaultEventParams(_ params: [String: Any]?) {
        HiAnalytics.addDefaultEventParams(params)
    }
}

extension AnalyticsViewModel {
    fileprivate func postData(result: Any?) {
        if let comp = completionHandler {
            comp(result, nil)
        }
    }

    fileprivate func postError(error: NSError?) {
        if let comp = completionHandler {
            comp(nil, error)
        }
    }
}
