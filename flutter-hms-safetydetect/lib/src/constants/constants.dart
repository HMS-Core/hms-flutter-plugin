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

library constants;

export 'channel.dart';

/// Status codes map of the Safety Detect SDK.
const Map SafetyDetectStatusCodes = {
  /// [Description:] HMS Core SDK internal error.
  ///
  /// [Solution:] Go to Support > Customer Service > Submit Question Online,
  /// select the relevant topic, and submit your question. Huawei will get back
  /// to you as soon as possible.
  '19001': 'SDK_INTERNAL_ERROR',

  /// [Description:] Network exception.
  ///
  /// [Solution:] Verify that your phone has access to the Internet.
  '19002': 'NETWORK_ERROR',

  /// [Description:] The API is unavailable in this region.
  ///
  /// [Solution:] Verify that this API is supported in the region where the user is located.
  '19003': 'UNSUPPORTED_AREA',

  /// [Description:] Invalid app ID in the request.
  ///
  /// [Solution:] Verify that the app ID in the request is valid.
  '19004': 'INVALID_APPID_APPCHECK',

  /// [Description:] The HMS Core (APK) version on the user device does not support
  /// the Safety Detect service.
  ///
  /// [Solution:] Update HMS Core (APK) to the latest version.
  '19202': 'UNSUPPORTED_EMUI_VERSION',

  /// [Description:] The number of apps to check exceeds the maximum allowed by AppCheck.
  ///
  /// [Solution:] Reduce the number of apps to check.
  '19402': 'APPS_CHECK_FAILED_VIRUS_NUMBER_EXCEEDED',

  /// [Description:] A mandatory parameter in the request is empty.
  ///
  /// [Solution:] Verify that all mandatory parameters in the request are correctly set.
  '19150': 'PARAM_ERROR_EMPTY',

  /// [Description:] Parameter verification failed.
  ///
  /// [Solution:] Verify that parameters in the request are valid.
  '19151': 'PARAM_ERROR_INVALID',

  /// [Description:] An internal error occurred during app security check.
  ///
  /// [Solution:] Contact Huawei technical support.
  '19401': 'APPS_CHECK_INTERNAL_ERROR',

  /// [Description:] An internal error occurred during malicious URL check.
  ///
  /// [Solution:] Contact Huawei technical support.
  '19600': 'URL_CHECK_INNER_ERROR',

  /// [Description:] URLCheck initialization failed.
  ///
  /// [Solution:] Call the initUrlCheck() API first to initialize URLCheck.
  '19601': 'CHECK_WITHOUT_INIT',

  /// [Description:] The URLCheck API does not support the passed URL categories.
  /// Currently, Safety Detect can only identify phishing and malware URLs.
  ///
  /// [Solution:] Verify that the passed URL categories are valid.
  '19602': 'URL_CHECK_THREAT_TYPE_INVALID',

  /// [Description:] Invalid parameters for calling urlCheck.
  ///
  /// [Solution:] Verify that relevant parameters are valid.
  '19603': 'URL_CHECK_REQUEST_PARAM_INVALID',

  /// [Description:] The app ID passed for calling urlCheck is invalid.
  ///
  /// [Solution:] Verify that the passed app ID is valid.
  '19604': 'URL_CHECK_REQUEST_APPID_INVALID',

  /// [Description:] Fake user detection failed.
  ///
  /// [Solution:] Try again. If the detection fails for three times, risks exist.
  '19800': 'DETECT_FAIL',

  /// [Description:] Fake user detection timed out, for example, when the user enters the verification code.
  ///
  /// [Solution:] Try again.
  '19801': 'USER_DETECT_TIMEOUT',

  /// [Description:] The app ID passed for calling userDetection is invalid.
  ///
  /// [Solution:] Verify that the passed app ID is valid.
  '19802': 'USER_DETECT_INVALID_APPID',

  /// [Description:] Failed to initialize imperceptible fake user detection.
  ///
  /// [Solution:] Contact Huawei technical support.
  '19820': 'ANTI_FRAUD_INIT_FAIL',

  /// [Description:] The app ID passed to the initAntiFraud API is incorrect.
  ///
  /// [Solution:] Verify the passed parameter.
  '19821': 'ANTI_FRAUD_INIT_PARAM_INVALID',

  /// [Description:] Failed to obtain the risk token.
  ///
  /// [Solution:] Initialize the API again.
  '19830': 'RISK_TOKEN_GET_FAIL',

  /// [Description:] An internal error occurred on the API for obtaining a risk token.
  ///
  /// [Solution:] Contact Huawei technical support.
  '19831': 'RISK_TOKEN_INNER_ERROR',

  /// [Description:] Unkown error code.
  ///
  /// [Solution:] Contact Huawei technical support.
  '-1': 'UNKOWN_ERROR_STATUS_CODE'
};
