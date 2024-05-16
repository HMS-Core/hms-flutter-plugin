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

part of huawei_account;

typedef SmsListener = Function({
  String? message,
  String? errorCode,
});

@Deprecated('')
class ReadSmsManager {
  static final MethodChannel _c = init();
  static SmsListener? _listener;

  static MethodChannel init() {
    MethodChannel channel = const MethodChannel(_SMS_MANAGER);
    channel.setMethodCallHandler(_handleSms);
    return channel;
  }

  static Future<dynamic> _handleSms(MethodCall call) {
    if (_listener != null) {
      switch (call.method) {
        case 'timeOut':
          _listener!(
            errorCode: call.arguments['errorCode'],
          );
          _listener = null;
          break;
        case 'failed':
          _listener!(
            errorCode: call.arguments['errorCode'],
          );
          _listener = null;
          break;
        case 'readSms':
          _listener!(
            message: call.arguments['message'] ?? 'empty',
          );
          _listener = null;
          break;
        default:
          break;
      }
    }
    return Future<dynamic>.value(null);
  }

  /// Enables the service of reading SMS messages until the SMS messages that
  /// meet the rules are obtained or the service times out (the timeout duration is 5 minutes).
  static void start(
    SmsListener listener,
  ) {
    _listener = listener;
    _c.invokeMethod(
      'smsVerification',
    );
  }

  /// Enables the service of reading SMS messages until the SMS messages that
  /// meet the rules are obtained or the service times out (the timeout duration is 5 minutes).
  static void startConsent(
    SmsListener listener, [
    String? phoneNumber,
  ]) {
    _listener = listener;
    _c.invokeMethod(
      'smsWithPhoneNumber',
      <String, dynamic>{
        'phoneNumber': phoneNumber,
      },
    );
  }

  /// Gets the application's unique code for sms verification.
  static Future<String> obtainHashcode() async {
    return await _c.invokeMethod(
      'obtainHashcode',
    );
  }
}
