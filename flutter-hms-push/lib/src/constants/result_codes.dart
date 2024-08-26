/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_push.dart';

const Map<String, String> resultCodes = <String, String>{
  /// Success
  '0': 'RESULT_SUCCESS',

  /// Error
  '-1': 'ERROR',

  /// Bundle is null, exception
  '333': 'NULL_BUNDLE',

  /// You do not have a token. Apply for a token.
  '907122030': 'ERROR_NO_TOKEN',

  /// The current network is unavailable. Check the network connection.
  '907122031': 'ERROR_NO_NETWORK',

  /// The token has expired. Delete the token and apply for a new one.
  '907122032': 'ERROR_TOKEN_INVALID',

  /// Unknown error. Contact Huawei technical support.
  '907122045': 'ERROR_UNKNOWN',

  /// If the Push service is unavailable, contact Huawei technical support.
  '907122046': 'ERROR_SERVICE_NOT_AVAILABLE',

  /// If the Push server returns an error, contact Huawei technical support.
  '907122047': 'ERROR_PUSH_SERVER',

  /// The number of subscribed topics exceeds 2000.
  '907122034': 'ERROR_TOPIC_EXCEED',

  /// Failed to send the subscription topic. Contact Huawei technical support.
  '907122035': 'ERROR_TOPIC_SEND',

  /// Push rights are not enabled. Enable the service and set push service parameters at AppGallery Connect.
  '907122036': 'ERROR_NO_RIGHT',

  /// Failed to apply for the token. Contact Huawei technical support.
  '907122037': 'ERROR_GET_TOKEN_ERR',

  /// No storage location is selected for the application or the storage location is invalid.
  /// Select a correct storage location for your app in AppGallery Connect.
  '907122038': 'ERROR_STORAGE_LOCATION_EMPTY',

  /// Failed to apply for a token. Cross-region token application is not allowed.
  '907122053': 'ERROR_NOT_ALLOW_CROSS_APPLY',

  /// The message body size exceeds the maximum. (1 KB)
  '907122041': 'ERROR_SIZE',

  /// The message contains invalid parameters.
  '907122042': 'ERROR_INVALID_PARAMETERS',

  /// The number of sent messages reaches the upper limit. The messages will be discarded.
  '907122043': 'ERROR_TOO_MANY_MESSAGES',

  /// The message lifetime expires before the message is successfully sent to the APP server.
  '907122044': 'ERROR_TTL_EXCEEDED',

  /// Huawei Mobile Services (APK) can't connect  Huawei Push  Kit.
  '907122048': 'ERROR_HMS_CLIENT_API',

  /// The current EMUI version is too early to use the capability.
  '907122049': 'ERROR_OPERATION_NOT_SUPPORTED',

  /// The operation cannot be performed in the main thread.
  '907122050': 'ERROR_MAIN_THREAD',

  /// Failed to authenticate the device certificate.
  '907122051': 'ERROR_HMS_DEVICE_AUTH_FAILED_SELF_MAPPING',

  /// Failed to bind the service.
  '907122052': 'ERROR_BIND_SERVICE_SELF_MAPPING',

  /// The SDK is being automatically initialized. Try again later.
  '907122054': 'ERROR_AUTO_INITIALIZING',

  /// The system is busy. Please try again later.
  '907122055': 'ERROR_RETRY_LATER',

  /// Failed to send an uplink message.
  '907122056': 'ERROR_SEND',

  /// The message is discarded because the number of cached uplink messages sent by the app exceeds the threshold (20).
  '907122058': 'ERROR_CACHE_SIZE_EXCEED',

  /// The uplink message sent by the app is cached due to a cause such as network unavailability.
  '907122059': 'ERROR_MSG_CACHE',

  /// The app server is offline.
  '907122060': 'ERROR_APP_SERVER_NOT_ONLINE',

  /// Flow control is performed because the frequency for the app to send uplink messages is too high.
  '907122061': 'ERROR_OVER_FLOW_CONTROL_SIZE',

  /// The input parameter is incorrect. Check whether the related configuration information is correct.
  /// Example: app_id in the agconnect - services.json file;
  /// Check whether the build.gradle file is configured with the certificate signature.
  '907135000': 'ERROR_ARGUMENTS_INVALID',

  /// Internal Push error. Contact Huawei technical support engineers.
  '907135001': 'ERROR_INTERNAL_ERROR',

  /// The API required by the Push SDK does not exist or the API instance fails to be created.
  '907135002': 'ERROR_NAMING_INVALID',

  /// The HMS Core SDK fails to connect to the HMS Core (APK).
  ///
  /// The possible cause is that the HMS Core process is stopped or crashed. Try again later.
  '907135003': 'ERROR_CLIENT_API_INVALID',

  /// Invoking AIDL times out. Contact Huawei technical support.
  '907135004': 'ERROR_EXECUTE_TIMEOUT',

  /// The current area does not support this service.
  '907135005': 'ERROR_NOT_IN_SERVICE',

  /// If the AIDL connection session is invalid, contact Huawei technical support.
  '907135006': 'ERROR_SESSION_INVALID',

  /// Failed to invoke the gateway to query the application scope.
  /// Check whether the current app has been created and enabled in AppGallery Connect.
  /// If yes, contact Huawei technical support.
  '907135700': 'ERROR_GET_SCOPE_ERROR',

  /// Scope is not configured on the AppGallery Connect.
  /// Check whether the current app has been created and enabled in AppGallery Connect.
  /// If yes, contact Huawei technical support.
  '907135701': 'ERROR_SCOPE_LIST_EMPTY',

  /// The certificate fingerprint is not configured on the AppGallery Connect.
  /// 1. Check whether your phone can access the Internet.
  /// 2. Check whether the correct certificate fingerprint is configured in AppGallery Connect. For details, see AppGallery Connect configuration in Development Preparations.
  /// 3. If the check result is correct, contact Huawei technical support.
  '907135702': 'ERROR_CERT_FINGERPRINT_EMPTY',

  /// Permission is not configured on the AppGallery Connect.
  '907135703': 'ERROR_PERMISSION_LIST_EMPTY',

  /// The authentication information of the application does not exist.
  '6002': 'ERROR_AUTH_INFO_NOT_EXIST',

  /// An error occurred during certificate fingerprint verification. Check whether the correct certificate fingerprint is configured in AppGallery Connect. For details, see AppGallery Connect configuration in Development Preparations.
  '6003': 'ERROR_CERT_FINGERPRINT_ERROR',

  /// Interface authentication: The permission does not exist and is not applied for in AppGallery Connect.
  '6004': 'ERROR_PERMISSION_NOT_EXIST',

  /// Interface authentication: unauthorized.
  '6005': 'ERROR_PERMISSION_NOT_AUTHORIZED',

  /// Interface authentication: The authorization expires.
  '6006': 'ERROR_PERMISSION_EXPIRED',
};
