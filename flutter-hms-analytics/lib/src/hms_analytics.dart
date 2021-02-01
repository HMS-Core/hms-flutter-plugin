/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'dart:async';

import 'package:flutter/services.dart';

class HMSAnalytics {
  static const MethodChannel _channel =
      const MethodChannel('com.huawei.hms.flutter.analytics');

  /// Enables the log function.
  ///  [note] This function is specifically used by Android Platforms.
  Future<void> enableLog() async {
    await _channel.invokeMethod('enableLog', {});
  }

  /// Enables the debug log function and sets the minimum log level.
  /// [note] This function is specifically used by Android Platforms.
  Future<void> enableLogWithLevel(String logLevel) async {
    if (logLevel == null) {
      throw ArgumentError.notNull("loglevel");
    }

    if (!(logLevel == "DEBUG" ||
        logLevel == "INFO" ||
        logLevel == "WARN" ||
        logLevel == "ERROR")) {
      throw ArgumentError.value(
          logLevel, "logLevel", "Possible options [DEBUG, INFO, WARN, ERROR]");
    }

    await _channel.invokeMethod('enableLogWithLevel', {'logLevel': logLevel});
  }

  /// Set a user ID.
  ///  [important] : When the setUserId API is called, if the old userId is not
  /// empty and is different from the new userId, a new session is generated.
  /// If you do not want to use setUserId to identify a user
  /// (for example, when a user signs out), set userId to **null**.
  Future<void> setUserId(String userId) async {
    if (userId == null) {
      throw ArgumentError.notNull("userId");
    }
    await _channel.invokeMethod('setUserId', {'userId': userId});
  }

  /// User attribute values remain unchanged throughout the app's lifecycle and session.
  /// A maximum of 25 user attribute names are supported.
  /// If an attribute name is duplicate with an existing one, the attribute names needs to be changed.
  Future<void> setUserProfile(String key, String value) async {
    if (key == null || value == null) {
      throw ArgumentError.notNull("key | value");
    }
    dynamic params = {'key': key, 'value': value};
    await _channel.invokeMethod('setUserProfile', params);
  }

  /// Sets the push token, which is obtained using the Push Kit.
  /// [note] This function is specifically used by Android Platforms.
  Future<void> setPushToken(String token) async {
    if (token == null) {
      throw ArgumentError.notNull("token");
    }
    await _channel.invokeMethod('setPushToken', {'': token});
  }

  /// Sets the minimum interval for starting a new session.
  /// [note] This function is specifically used by Android Platforms.
  Future<void> setMinActivitySessions(int interval) async {
    if (interval == null) {
      throw ArgumentError.notNull("interval");
    }
    await _channel
        .invokeMethod('setMinActivitySessions', {'interval': interval});
  }

  /// Sets the session timeout interval.
  Future<void> setSessionDuration(int duration) async {
    if (duration == null) {
      throw ArgumentError.notNull("duration");
    }
    await _channel.invokeMethod('setSessionDuration', {'duration': duration});
  }

  /// Report custom events.
  Future<void> onEvent(String key, Map<String, dynamic> value) async {
    if (key == null || value == null) {
      throw ArgumentError.notNull("key | value");
    }

    dynamic params = {
      'key': key,
      'value': value,
    };
    await _channel.invokeMethod('onEvent', params);
  }

  /// Delete all collected data in the local cache, including the cached data that fails to be sent.
  Future<void> clearCachedData() async {
    await _channel.invokeMethod('clearCachedData', {});
  }

  /// Specifies whether to enable event collection.
  Future<void> setAnalyticsEnabled(bool enabled) async {
    if (enabled == null) {
      throw ArgumentError.notNull("enabled");
    }
    await _channel.invokeMethod('setAnalyticsEnabled', {'enabled': enabled});
  }

  /// Obtains the app instance ID from AppGallery Connect.
  Future<String> getAAID() async {
    return await _channel.invokeMethod('getAAID', {});
  }

