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

import Foundation
import HiAnalytics

@objc(Analytics)

/// Provides methods to initialize Analytics Kit and implement analysis functions.
class Analytics: NSObject, Handling {
    /// All the Analytics API's can be reached via AnalyticsViewModel class instance.
    private lazy var viewModel: AnalyticsViewModel = AnalyticsViewModel()

    func getInstance(_ routePolicy: String, resolve: @escaping FlutterResult) {
        Log.debug(#function) {
            viewModel.getInstance(routePolicy)
            handle(resolve: resolve)
        }
    }

    /// Sets data reporting policies.
    /// - Parameters:
    ///   - reportPolicyType: HAReportPolicy type.
    ///   - timer: Scheduled time interval, in seconds (value range: 60 to 1800).
    ///   - resolve: Refers to result value, in the success scenarario, {"isSuccess": true} is returned. in the failure scenarario, exception is returned.
    /// - Important:
    /// - **onScheduledTimePolicy**  -> Event reporting at scheduled time.
    /// - **onAppLaunchPolicy** -> Event reporting on app launch.
    /// - **onMoveBackgroundPolicy** -> Event reporting when the app moves to the background (enabled by default).
    /// - **onCacheThresholdPolicy** -> Event reporting when the specified threshold is reached (enabled by default). The default value is 200 (value range: 30 to 1000). This policy remains effective after being enabled.
    /// - Returns: Void
    func setReportPolicies(_ reportPolicyType: NSDictionary, resolve: @escaping FlutterResult) {
        Log.debug(#function) {
            viewModel.setReportPolicies(reportPolicyType)
            handle(resolve: resolve)
        }
    }

    /// Report custom events.
    ///
    /// - Parameters:
    ///   - eventId: Event ID, a string that contains a maximum of 256 characters excluding spaces and invisible characters. The value cannot be empty or set to the ID of an automatically collected event.
    ///   - params: Information carried in the event. The key value cannot contain spaces or invisible characters.
    ///   - resolve: Refers to result value, in the success scenarario, {"isSuccess": true} is returned. in the failure scenarario, exception is returned.
    /// - Returns: Void
    func onEvent(_ eventId: String, params: NSDictionary, resolve: @escaping FlutterResult) {
        Log.debug(#function) {
            viewModel.onEvent(eventId, params: params)
            handle(resolve: resolve)
        }
    }

    /// User attribute values remain unchanged throughout the app's lifecycle and session. A maximum of 25 user attribute names are supported. If an attribute name is duplicate with an existing one, the attribute names needs to be changed.
    /// - Parameters:
    ///   - name: User attribute name, a string that contains a maximum of 256 characters excluding spaces and invisible characters. The value cannot be empty.
    ///   - value: Attribute value, a string that contains a maximum of 256 characters. The value cannot be empty.
    ///   - resolve: Refers to result value, in the success scenarario, {"isSuccess": true} is returned. in the failure scenarario, exception is returned.
    /// - Returns: Void
    func setUserProfile(_ name: String, value: String, resolve: @escaping FlutterResult) {
        Log.debug(#function) {
            viewModel.setUserProfile(name, value: value)
            handle(resolve: resolve)
        }
    }

    /// Deletes user profile.
    /// - Parameters:
    ///   - name: User attribute name, a string that contains a maximum of 256 characters excluding spaces and invisible characters. The value cannot be empty.
    /// - Returns: Void
    func deleteUserProfile(_ name: String, resolve: @escaping FlutterResult) {
        Log.debug(#function) {
            viewModel.setUserProfile(name)
            handle(resolve: resolve)
        }
    }

    /// Enable AB Testing. Predefined or custom user attributes are supported.
    /// - Parameters:
    ///   - predefined: Indicates whether to obtain predefined user attributes.
    ///   - resolve: Refers to result value, in the success scenarario, {"isSuccess": true} is returned. in the failure scenarario, exception is returned.
    /// - Returns: Predefined or custom user attributes.
    func userProfiles(_ predefined: Bool, resolve: @escaping FlutterResult) {
        Log.debug(#function) {
            viewModel.userProfiles(predefined) { [weak self] (result, error) in
                guard let strongSelf = self else {return}
                if let error = error {
                    strongSelf.fail(with: error.localizedDescription, resolve: resolve)
                    return
                }
                if let result = result {
                    strongSelf.handle(resolve: resolve, result)
                }
            }
        }
    }

    /// Enable event collection. No data will be collected when this function is disabled.
    /// - Parameters:
    ///   - enabled: Indicates whether to enable event collection. **YES: enabled (default); NO: disabled.**
    ///   - resolve: Refers to result value, in the success scenarario, {"isSuccess": true} is returned. in the failure scenarario, exception is returned.
    /// - Returns: Void
    func setAnalyticsEnabled(_ enabled: Bool, resolve: @escaping FlutterResult) {
        Log.debug(#function) {
            viewModel.setAnalyticsEnabled(enabled)
            handle(resolve: resolve)
        }
    }

