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

import 'dart:async';

import 'package:flutter/services.dart';

class HMSDTM {
  static MethodChannel _channel =
      new MethodChannel("com.huawei.hms.flutter.dtm/method")
        ..setMethodCallHandler(_methodCallHandler);
  static StreamController<Map<String, dynamic>> _controller =
      StreamController<Map<String, dynamic>>.broadcast();

  static Stream<Map<String, dynamic>> get customTagStream => _controller.stream;

  static Future<void> onEvent(String key, Map<String, dynamic> value) async {
    if (key == null || value == null) {
      throw ArgumentError.notNull("key | value");
    }
    dynamic params = {
      'key': key,
      'value': value,
    };
    await _channel.invokeMethod('onEvent', params);
  }

  static Future<void> setCustomVariable(String varName, dynamic value) async {
    dynamic params = {
      'varName': varName,
      'value': value,
    };
    await _channel.invokeMethod('setCustomVariable', params);
  }

  static Future<void> enableLogger() async {
    await _channel.invokeMethod('enableLogger');
  }

  static Future<void> disableLogger() async {
    await _channel.invokeMethod('disableLogger');
  }

  static Future<dynamic> _methodCallHandler(MethodCall call) async {
    if (call.method == 'listenToTags') {
      Map<dynamic, dynamic> decoded = call.arguments;
      Map<String, dynamic> map = Map.from(decoded);
      _controller.add(map);
    }
  }
}
