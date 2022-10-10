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

part of huawei_safetydetect;

/// Safety Detect Plugin Class
abstract class SafetyDetect {
  static const MethodChannel _methodChannel =
      MethodChannel('com.huawei.hms.flutter.safetydetect/method');

  /// Status codes map of the Safety Detect SDK.
  static const Map<String, String> statusCodes = <String, String>{
    /// [Description:] HMS Core SDK internal error.
    /// [Solution:] Go to Support > Customer Service > Submit Question Online,
    /// select the relevant topic, and submit your question. Huawei will get back
    /// to you as soon as possible.
    '19001': 'SDK_INTERNAL_ERROR',

    /// [Description:] Network exception.
    /// [Solution:] Verify that your phone has access to the Internet.
    '19002': 'NETWORK_ERROR',

    /// [Description:] The API is unavailable in this region.
    /// [Solution:] Verify that this API is supported in the region where the user is located.
    '19003': 'UNSUPPORTED_AREA',

    /// [Description:] Invalid app ID in the request.
    /// [Solution:] Verify that the app ID in the request is valid.
    '19004': 'INVALID_APPID_APPCHECK',

    /// [Description:] The HMS Core (APK) version on the user device does not support
    /// the Safety Detect service.
    /// [Solution:] Update HMS Core (APK) to the latest version.
    '19202': 'UNSUPPORTED_EMUI_VERSION',

    /// [Description:] The number of apps to check exceeds the maximum allowed by AppCheck.
    /// [Solution:] Reduce the number of apps to check.
    '19402': 'APPS_CHECK_FAILED_VIRUS_NUMBER_EXCEEDED',

    /// [Description:] A mandatory parameter in the request is empty.
    /// [Solution:] Verify that all mandatory parameters in the request are correctly set.
    '19150': 'PARAM_ERROR_EMPTY',

    /// [Description:] Parameter verification failed.
    /// [Solution:] Verify that parameters in the request are valid.
    '19151': 'PARAM_ERROR_INVALID',

    /// [Description:] An internal error occurred during app security check.
    /// [Solution:] Contact Huawei technical support.
    '19401': 'APPS_CHECK_INTERNAL_ERROR',

    /// [Description:] An internal error occurred during malicious URL check.
    /// [Solution:] Contact Huawei technical support.
    '19600': 'URL_CHECK_INNER_ERROR',

    /// [Description:] URLCheck initialization failed.
    /// [Solution:] Call the initUrlCheck() API first to initialize URLCheck.
    '19601': 'CHECK_WITHOUT_INIT',

    /// [Description:] The URLCheck API does not support the passed URL categories.
    /// Currently, Safety Detect can only identify phishing and malware URLs.
    /// [Solution:] Verify that the passed URL categories are valid.
    '19602': 'URL_CHECK_THREAT_TYPE_INVALID',

    /// [Description:] Invalid parameters for calling urlCheck.
    /// [Solution:] Verify that relevant parameters are valid.
    '19603': 'URL_CHECK_REQUEST_PARAM_INVALID',

    /// [Description:] The app ID passed for calling urlCheck is invalid.
    /// [Solution:] Verify that the passed app ID is valid.
    '19604': 'URL_CHECK_REQUEST_APPID_INVALID',

    /// [Description:] Fake user detection failed.
    /// [Solution:] Try again. If the detection fails for three times, risks exist.
    '19800': 'DETECT_FAIL',

    /// [Description:] Fake user detection timed out, for example, when the user enters the verification code.
    /// [Solution:] Try again.
    '19801': 'USER_DETECT_TIMEOUT',

    /// [Description:] The app ID passed for calling userDetection is invalid.
    /// [Solution:] Verify that the passed app ID is valid.
    '19802': 'USER_DETECT_INVALID_APPID',

    /// [Description:] Failed to display a popup on a non-Huawei phone.
    /// [Solution:] Go to Settings (or your phone manager app), assign HMS Core (APK) with the permission to display a popup while running in the background, and try again.
    '19803': 'USER_DETECT_PERMISSION',

    /// [Description:] Failed to initialize imperceptible fake user detection.
    /// [Solution:] Contact Huawei technical support.
    '19820': 'ANTI_FRAUD_INIT_FAIL',

    /// [Description:] The app ID passed to the initAntiFraud API is incorrect.
    /// [Solution:] Verify the passed parameter.
    '19821': 'ANTI_FRAUD_INIT_PARAM_INVALID',

    /// [Description:] Failed to obtain the risk token.
    /// [Solution:] Initialize the API again.
    '19830': 'RISK_TOKEN_GET_FAIL',

    /// [Description:] An internal error occurred on the API for obtaining a risk token.
    /// [Solution:] Contact Huawei technical support.
    '19831': 'RISK_TOKEN_INNER_ERROR',

    /// [Description:] Unkown error code.
    /// [Solution:] Contact Huawei technical support.
    '-1': 'UNKOWN_ERROR_STATUS_CODE',
  };