    /// Obtain the app instance ID from AppGallery Connect.
    /// - Parameters:
    ///   - resolve: Refers to result value, in the success scenarario, {"isSuccess": true} is returned. in the failure scenarario, exception is returned.
    /// - Returns: Void
    func aaid(_ resolve: @escaping FlutterResult) {
        Log.debug(#function) {
            handle(resolve: resolve, viewModel.aaid())
        }
    }

    /// Set a user ID.
    /// - Parameters:
    ///   - userId: User ID, a string that contains a maximum of 256 characters. The value cannot be empty.
    ///   - resolve: Refers to result value, in the success scenarario, {"isSuccess": true} is returned. in the failure scenarario, exception is returned.
    ///  - Important: When the setUserId API is called, if the old userId is not empty and is different from the new userId, a new session is generated. If you do not want to use setUserId to identify a user (for example, when a user signs out), set userId to **nil**.
    /// - Returns: Void
    func setUserId(_ userId: String, resolve: @escaping FlutterResult) {
        Log.debug(#function) {
            viewModel.setUserId(userId)
            handle(resolve: resolve)
        }
    }

    /// Delete user ID.
    /// - Parameters:
    ///   - resolve: Refers to result value, in the success scenarario, {"isSuccess": true} is returned. in the failure scenarario, exception is returned.
    /// - Returns: Void
    func deleteUserId(resolve: @escaping FlutterResult) {
        Log.debug(#function) {
            viewModel.setUserId()
            handle(resolve: resolve)
        }
    }

    /// Set the session timeout interval. The app is running in the foreground. When the interval between two adjacent events exceeds the specified timeout interval, a new session is generated.
    /// - Parameters:
    ///   - milliseconds: Session timeout interval, in milliseconds.
    ///   - resolve: Refers to result value, in the success scenarario, {"isSuccess": true} is returned. in the failure scenarario, exception is returned.
    ///  - Important: The default value is 30 minutes.
    /// - Returns: Void
    func setSessionDuration(_ milliseconds: Int, resolve: @escaping FlutterResult) {
        Log.debug(#function) {
            viewModel.setSessionDuration(TimeInterval(milliseconds))
            handle(resolve: resolve)
        }
    }

    /// Delete all collected data in the local cache, including the cached data that fails to be sent.
    /// - Parameters:
    ///  - resolve: Refers to result value, in the success scenarario, {"isSuccess": true} is returned. in the failure scenarario, exception is returned.
    /// - Returns: Void
    func clearCachedData(_ resolve: @escaping FlutterResult) {
        Log.debug(#function) {
            viewModel.clearCachedData()
            handle(resolve: resolve)
        }
    }

    /// Specifies whether to enable restriction of HUAWEI Analytics. The default value is false, which indicates that HUAWEI Analytics is enabled by default.
    /// - Parameters:
    ///   - enabled: Indicates whether to enable restriction of HUAWEI Analytics. The default value is false, which indicates that HUAWEI Analytics is enabled by default. true: Enables restriction of HUAWEI Analytics. false: Disables restriction of HUAWEI Analytics.
    ///    - resolve: Refers to result value, in the success scenarario, {"isSuccess": true} is returned. in the failure scenarario, exception is returned.
    /// - Returns: Void
    func setRestrictionEnabled(_ enabled: Bool, resolve: @escaping FlutterResult) {
        Log.debug(#function) {
            viewModel.setRestrictionEnabled(enabled)
            handle(resolve: resolve)
        }
    }
    /// Obtains the restriction status of HUAWEI Analytics.
    /// - Parameters:
    ///    - resolve: Refers to result value, in the success scenarario, {"isSuccess": true} is returned. in the failure scenarario, exception is returned.
    /// - Returns: Void
    @objc func isRestrictionEnabled(_ resolve: @escaping FlutterResult) {
        Log.debug(#function) {
            handle(resolve: resolve, viewModel.isRestrictionEnabled())
        }
    }
    
    func setMinActivitySession(_ interval: Int64, resolve: @escaping FlutterResult) {
        Log.debug(#function) {
            viewModel.setMinActivitySession(interval)
            handle(resolve: resolve)
        }
    }
    
    func setCollectAdsIdEnabled(_ enabled: Bool, resolve: @escaping FlutterResult) {
        Log.debug(#function) {
            viewModel.setCollectAdsIdEnabled(enabled)
            handle(resolve: resolve)
        }
    }
    
    func addDefaultEventParams(_ params: [String: Any]?, resolve: @escaping FlutterResult) {
        Log.debug(#function) {
            viewModel.addDefaultEventParams(params)
            handle(resolve: resolve)
        }
    }
}
