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

part of '../../huawei_ml_body.dart';

class MLInteractiveLivenessCapture {
  late MethodChannel _channel;

  MLInteractiveLivenessCapture() {
    _channel = const MethodChannel('$baseChannel.interactiveLiveness');
  }

  /// detectionTimeOut: Timeout interval for interactive biometric verification, in milliseconds.
  Future<Stream<MLInteractiveLivenessCaptureResult>> startDetect({
    bool detectMask = false,
    int detectionTimeOut = 10000,
  }) async {
    const EventChannel eventChannel =
        EventChannel('$baseChannel.interactiveLiveness/event');

    await _channel.invokeMethod(
      'interactiveLiveness#startDetect',
      <String, dynamic>{
        'eventChannelName': eventChannel.name,
        'detectMask': detectMask,
        'detectionTimeOut': detectionTimeOut,
      },
    );
    return eventChannel
        .receiveBroadcastStream()
        .map<MLInteractiveLivenessCaptureResult>((dynamic event) {
      return MLInteractiveLivenessCaptureResult._fromJson(event);
    });
  }
}
