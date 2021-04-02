/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'availability_utils.dart';

const String HMS_METHOD = "com.huawei.hms.flutter.availability/hms/method";
const String HMS_EVENT = "com.huawei.hms.flutter.availability/hms/event";

class HmsApiAvailability {
  final MethodChannel _channel = MethodChannel(HMS_METHOD);

  /// Package name of HMS Core (APK).
  static const String SERVICES_PACKAGE = "com.huawei.hwid";

  /// Action of the service of HMS Core (APK).
  static const String SERVICES_ACTION = "com.huawei.hms.core.aidlservice";

  /// Name of the activity of HMS Core (APK).
  static const String ACTIVITY_NAME =
      "com.huawei.hms.core.activity.JumpActivity";

  /// Version of HMS Core (APK) required by the client to obtain notices.
  static const int NOTICE_VERSION_CODE = 20600000;

  /// Earliest HMS Core (APK) version required by each service.
  static const int HMS_VERSION_MIN = 20503000;

  /// Earliest HMS Core (APK) version required by each service of the JSON version.
  static const int HMS_JSON_VERSION_MIN = 30000000;

  /// Latest version that can be configured for a developer.
  static const int HMS_VERSION_MAX = 20600000;

  /// Earliest version that can be configured for a developer.
  static const int HMS_VERSION_CODE_MIN = 20503000;

  /// API name of the HUAWEI ID service.
  static const String HMS_API_NAME_ID = "HuaweiID.API";

  /// Version number of the HUAWEI ID service.
  static const int HMS_VERSION_CODE_ID = 30000000;

  /// API name of the SNS service.
  static const String HMS_API_NAME_SNS = "HuaweiSns.API";

  /// Version number of the SNS service.
  static const int HMS_VERSION_CODE_SNS = 20503000;

  /// API name of the HUAWEI Pay service.
  static const String HMS_API_NAME_PAY = "HuaweiPay.API";

  /// Version number of the HUAWEI Pay service.
  static const int HMS_VERSION_CODE_PAY = 20503000;

  /// API name of the HUAWEI Push service.
  static const String HMS_API_NAME_PUSH = "HuaweiPush.API";

  /// Version number of the HUAWEI Push service.
  static const int HMS_VERSION_CODE_PUSH = 20503000;

  /// API name of the HUAWEI Game service.
  static const String HMS_API_NAME_GAME = "HuaweiGame.API";

  /// Version number of the HUAWEI Game service.
  static const int HMS_VERSION_CODE_GAME = 20503000;

  /// API name of the open device service.
  static const String HMS_API_NAME_OD = "HuaweiOpenDevice.API";

  /// Version number of the open device service.
  static const int HMS_VERSION_CODE_OD = 20601000;

  /// API name of the HUAWEI IAP service.
  static const String HMS_API_NAME_IAP = "HuaweiIap.API";

  /// Version number of the HUAWEI IAP service.
  static const int HMS_VERSION_CODE_IAP = 20700300;

  /// API name of the HUAWEI PPS service.
  static const String HMS_API_NAME_PPS = "HuaweiPPSkit.API";

  /// Version number of the HUAWEI PPS service.
  static const int HMS_VERSION_CODE_PPS = 20700300;

  /// Version number of the HMS Core SDK.
  static const int HMS_SDK_VERSION_CODE = 50100300;

  /// Version name of the HMS Core SDK.
  static const String HMS_SDK_VERSION_NAME = "5.1.0.300";

  /// Specified parameter is null.
  static const String NULL_PARAMETER = "0011";

  /// Attempted to use [destroyStreams] method without initializing the streams
  static const String OBJECT_NOT_INITIALIZED = "0012";

  EventChannel _eventChannel;
  AvailabilityResultListener _listener;
  StreamSubscription _subscription;

  HmsApiAvailability() {
    _eventChannel = EventChannel(HMS_EVENT);
    setupStreams();
  }

  /// Sets up streams for activity results and on dialog cancellations.
  void setupStreams() {
    _channel.invokeMethod("initStreams");
  }

  /// Sets an [AvailabilityResultListener] for activity results and on dialog cancellations.
  set setResultListener(AvailabilityResultListener listener) {
    _listener = listener;
  }

  /// Obtains the API version number of each service.
  Future<Map<dynamic, dynamic>> getApiMap() {
    return _channel.invokeMethod("getApiMap");
  }

