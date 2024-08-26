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

class MLTtsCallback {
  /// Error event callback function.
  void Function(String taskId, MLTtsError err) onError;

  /// Audio stream callback API, which is used to return the
  /// synthesized audio data to the app.
  void Function(
    String taskId,
    MLTtsAudioFragment audioFragment,
    int offset,
  )? onAudioAvailable;

  /// Audio synthesis task callback extension method.
  void Function(String taskId, int eventId)? onEvent;

  /// The TTS engine splits the text input by the audio synthesis task.
  /// This callback function can be used to listen to the playback start event of
  /// the split text.
  void Function(String taskId, int start, int end)? onRangeStart;

  /// Alarm event callback function.
  void Function(String taskId, MLTtsWarn warn)? onWarn;

  MLTtsCallback({
    required this.onError,
    this.onAudioAvailable,
    this.onEvent,
    this.onRangeStart,
    this.onWarn,
  });
}
