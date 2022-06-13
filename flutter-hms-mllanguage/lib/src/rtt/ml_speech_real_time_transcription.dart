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

import 'package:flutter/services.dart';
import 'package:huawei_ml_language/src/rtt/ml_speech_real_time_transcription_result.dart';

import 'ml_speech_real_time_transcription_config.dart';
import 'ml_speech_real_time_transcription_listener.dart';

const String _ON_RESULT = 'onRecognizingResults';
const String _ON_ERROR = 'onError';
const String _ON_START_LISTENING = 'onStartListening';
const String _ON_STARTING_OF_SPEECH = 'onStartingOfSpeech';
const String _ON_VOICE_DATA_RECEIVED = 'onVoiceDataReceived';
const String _ON_STATE = 'onState';

class MLSpeechRealTimeTranscription {
  late MethodChannel _c;
  MLSpeechRealTimeTranscriptionListener? _listener;

  MLSpeechRealTimeTranscription() {
    _c = _initMethodChannel();
  }

  MethodChannel _initMethodChannel() {
    final channel = MethodChannel("hms_lang_rtt");
    channel.setMethodCallHandler(_onMethodCall);
    return channel;
  }

  void destroy() {
    _c.invokeMethod("destroy");
  }

  void setRealTimeTranscriptionListener(
      MLSpeechRealTimeTranscriptionListener listener) {
    _listener = listener;
  }

  void startRecognizing(MLSpeechRealTimeTranscriptionConfig config) {
    _c.invokeMethod("startRecognizing", config.toMap());
  }

  Future<List<String>?> getLanguages() async {
    final res = await _c.invokeMethod("getLanguages");
    return res != null ? List<String>.from(res) : null;
  }

  Future<dynamic> _onMethodCall(MethodCall call) {
    final event = call.arguments['event'];

    switch (event) {
      case _ON_RESULT:
        final rttRes =
            MLSpeechRealTimeTranscriptionResult.fromMap(call.arguments);
        _listener?.onResult.call(rttRes);
        break;
      case _ON_ERROR:
        _listener?.onError.call(
          call.arguments['errCode'],
          call.arguments['errMsg'],
        );
        break;
      case _ON_START_LISTENING:
        _listener?.onStartListening?.call();
        break;
      case _ON_STARTING_OF_SPEECH:
        _listener?.onStartingOfSpeech?.call();
        break;
      case _ON_VOICE_DATA_RECEIVED:
        _listener?.onVoiceDataReceived?.call(call.arguments['bytes']);
        break;
      case _ON_STATE:
        _listener?.onState?.call(call.arguments['state']);
        break;
      default:
        throw 'Unexpected event!';
    }
    return Future<dynamic>.value(null);
  }
}
