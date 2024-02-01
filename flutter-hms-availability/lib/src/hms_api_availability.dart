/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_hmsavailability;

class HmsApiAvailability {
  /// Package name of HMS Core (APK).
  static const String SERVICES_PACKAGE = 'com.huawei.hwid';

  /// Action of the service of HMS Core (APK).
  static const String SERVICES_ACTION = 'com.huawei.hms.core.aidlservice';

  /// Name of the activity of HMS Core (APK).
  static const String ACTIVITY_NAME =
      'com.huawei.hms.core.activity.JumpActivity';

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
  static const String HMS_API_NAME_ID = 'HuaweiID.API';

  /// Version number of the HUAWEI ID service.
  static const int HMS_VERSION_CODE_ID = 30000000;

  /// API name of the SNS service.
  static const String HMS_API_NAME_SNS = 'HuaweiSns.API';

  /// Version number of the SNS service.
  static const int HMS_VERSION_CODE_SNS = 20503000;

  /// API name of the HUAWEI Pay service.
  static const String HMS_API_NAME_PAY = 'HuaweiPay.API';

  /// Version number of the HUAWEI Pay service.
  static const int HMS_VERSION_CODE_PAY = 20503000;

  /// API name of the HUAWEI Push service.
  static const String HMS_API_NAME_PUSH = 'HuaweiPush.API';

  /// Version number of the HUAWEI Push service.
  static const int HMS_VERSION_CODE_PUSH = 20503000;

  /// API name of the HUAWEI Game service.
  static const String HMS_API_NAME_GAME = 'HuaweiGame.API';

  /// Version number of the HUAWEI Game service.
  static const int HMS_VERSION_CODE_GAME = 20503000;

  /// API name of the open device service.
  static const String HMS_API_NAME_OD = 'HuaweiOpenDevice.API';

  /// Version number of the open device service.
  static const int HMS_VERSION_CODE_OD = 20601000;

  /// API name of the HUAWEI IAP service.
  static const String HMS_API_NAME_IAP = 'HuaweiIap.API';

  /// Version number of the HUAWEI IAP service.
  static const int HMS_VERSION_CODE_IAP = 20700300;

  /// API name of the HUAWEI PPS service.
  static const String HMS_API_NAME_PPS = 'HuaweiPPSkit.API';

  /// Version number of the HUAWEI PPS service.
  static const int HMS_VERSION_CODE_PPS = 20700300;

  /// Version number of the HMS Core SDK.
  static const int HMS_SDK_VERSION_CODE = 60400303;

  /// Version name of the HMS Core SDK.
  static const String HMS_SDK_VERSION_NAME = '6.12.0.300';

  /// Specified parameter is null.
  static const String NULL_PARAMETER = '0011';

  /// Attempted to use [destroyStreams] method without initializing the streams
  static const String OBJECT_NOT_INITIALIZED = '0012';

  final MethodChannel _methodChannel = const MethodChannel(
    'com.huawei.hms.flutter.availability/hms/method',
  );

  late EventChannel _eventChannel;
  AvailabilityResultListener? _listener;
  StreamSubscription<dynamic>? _subscription;

  HmsApiAvailability() {
    _eventChannel = const EventChannel(
      'com.huawei.hms.flutter.availability/hms/event',
    );
    setupStreams();
  }

  /// Sets up streams for activity results and on dialog cancellations.
  void setupStreams() {
    _methodChannel.invokeMethod('initStreams');
  }

  /// Sets an [AvailabilityResultListener] for activity results and on dialog cancellations.
  set setResultListener(AvailabilityResultListener listener) {
    _listener = listener;
  }

  /// Obtains the API version number of each service.
  Future<Map<dynamic, dynamic>> getApiMap() async {
    return await _methodChannel.invokeMethod(
      'getApiMap',
    );
  }

