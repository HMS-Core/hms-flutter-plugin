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

class MLSpeechRealTimeTranscriptionListener {
  /// Called when a network error or recognition error occurs.
  void Function(int error, String errorMessage) onError;

  /// Receives text recognized by the speech recognizer.
  void Function(MLSpeechRealTimeTranscriptionResult result) onResult;

  /// Called when the recorder starts to receive speech.
  void Function()? onStartListening;

  /// Called when a user starts to speak, that is, the speech recognizer
  /// detects that the user starts to speak.
  void Function()? onStartingOfSpeech;

  /// Notifies the app status change.
  void Function(int state)? onState;

  /// Returns the original PCM stream and audio power to the user.
  void Function(Uint8List bytes)? onVoiceDataReceived;

  MLSpeechRealTimeTranscriptionListener({
    required this.onError,
    required this.onResult,
    this.onStartListening,
    this.onStartingOfSpeech,
    this.onState,
    this.onVoiceDataReceived,
  });
}
