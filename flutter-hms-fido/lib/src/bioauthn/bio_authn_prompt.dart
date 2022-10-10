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

class HmsBioAuthnPrompt {
  final MethodChannel _channel =
      const MethodChannel('com.huawei.hms.flutter.fido/bio_authn_prompt');

  int get id => hashCode;
  late EventChannel _eventChannel;
  BioAuthnCallback? _callback;
  StreamSubscription<dynamic>? _subscription;

  HmsBioAuthnPrompt() {
    _eventChannel =
        EventChannel('com.huawei.hms.flutter.fido/bio_authn_prompt/$id');
  }

  /// No authentication hardware is available.
  static const int ERROR_HW_UNAVAILABLE = 1;

  /// The sensor cannot process the current fingerprint image.
  static const int ERROR_UNABLE_TO_PROCESS = 2;

  /// The current request timed out. The timeout mechanism prevents infinite
  /// waiting for the fingerprint sensor's response.
  /// The timeout interval varies depending on the user device and sensor.
  /// Generally, the timeout interval is 30 seconds.
  static const int ERROR_TIMEOUT = 3;

  /// The storage space is insufficient for the operation such as registration.
  static const int ERROR_NO_SPACE = 4;

  /// The operation is canceled because the fingerprint authentication sensor
  /// is unavailable.
  static const int ERROR_CANCELED = 5;

  /// The operation is canceled because the API is locked when the number of
  /// attempts reaches the maximum.
  /// The API will be locked for 30 seconds after five consecutive
  /// attempt failures.
  static const int ERROR_LOCKOUT = 7;

  /// Vendor-defined errors.
  static const int ERROR_VENDOR = 8;

  /// The operation is canceled because the number of
  /// fingerprint authentication locking times reaches the maximum.
  /// Then, fingerprint authentication is disabled until the user is
  /// authenticated in a stronger authentication mode,
  /// including PIN, pattern, and password authentication.
  static const int ERROR_LOCKOUT_PERMANENT = 9;

  /// The operation is canceled. After receiving this error code, your app
  /// should use the standby authentication mode,
  /// for example, password authentication. Your app also needs
  /// to provide a way,
  /// such as a button, for using fingerprint authentication again.
  static const int ERROR_USER_CANCELED = 10;

  /// No fingerprint is enrolled.
  static const int ERROR_NO_BIOMETRICS = 11;

  /// The device is not equipped with a fingerprint sensor.
  static const int ERROR_HW_NOT_PRESENT = 12;

  /// The user cancels the operation.
  static const int ERROR_NEGATIVE_BUTTON = 13;

  /// No PIN, pattern, and password are set for unlocking the device.
  static const int ERROR_NO_DEVICE_CREDENTIAL = 14;

  /// The device failed the system integrity check, for example,
  /// the device has been rooted,
  /// the device ROM has been flashed, or the system has been damaged.
  static const int ERROR_SYS_INTEGRITY_FAILED = 1001;

  /// The fingerprint authentication result failed the key-based encryption
  /// verification.
  static const int ERROR_CRYPTO_VERIFY_FAILED = 1002;

  /// An HMS Core framework error occurred.
  static const int ERROR_HMS_FRAMEWORK_ERROR = 1003;

  /// Fingerprint authentication is not supported in this OS version.
  /// Fingerprint authentication of FIDO BioAuthn can only be used on
  /// devices running EMUI 5.0.0 or later.
  static const int ERROR_UNSUPPORTED_OS_VER = 1004;

  void setCallback(BioAuthnCallback callback) {
    _callback = callback;
  }

  Future<bool?> configurePrompt(HmsBioAuthnPromptInfo info) async {
    info.setId(id);
    return await _channel.invokeMethod('initPrompt', info.toMap());
  }

  Future<void> authenticateWithoutCryptoObject() async {
    _startCallback();
    await _channel.invokeMethod('authenticateWithoutCryptoObject');
  }

  Future<void> authenticateWithCryptoObject(HmsCipherFactory factory) async {
    _startCallback();
    await _channel.invokeMethod(
        'authenticateWithCryptoObject', factory.toMap());
  }

  Future<bool?> cancelAuth() async {
    _subscription?.cancel();
    return await _channel.invokeMethod('cancel');
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