  /// Obtains the minimum version number of HMS Core that is supported currently.
  Future<int> getServicesVersionCode() {
    return _channel.invokeMethod("getServicesVersionCode");
  }

  /// Checks whether HMS Core (APK) is successfully installed and integrated on a device,
  /// and whether the version of the installed APK is that required by the
  /// client or is later than the required version.
  Future<int> isHMSAvailable() {
    return _channel.invokeMethod("isHmsAvailable");
  }

  /// Checks whether HMS Core (APK) is successfully installed and integrated on a device,
  /// and whether the version of the installed APK is that required by the
  /// client or is later than the required version.
  ///
  /// Throws an [ArgumentError] if the [minApkVersion] is null.
  Future<int> isHMSAvailableWithApkVersion(int minApkVersion) {
    checkArguments([minApkVersion]);

    return _channel
        .invokeMethod("isHmsAvailableMinApk", {'minApkVersion': minApkVersion});
  }

  /// Checks whether the HMS Core (APK) version supports notice obtaining.
  Future<int> isHuaweiMobileNoticeAvailable() {
    return _channel.invokeMethod("isHuaweiMobileNoticeAvailable");
  }

  /// Checks whether an exception is rectified through user operations.
  ///
  /// Throws an [ArgumentError] if the [errorCode] is null.
  Future<bool> isUserResolvableError(int errorCode, [bool usePendingIntent]) {
    checkArguments([errorCode]);

    return _channel.invokeMethod("isUserResolvableError",
        {'errorCode': errorCode, 'usePendingIntent': usePendingIntent ?? null});
  }

  /// Displays a notification or dialog box is displayed for the
  /// returned result code if an exception can be rectified through user operations.
  ///
  /// Throws an [ArgumentError] if [errorCode] and [requestCode] are null.
  void resolveError(int errorCode, int requestCode, [bool usePendingIntent]) {
    checkArguments([errorCode, requestCode]);

    _getEvents();

    _channel.invokeMethod("resolveError", {
      'errCode': errorCode,
      'reqCode': requestCode,
      'usePendingIntent': usePendingIntent ?? null
    });
  }

  /// Displays a notification or dialog box for the result code returned
  /// by the [isHMSAvailableWithApkVersion] method.
  ///
  /// Throws an [ArgumentError] if [errorCode] and [requestCode] are null.
  void getErrorDialog(int errorCode, int requestCode,
      [bool useCancelListener]) {
    checkArguments([errorCode, requestCode]);

    _getEvents();

    _channel.invokeMethod("getErrorDialog", {
      'errCode': errorCode,
      'reqCode': requestCode,
      'useCancelListener': useCancelListener ?? null
    });
  }

  /// Displays a readable text result code returned
  /// by the [isHMSAvailableWithApkVersion] method.
  ///
  /// Throws an [ArgumentError] if [errorCode] is null.
  Future<String> getErrorString(int errorCode) {
    checkArguments([errorCode]);

    return _channel.invokeMethod("getErrorString", {'errCode': errorCode});
  }

  /// Creates and displays a dialog box for a result code.
  ///
  /// Throws an [ArgumentError] if [errorCode] and [requestCode] are null.
  Future<bool> showErrorDialogFragment(int errorCode, int requestCode,
      [bool useCancelListener]) {
    checkArguments([errorCode, requestCode]);

    _getEvents();

    return _channel.invokeMethod("showErrorDialogFragment", {
      'errCode': errorCode,
      'reqCode': requestCode,
      'useCancelListener': useCancelListener ?? null
    });
  }

  /// Creates and displays a dialog box for a result code.
  ///
  /// Throws an [ArgumentError] if the [errorCode] is null.
  void showErrorNotification(int errorCode) {
    checkArguments([errorCode]);

    _channel.invokeMethod("showErrorNotification", {'errCode': errorCode});
  }

  /// Destroys the event channel and stream handler.
  Future<bool> destroyStreams() async {
    _subscription?.cancel();
    return await _channel.invokeMethod("dispose");
  }

  void _getEvents() {
    _subscription?.cancel();
    _subscription = _eventChannel.receiveBroadcastStream().listen((msg) {
      AvailabilityEvent availabilityEvent = toAvailabilityEvent(msg);
      _listener?.call(availabilityEvent);
    });
  }
}
