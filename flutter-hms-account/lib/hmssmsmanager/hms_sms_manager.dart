/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:flutter/services.dart';

const SMS_MANAGER_METHOD_CHANNEL = "com.huawei.hms.flutter.account/sms/manager";

typedef SmsListener({String message, String errorCode});

class HmsSmsManager {
  static MethodChannel _channel = init();
  static SmsListener _listener;

  static MethodChannel init() {
    MethodChannel channel = MethodChannel(SMS_MANAGER_METHOD_CHANNEL);
    channel.setMethodCallHandler(_handleSms);
    return channel;
  }

  /// If the plugin catches an sms message which is sent to the app before
  /// timing out, this method returns the message, otherwise it returns the error code
  static Future<dynamic> _handleSms(MethodCall call) {
    if (_listener != null) {
      if (call.method == "timeOut") {
        String errorCode = call.arguments["errorCode"];
        _listener(errorCode: errorCode);
        _listener = null;
      } else if (call.method == "readSms") {
        _listener(message: call.arguments["message"] ?? "empty");
        _listener = null;
      }
    }

    return Future<dynamic>.value(null);
  }

  /// Starts listening upcoming sms messages to the app before timing out.
  static Future<void> smsVerification(SmsListener listener) async {
    _listener = listener;
    await _channel.invokeMethod('smsVerification');
  }

  /// This method gets the application's unique hashcode value.
  /// It is used in sms verification for messages to be recognized by the app.
  static Future<String> obtainHashcode() async {
    return await _channel.invokeMethod("obtainHashcode");
  }
}
