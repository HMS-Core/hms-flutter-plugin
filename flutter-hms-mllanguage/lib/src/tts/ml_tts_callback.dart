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

import 'ml_tts_audio_fragment.dart';
import 'ml_tts_error.dart';
import 'ml_tts_warn.dart';

part 'tts_callbacks.dart';

class MLTtsCallback {
  /// Error event callback function.
  _OnError onError;

  /// Audio stream callback API, which is used to return the
  /// synthesized audio data to the app.
  _OnAudioAvailable? onAudioAvailable;

  /// Audio synthesis task callback extension method.
  _OnEvent? onEvent;

  /// The TTS engine splits the text input by the audio synthesis task.
  /// This callback function can be used to listen to the playback start event of
  /// the split text.
  _OnRangeStart? onRangeStart;

  /// Alarm event callback function.
  _OnWarn? onWarn;

  MLTtsCallback({
    required this.onError,
    this.onAudioAvailable,
    this.onEvent,
    this.onRangeStart,
    this.onWarn,
  });
}
