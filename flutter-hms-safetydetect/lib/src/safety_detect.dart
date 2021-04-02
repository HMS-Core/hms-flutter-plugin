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
import 'dart:typed_data';

import 'package:huawei_safetydetect/huawei_safetydetect.dart';
import 'package:huawei_safetydetect/src/url_check_threat.dart';

import './constants/constants.dart' show methodChannel;
import 'wifi_detect_response.dart';

/// Safety Detect Plugin Class
class SafetyDetect {
  /// Obtains the Application ID from the agconnect-services.json file.
  static Future<String> get getAppID async {
    return await methodChannel.invokeMethod('getAppId');
  }

  /// Initiates a request to check the system integrity of the current device.
  static Future<String> sysIntegrity(Uint8List nonce, String appId) async {
    if (nonce == null || appId == null) throw ("Arguments can't be null");
    return await methodChannel
        .invokeMethod('sysIntegrity', {"nonce": nonce, "appId": appId});
  }

  /// Checks whether app security check is enabled.
  static Future<bool> isVerifyAppsCheck() async {
    return await methodChannel.invokeMethod('isVerifyAppsCheck');
  }

  /// Enables app security check.
  static Future<bool> enableAppsCheck() async {
    return await methodChannel.invokeMethod('enableAppsCheck');
  }

  /// Initiates an app security check request.
  static Future<List<MaliciousAppData>> getMaliciousAppsList() async {
    final List result =
        await methodChannel.invokeMethod('getMaliciousAppsList');

    return List<MaliciousAppData>.from(result
        .map((e) => MaliciousAppData.fromMap(Map<String, dynamic>.from(e))));
  }

  /// Initializes URL check.
  static Future<void> initUrlCheck() async {
    methodChannel.invokeMethod('initUrlCheck');
  }

  /// Initiates a URL check request.
  static Future<List<UrlCheckThreat>> urlCheck(
      String url, String appId, List<UrlThreatType> urlThreatTypes) async {
    List<int> threatTypesValues = <int>[];
    for (var urlThreatType in urlThreatTypes) {
      if (urlThreatType == UrlThreatType.malware) {
        threatTypesValues.add(1);
      } else if (urlThreatType == UrlThreatType.phishing) {
        threatTypesValues.add(3);
      }
    }
    Map<String, dynamic> args = {
      "url": url,
      "appId": appId,
      "threatTypes": threatTypesValues
    };
    final List result = await methodChannel.invokeMethod('urlCheck', args);

    return List<UrlCheckThreat>.from(
        result.map((e) => UrlCheckThreat.fromInt(e)));
  }

  /// Disables URL check.
  static Future<void> shutdownUrlCheck() async {
    methodChannel.invokeMethod('shutdownUrlCheck');
  }

  /// Initializes fake user detection.
  static Future<void> initUserDetect() async {
    methodChannel.invokeMethod('initUserDetect');
  }

  /// Initiates a fake user detection request.
  ///
  /// Note: This feature is not available in the Chinise Mainland.
  static Future<String> userDetection(String appId) async {
    return await methodChannel.invokeMethod('userDetection', {"appId": appId});
  }

  /// Disables fake user detection.
  static Future<void> shutdownUserDetect() async {
    methodChannel.invokeMethod('shutdownUserDetect');
  }

  /// Obtains the malicious Wi-Fi check result.
  ///
  /// Note: This feature is available only in the Chinese Mainland.
  static Future<WifiDetectResponse> getWifiDetectStatus() async {
    int res = await methodChannel.invokeMethod('getWifiDetectStatus');
    return WifiDetectResponse.fromInt(res);
  }

  /// Initializes imperceptible fake user detection.
  static Future<void> initAntiFraud(String appId) async {
    methodChannel.invokeMethod('initAntiFraud', {"appId": appId});
  }

  /// Obtains a risk token.
  static Future<String> getRiskToken() async {
    return await methodChannel.invokeMethod('getRiskToken');
  }

  /// Disables imperceptible fake user detection.
  static Future<void> releaseAntiFraud() async {
    methodChannel.invokeMethod('releaseAntiFraud');
  }

  /// Enables HMS Plugin Method Analytics.
  static Future<void> enableLogger() async {
    methodChannel.invokeMethod('enableLogger');
  }

  /// Disables HMS Plugin Method Analytics.
  static Future<void> disableLogger() async {
    methodChannel.invokeMethod('disableLogger');
  }
}
