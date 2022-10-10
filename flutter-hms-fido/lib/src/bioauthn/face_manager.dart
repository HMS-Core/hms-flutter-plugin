/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_fido;

class HmsFaceManager {
  final MethodChannel _channel =
      const MethodChannel('com.huawei.hms.flutter.fido/face_manager');

  int get id => hashCode;
  late EventChannel _eventChannel;
  BioAuthnCallback? _callback;
  StreamSubscription<dynamic>? _subscription;

  HmsFaceManager() {
    _eventChannel =
        EventChannel('com.huawei.hms.flutter.fido/face_manager/$id');
  }

  /// 3D facial authentication is available.
  static const int FACE_SUCCESS = 0;

  /// No authentication hardware is available.
  static const int FACE_ERROR_HW_UNAVAILABLE = 1;

  /// The sensor cannot process the current face image.
  static const int FACE_ERROR_UNABLE_TO_PROCESS = 2;

  /// The request timed out.
  static const int FACE_ERROR_TIMEOUT = 3;

  /// The storage space is insufficient for registration.
  static const int FACE_ERROR_NO_SPACE = 4;

  /// The operation is canceled because the 3D facial authentication sensor is
  /// unavailable.
  static const int FACE_ERROR_CANCELED = 5;

  /// Failed to delete 3D face data.
  static const int FACE_ERROR_UNABLE_TO_REMOVE = 6;

  /// The number of unlocking attempts reaches the maximum.
  static const int FACE_ERROR_LOCKOUT = 7;

  /// Vendor-defined errors.
  static const int FACE_ERROR_VENDOR = 8;

  /// 3D facial authentication is disabled.
  static const int FACE_ERROR_LOCKOUT_PERMANENT = 9;

  /// The user cancels the authentication.
  static const int FACE_ERROR_USER_CANCELED = 10;

  /// No 3D facial authentication template is registered before authentication.
  static const int FACE_ERROR_NOT_ENROLLED = 11;

  /// The device does not have a 3D facial authentication sensor.
  static const int FACE_ERROR_HW_NOT_PRESENT = 12;

  /// Start result code of vendor-defined errors.
  static const int FACE_ERROR_VENDOR_BASE = 1000;

  /// The device failed the system integrity check, for example,
  /// the device has been rooted or the system integrity has been damaged.
  static const int FACE_ERROR_SYS_INTEGRITY_FAILED = 1001;

  /// 3D facial authentication is not supported in this OS version.
  /// 3D facial authentication of FIDO BioAuthn can only be used on devices
  /// running EMUI 10.0.0 or later.
  static const int FACE_ERROR_UNSUPPORTED_OS_VER = 1002;

  /// An HMS Core framework error occurred.
  static const int FACE_ERROR_HMS_FRAMEWORK_ERROR = 1003;

  /// The obtained face image is clear.
  static const int FACE_ACQUIRED_GOOD = 0;

  /// The face image does not meet the processing requirements.
  static const int FACE_ACQUIRED_INSUFFICIENT = 1;

  /// The obtained face image is too bright due to high illumination.
  static const int FACE_ACQUIRED_TOO_BRIGHT = 2;

  /// The obtained face image is too dark due to low illumination.
  static const int FACE_ACQUIRED_TOO_DARK = 3;

  /// The face position is too close to the user device.
  static const int FACE_ACQUIRED_TOO_CLOSE = 4;

  /// The face position is too far away from the user device.
  static const int FACE_ACQUIRED_TOO_FAR = 5;

  /// The user device position is too high, and only the top part of the
  /// face is obtained.
  static const int FACE_ACQUIRED_TOO_HIGH = 6;

  /// The user device position is too low, and only the bottom part of the
  /// face is obtained.
  static const int FACE_ACQUIRED_TOO_LOW = 7;

  /// The user device position is to the right, and only the right part of the
  /// face is obtained.
  static const int FACE_ACQUIRED_TOO_RIGHT = 8;

  /// The user device position is to the left, and only the left part of the
  /// face is obtained.
  static const int FACE_ACQUIRED_TOO_LEFT = 9;

  /// The face moves too frequently during image collection.
  static const int FACE_ACQUIRED_TOO_MUCH_MOTION = 10;

  /// The user's focus is too far away from the sensor, and an important part
  /// of the user's face is not detected.
  static const int FACE_ACQUIRED_POOR_GAZE = 11;

  /// The sensor detects no face.
  static const int FACE_ACQUIRED_NOT_DETECTED = 12;

  /// Vendor-defined errors.
  static const int FACE_ACQUIRED_VENDOR = 13;

  /// A 3D face was detected. (BioAuthnCallback#onAuthHelp)
  static const int FACE_ACQUIRED_VENDOR_1038 = 1038;

  /// The face does not match the enrolled one. (BioAuthnCallback#onAuthHelp)
  static const int FACE_ACQUIRED_VENDOR_1012 = 1012;

  void setCallback(BioAuthnCallback callback) {
    _callback = callback;
  }

  Future<bool?> init() async {
    return await _channel.invokeMethod('init', <String, dynamic>{'id': id});
  }

  Future<int?> canAuth() async {
    return await _channel.invokeMethod('canAuth');
  }

  Future<bool?> isHardwareDetected() async {
    return await _channel.invokeMethod('isHardwareDetected');
  }

  Future<bool?> hasEnrolledTemplates() async {
    return await _channel.invokeMethod('hasEnrolledTemplates');
  }

  Future<void> authWithoutCryptoObject() async {
    _startCallback();
    await _channel.invokeMethod('authenticateWithoutCryptoObject');
  }

  Future<void> authWithCryptoObject(HmsCipherFactory factory) async {
    _startCallback();
    await _channel.invokeMethod(
        'authenticateWithCryptoObject', factory.toMap());
  }

  Future<int?> getFaceModality() async {
    return await _channel.invokeMethod('getFaceModality');
  }

  void _startCallback() {
    _subscription?.cancel();
    _subscription =
        _eventChannel.receiveBroadcastStream(id).listen((dynamic event) {
      Map<dynamic, dynamic> map = event;
      BioAuthnEvent? bioAuthnEvent = Fido2PluginUtil.toBioEvent(map['event']);
      if (bioAuthnEvent == BioAuthnEvent.onAuthError) {
        _callback?.call(bioAuthnEvent, errCode: map['msgCode']);
      } else if (bioAuthnEvent == BioAuthnEvent.onAuthSucceeded) {
        _callback?.call(
          bioAuthnEvent,
          result: map['result'] != null
              ? HmsBioAuthnResult.fromMap(map['result'])
              : null,
        );
      } else {
        _callback?.call(bioAuthnEvent);
      }
    });
  }
}