  /// Obtains the Application ID from the agconnect-services.json file.
  static Future<String> get getAppID async {
    return await _methodChannel.invokeMethod(
      'getAppId',
    );
  }

  /// Initiates a request to check the system integrity of the current device.
  static Future<String> sysIntegrity(
    Uint8List nonce,
    String appId, {
    String? alg,
  }) async {
    return await _methodChannel.invokeMethod(
      'sysIntegrity',
      <String, dynamic>{
        'nonce': nonce,
        'appId': appId,
        'alg': alg,
      },
    );
  }

  /// Checks whether app security check is enabled.
  static Future<bool> isVerifyAppsCheck() async {
    return await _methodChannel.invokeMethod(
      'isVerifyAppsCheck',
    );
  }

  /// Enables app security check.
  static Future<bool> enableAppsCheck() async {
    return await _methodChannel.invokeMethod(
      'enableAppsCheck',
    );
  }

  /// Initiates an app security check request.
  static Future<List<MaliciousAppData>> getMaliciousAppsList() async {
    final List<dynamic> result = await _methodChannel.invokeMethod(
      'getMaliciousAppsList',
    );
    return List<MaliciousAppData>.from(
      result.map(
        (dynamic e) => MaliciousAppData.fromMap(
          Map<String, dynamic>.from(e),
        ),
      ),
    );
  }

  /// Initializes URL check.
  static Future<void> initUrlCheck() async {
    await _methodChannel.invokeMethod(
      'initUrlCheck',
    );
  }

  /// Initiates a URL check request.
  static Future<List<UrlCheckThreat>> urlCheck(
    String url,
    String appId,
    List<UrlThreatType> urlThreatTypes,
  ) async {
    final List<int> threatTypesValues = <int>[];
    for (UrlThreatType urlThreatType in urlThreatTypes) {
      if (urlThreatType == UrlThreatType.malware) {
        threatTypesValues.add(1);
      } else if (urlThreatType == UrlThreatType.phishing) {
        threatTypesValues.add(3);
      }
    }
    final List<dynamic> result = await _methodChannel.invokeMethod(
      'urlCheck',
      <String, dynamic>{
        'url': url,
        'appId': appId,
        'threatTypes': threatTypesValues,
      },
    );
    return List<UrlCheckThreat>.from(
      result.map(
        (dynamic e) => UrlCheckThreat.fromInt(e),
      ),
    );
  }

  /// Disables URL check.
  static Future<void> shutdownUrlCheck() async {
    await _methodChannel.invokeMethod(
      'shutdownUrlCheck',
    );
  }

  /// Initializes fake user detection.
  static Future<void> initUserDetect() async {
    await _methodChannel.invokeMethod(
      'initUserDetect',
    );
  }

  /// Initiates a fake user detection request.
  /// Note: This feature is not available in the Chinise Mainland.
  static Future<String?> userDetection(String appId) async {
    return await _methodChannel.invokeMethod(
      'userDetection',
      <String, dynamic>{
        'appId': appId,
      },
    );
  }

  /// Disables fake user detection.
  static Future<void> shutdownUserDetect() async {
    await _methodChannel.invokeMethod(
      'shutdownUserDetect',
    );
  }

  /// Obtains the malicious Wi-Fi check result.
  /// Note: This feature is available only in the Chinese Mainland.
  static Future<WifiDetectResponse> getWifiDetectStatus() async {
    final int res = await _methodChannel.invokeMethod(
      'getWifiDetectStatus',
    );
    return WifiDetectResponse.fromInt(res);
  }

  /// Initializes imperceptible fake user detection.
  static Future<void> initAntiFraud(String appId) async {
    await _methodChannel.invokeMethod(
      'initAntiFraud',
      <String, dynamic>{
        'appId': appId,
      },
    );
  }

  /// Obtains a risk token.
  static Future<String?> getRiskToken() async {
    return await _methodChannel.invokeMethod(
      'getRiskToken',
    );
  }

  /// Disables imperceptible fake user detection.
  static Future<void> releaseAntiFraud() async {
    await _methodChannel.invokeMethod(
      'releaseAntiFraud',
    );
  }

  /// Enables HMS Plugin Method Analytics.
  static Future<void> enableLogger() async {
    await _methodChannel.invokeMethod(
      'enableLogger',
    );
  }

  /// Disables HMS Plugin Method Analytics.
  static Future<void> disableLogger() async {
    await _methodChannel.invokeMethod(
      'disableLogger',
    );
  }
}
