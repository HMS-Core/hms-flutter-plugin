/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'dart:typed_data';

import 'ml_speech_real_time_transcription_result.dart';

part 'rtt_callbacks.dart';

class MLSpeechRealTimeTranscriptionListener {
  _OnError onError;
  _OnRecognizingResults onResult;
  _OnStartListening? onStartListening;
  _OnStartingOfSpeech? onStartingOfSpeech;
  _OnState? onState;
  _OnVoiceDataReceived? onVoiceDataReceived;

  MLSpeechRealTimeTranscriptionListener({
    required this.onError,
    required this.onResult,
    this.onStartListening,
    this.onStartingOfSpeech,
    this.onState,
    this.onVoiceDataReceived,
  });
}