  /// Obtains the minimum version number of HMS Core that is supported currently.
  Future<int?> getServicesVersionCode() async {
    return await _methodChannel.invokeMethod(
      'getServicesVersionCode',
    );
  }

  /// Checks whether HMS Core (APK) is successfully installed and integrated on a device,
  /// and whether the version of the installed APK is that required by the
  /// client or is later than the required version.
  Future<int> isHMSAvailable() async {
    return await _methodChannel.invokeMethod(
      'isHmsAvailable',
    );
  }

  /// Checks whether HMS Core (APK) is successfully installed and integrated on a device,
  /// and whether the version of the installed APK is that required by the
  /// client or is later than the required version.
  Future<int> isHMSAvailableWithApkVersion(int minApkVersion) async {
    return await _methodChannel.invokeMethod(
      'isHmsAvailableMinApk',
      <String, dynamic>{
        'minApkVersion': minApkVersion,
      },
    );
  }

  /// Checks whether the HMS Core (APK) version supports notice obtaining.
  Future<int> isHuaweiMobileNoticeAvailable() async {
    return await _methodChannel.invokeMethod(
      'isHuaweiMobileNoticeAvailable',
    );
  }

  /// Checks whether an exception is rectified through user operations.
  Future<bool> isUserResolvableError(
    int errorCode, [
    bool? usePendingIntent,
  ]) async {
    return await _methodChannel.invokeMethod(
      'isUserResolvableError',
      <String, dynamic>{
        'errorCode': errorCode,
        'usePendingIntent': usePendingIntent,
      },
    );
  }

  /// Displays a notification or dialog box is displayed for the
  /// returned result code if an exception can be rectified through user operations.
  void resolveError(
    int errorCode,
    int requestCode, [
    bool? usePendingIntent,
  ]) {
    _getEvents();
    _methodChannel.invokeMethod(
      'resolveError',
      <String, dynamic>{
        'errCode': errorCode,
        'reqCode': requestCode,
        'usePendingIntent': usePendingIntent,
      },
    );
  }

  /// Displays a notification or dialog box for the result code returned
  /// by the [isHMSAvailableWithApkVersion] method.
  void getErrorDialog(
    int errorCode,
    int requestCode, [
    bool? useCancelListener,
  ]) {
    _getEvents();
    _methodChannel.invokeMethod(
      'getErrorDialog',
      <String, dynamic>{
        'errCode': errorCode,
        'reqCode': requestCode,
        'useCancelListener': useCancelListener,
      },
    );
  }

  /// Displays a readable text result code returned
  /// by the [isHMSAvailableWithApkVersion] method.
  Future<String> getErrorString(int errorCode) async {
    return await _methodChannel.invokeMethod(
      'getErrorString',
      <String, dynamic>{
        'errCode': errorCode,
      },
    );
  }

  /// Creates and displays a dialog box for a result code.
  Future<bool> showErrorDialogFragment(
    int errorCode,
    int requestCode, [
    bool? useCancelListener,
  ]) async {
    _getEvents();
    return await _methodChannel.invokeMethod(
      'showErrorDialogFragment',
      <String, dynamic>{
        'errCode': errorCode,
        'reqCode': requestCode,
        'useCancelListener': useCancelListener,
      },
    );
  }

  /// Creates and displays a dialog box for a result code.
  void showErrorNotification(int errorCode) {
    _methodChannel.invokeMethod(
      'showErrorNotification',
      <String, dynamic>{
        'errCode': errorCode,
      },
    );
  }

  /// Destroys the event channel and stream handler.
  Future<bool> destroyStreams() async {
    _subscription?.cancel();
    return await _methodChannel.invokeMethod(
      'dispose',
    );
  }

  void _getEvents() {
    _subscription?.cancel();
    _subscription = _eventChannel.receiveBroadcastStream().listen(
      (dynamic msg) {
        AvailabilityEvent? availabilityEvent = toAvailabilityEvent(msg);
        _listener?.call(availabilityEvent);
      },
    );
  }
}
