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

part of 'ml_speech_real_time_transcription_listener.dart';

typedef _OnError = void Function(int error, String errorMessage);

typedef _OnRecognizingResults = void Function(
    MLSpeechRealTimeTranscriptionResult result);

typedef _OnStartListening = void Function();

typedef _OnStartingOfSpeech = void Function();

typedef _OnState = void Function(int state);

typedef _OnVoiceDataReceived = void Function(Uint8List bytes);
