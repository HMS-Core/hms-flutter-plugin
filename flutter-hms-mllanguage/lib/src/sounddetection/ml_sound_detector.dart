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

part of '../../huawei_ml_language.dart';

typedef SoundDetectListener = void Function({
  int? result,
  int? errCode,
});

class MLSoundDetector {
  late MethodChannel _c;

  SoundDetectListener? _listener;

  MLSoundDetector() {
    _c = _initMethodChannel();
  }

  MethodChannel _initMethodChannel() {
    const MethodChannel channel = MethodChannel('hms_lang_sound_detection');
    channel.setMethodCallHandler(_onDetection);
    return channel;
  }

  /// Sets the sound detector callback listener.
  void setSoundDetectListener(SoundDetectListener listener) {
    _listener = listener;
  }

  /// Starts detection. The microphone picks up real-time audio data and
  /// [setSoundDetectListener] is used to set a listener to receive the result.
  Future<bool> start() async {
    return await _c.invokeMethod(
      'startSoundDetector',
    );
  }

  /// Stops detecting the audio data picked up by the
  /// microphone but does not release resources.
  void stop() {
    _c.invokeMethod(
      'stopSoundDetector',
    );
  }

  /// Releases sound detector resources.
  void destroy() {
    _c.invokeMethod(
      'destroySoundDetector',
    );
  }

  Future<dynamic> _onDetection(MethodCall call) {
    switch (call.method) {
      case 'success':
        _listener?.call(
          result: call.arguments['result'],
        );
        break;
      case 'fail':
        _listener?.call(
          errCode: call.arguments['errCode'],
        );
        break;
      default:
        throw Exception('Unexpected response');
    }
    return Future<dynamic>.value(null);
  }
}
