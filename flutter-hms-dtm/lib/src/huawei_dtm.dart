/*
 * Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

part of huawei_dtm;

abstract class HMSDTM {
  static final MethodChannel _channel =
      const MethodChannel('com.huawei.hms.flutter.dtm/method')
        ..setMethodCallHandler(_methodCallHandler);
  static final StreamController<Map<String, dynamic>> _controller =
      StreamController<Map<String, dynamic>>.broadcast();

  /// Returns a stream which can be used to listen to the triggered Custom Tags.
  static Stream<Map<String, dynamic>> get customTagStream => _controller.stream;

  /// Records events.
  static Future<void> onEvent(String key, Map<String, dynamic> value) async {
    await _channel.invokeMethod(
      'onEvent',
      <String, dynamic>{
        'key': key,
        'value': value,
      },
    );
  }

  /// Sets the value that will be returned for a custom variable created in
  /// the DTM console.
  static Future<void> setCustomVariable(String varName, dynamic value) async {
    await _channel.invokeMethod(
      'setCustomVariable',
      <String, dynamic>{
        'varName': varName,
        'value': value,
      },
    );
  }

  /// Enables the HMSLogger capability which is used for sending usage
  /// analytics of DTM SDK's methods to improve the service quality.
  static Future<void> enableLogger() async {
    await _channel.invokeMethod(
      'enableLogger',
    );
  }

  /// Disables the HMSLogger capability which is used for sending usage
  /// analytics of DTM SDK's methods to improve the service quality.
  static Future<void> disableLogger() async {
    await _channel.invokeMethod(
      'disableLogger',
    );
  }

  static Future<dynamic> _methodCallHandler(MethodCall call) async {
    if (call.method == 'listenToTags') {
      final Map<dynamic, dynamic> decoded = call.arguments;
      _controller.add(Map<String, dynamic>.from(decoded));
    }
  }
}
