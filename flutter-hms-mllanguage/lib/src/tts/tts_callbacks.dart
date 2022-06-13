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

part of 'ml_tts_callback.dart';

/// Error event callback function.
typedef _OnError = void Function(String taskId, MLTtsError err);

/// Audio stream callback API, which is used to return the
/// synthesized audio data to the app.
typedef _OnAudioAvailable = void Function(
  String taskId,
  MLTtsAudioFragment audioFragment,
  int offset,
);

/// Audio synthesis task callback extension method.
typedef _OnEvent = void Function(String taskId, int eventId);

/// The TTS engine splits the text input by the audio synthesis task.
/// This callback function can be used to listen to the playback start event of
/// the split text.
typedef _OnRangeStart = void Function(String taskId, int start, int end);

/// Alarm event callback function.
typedef _OnWarn = void Function(String taskId, MLTtsWarn warn);