  /// Enables AB Testing. Predefined or custom user attributes are supported.
  Future<Map<String, dynamic>> getUserProfiles(bool predefined) async {
    if (predefined == null) {
      throw ArgumentError.notNull("predefined");
    }
    Map<dynamic, dynamic> profiles = await _channel
        .invokeMethod('getUserProfiles', {'predefined': predefined});
    return Map<String, dynamic>.from(profiles);
  }

  /// Defines a custom page entry event.
  ///  [note] This function is specifically used by Android Platforms.
  Future<void> pageStart(String pageName, String pageClassOverride) async {
    if (pageName == null || pageClassOverride == null) {
      throw ArgumentError.notNull("pageName | pageClassOverride");
    }
    dynamic params = {
      'pageName': pageName,
      'pageClassOverride': pageClassOverride,
    };
    await _channel.invokeMethod('pageStart', params);
  }

  /// Defines a custom page exit event.
  Future<void> pageEnd(String pageName) async {
    if (pageName == null) {
      throw ArgumentError.notNull("pageName");
    }
    await _channel.invokeMethod('pageEnd', {'pageName': pageName});
  }

  /// Sets data reporting policies.
  Future<void> setReportPolicies(
      {int scheduledTime,
      bool appLaunch,
      bool moveBackground,
      int cacheThreshold}) async {
    Map<String, dynamic> policyMap = new Map();

    if (scheduledTime != null) {
      if (scheduledTime >= 60 && scheduledTime <= 1800)
        policyMap['scheduledTime'] = scheduledTime;
      else
        throw ("Invalid value provided for scheduledTime. Accepted value range: [60 - 1800]");
    }

    if (cacheThreshold != null) {
      if (scheduledTime >= 30 && scheduledTime <= 1000)
        policyMap['cacheThreshold'] = cacheThreshold;
      else
        throw ("Invalid value provided for cacheThreshold. Accepted value range: [30 - 1000]");
    }

    if (appLaunch != null) {
      policyMap['appLaunch'] = appLaunch;
    }

    if (moveBackground != null) {
      policyMap['moveBackground'] = moveBackground;
    }

    await _channel.invokeMethod('setReportPolicies', {'policyType': policyMap});
  }

  ///Obtains the threshold for event reporting.
  ///@param reportPolicyType : Event reporting policy name.
  /// [note] This function is specifically used by Android Platforms.
  Future<int> getReportPolicyThreshold(String policyType) async {
    if (policyType == null) {
      throw ArgumentError.notNull("policyType");
    }
    return await _channel.invokeMethod(
        'getReportPolicyThreshold', {'reportPolicyType': policyType});
  }

  /// Specifies whether to enable restriction of HUAWEI Analytics.
  /// The default value is false, which indicates that HUAWEI Analytics is
  /// enabled by default.
  Future<void> setRestrictionEnabled(bool enabled) async {
    if (enabled == null) {
      throw ArgumentError.notNull("enabled");
    }
    await _channel.invokeMethod('setRestrictionEnabled', {'enabled': enabled});
  }

  /// Obtains the restriction status of HUAWEI Analytics.
  Future<bool> isRestrictionEnabled() async {
    return await _channel.invokeMethod('isRestrictionEnabled', {});
  }

  /// Enables the HMSLogger capability.
  Future<void> enableLogger() async {
    await _channel.invokeMethod('enableLogger', {});
  }

  ///Disables the HMSLogger capability.
  Future<void> disableLogger() async {
    await _channel.invokeMethod('disableLogger', {});
  }

  /// Delete created user profile
  Future<void> deleteUserProfile(String key) async {
    if (key == null) {
      throw ArgumentError.notNull("key");
    }
    dynamic params = {'key': key};
    await _channel.invokeMethod('deleteUserProfile', params);
  }

  /// Delete created user ID.
  Future<void> deleteUserId() async {
    await _channel.invokeMethod('deleteUserId', {});
  }
}
