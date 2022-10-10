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

class HmsBioAuthnManager {
  final MethodChannel _channel =
      const MethodChannel('com.huawei.hms.flutter.fido/bio_authn_manager');

  /// Fingerprint authentication is available.
  /// (A valid fingerprint has been enrolled and
  /// the authentication hardware is available.)
  static const int BIO_AUTHN_SUCCESS = 0;

  /// No authentication hardware is available.
  static const int BIO_AUTHN_ERROR_HW_UNAVAILABLE = 1;

  /// No fingerprint is enrolled.
  static const int BIO_AUTHN_ERROR_NONE_ENROLLED = 11;

  /// No fingerprint authentication hardware is available.
  static const int BIO_AUTHN_ERROR_NO_HARDWARE = 12;

  /// Fingerprint authentication is not supported in this OS version.
  static const int BIO_AUTHN_ERROR_UNSUPPORTED_OS_VER = 1004;

  /// Checks whether fingerprint authentication is available.
  Future<int?> canAuth() async {
    return await _channel.invokeMethod('canAuth');
  }

  Future<void> enableLogger() async {
    await _channel.invokeMethod('enableLogger');
  }

  Future<void> disableLogger() async {
    await _channel.invokeMethod('disableLogger');
  }
  
}
