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

class MLSpeechRealTimeTranscription {
  late MethodChannel _c;
  MLSpeechRealTimeTranscriptionListener? _listener;

  MLSpeechRealTimeTranscription() {
    _c = _initMethodChannel();
  }

  MethodChannel _initMethodChannel() {
    const MethodChannel channel = MethodChannel('hms_lang_rtt');
    channel.setMethodCallHandler(_onMethodCall);
    return channel;
  }

  void destroy() {
    _c.invokeMethod(
      'destroy',
    );
  }

  void setRealTimeTranscriptionListener(
    MLSpeechRealTimeTranscriptionListener listener,
  ) {
    _listener = listener;
  }

  void startRecognizing(
    MLSpeechRealTimeTranscriptionConfig config,
  ) {
    _c.invokeMethod(
      'startRecognizing',
      config.toMap(),
    );
  }

  Future<List<String>?> getLanguages() async {
    final List<dynamic>? res = await _c.invokeMethod(
      'getLanguages',
    );
    return res != null ? List<String>.from(res) : null;
  }

  Future<dynamic> _onMethodCall(MethodCall call) {
    final dynamic event = call.arguments['event'];

    switch (event) {
      case 'onRecognizingResults':
        final MLSpeechRealTimeTranscriptionResult rttRes =
            MLSpeechRealTimeTranscriptionResult.fromMap(call.arguments);
        _listener?.onResult.call(rttRes);
        break;
      case 'onError':
        _listener?.onError.call(
          call.arguments['errCode'],
          call.arguments['errMsg'],
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
        throw 'Unexpected event!';
    }
    return Future<dynamic>.value(null);
  }
}
