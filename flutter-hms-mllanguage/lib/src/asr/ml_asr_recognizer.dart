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

class MLAsrRecognizer {
  late MethodChannel _c;

  MLAsrListener? _listener;

  MLAsrRecognizer() {
    _c = _initMethodChannel();
  }

  MethodChannel _initMethodChannel() {
    const MethodChannel channel = MethodChannel('hms_lang_asr');
    channel.setMethodCallHandler(_onMethodCall);
    return channel;
  }

  /// Sets the listener callback function of the recognizer to
  /// receive the recognition result and result code.
  void setAsrListener(MLAsrListener listener) {
    _listener = listener;
  }

  /// Obtains supported languages.
  Future<List<String>?> getLanguages() async {
    final List<dynamic>? res = await _c.invokeMethod(
      'getSupportedLanguages',
    );
    return res != null ? List<String>.from(res) : null;
  }

  /// Starts recognition.
  void startRecognizing(
    MLAsrSetting? setting,
  ) {
    _c.invokeMethod(
      'startRecognizing',
      setting != null ? setting.toMap() : MLAsrSetting().toMap(),
    );
  }

  /// Starts recognition with a ui picker dialog.
  Future<String?> startRecognizingWithUi(
    MLAsrSetting? setting,
  ) async {
    return await _c.invokeMethod(
      'startRecognizingWithUi',
      setting != null ? setting.toMap() : MLAsrSetting().toMap(),
    );
  }

  /// Destroys an instance of MLAsrRecognizer.
  void destroy() {
    _c.invokeMethod(
      'destroy',
    );
  }

  Future<dynamic> _onMethodCall(MethodCall call) {
    final String event = call.arguments['event'];
    switch (event) {
      case 'onRecognizingResults':
        _listener?.onRecognizingResults.call(
          call.arguments['result'],
        );
        break;
      case 'onError':
        _listener?.onError.call(
          call.arguments['errCode'],
          call.arguments['errMsg'],
        );
        break;
      case 'onResults':
        _listener?.onResults?.call(
          call.arguments['result'],
        );
        break;
      case 'onStartListening':
        _listener?.onStartListening?.call();
        break;
      case 'onStartingOfSpeech':
        _listener?.onStartingOfSpeech?.call();
        break;
      case 'onVoiceDataReceived':
        _listener?.onVoiceDataReceived?.call(
          call.arguments['bytes'],
        );
        break;
      case 'onState':
        _listener?.onState?.call(
          call.arguments['state'],
        );
        break;
      default:
        throw 'Unknown event!';
    }
    return Future<dynamic>.value(null);
  }
}
