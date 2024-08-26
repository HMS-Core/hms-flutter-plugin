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

library huawei_ml_language;

import 'dart:convert';

import 'package:flutter/services.dart';

part 'src/aft/ml_aft_constants.dart';
part 'src/aft/ml_aft_errors.dart';
part 'src/aft/ml_remote_aft_engine.dart';
part 'src/aft/ml_remote_aft_listener.dart';
part 'src/aft/ml_remote_aft_result.dart';
part 'src/aft/ml_remote_aft_setting.dart';
part 'src/app/language_app.dart';
part 'src/asr/ml_asr_constants.dart';
part 'src/asr/ml_asr_listener.dart';
part 'src/asr/ml_asr_recognizer.dart';
part 'src/asr/ml_asr_setting.dart';
part 'src/common/common.dart';
part 'src/common/model_download_strategy.dart';
part 'src/langdetection/ml_detected_lang.dart';
part 'src/langdetection/ml_lang_detector.dart';
part 'src/langdetection/ml_lang_detector_setting.dart';
part 'src/rtt/ml_speech_real_time_transcription.dart';
part 'src/rtt/ml_speech_real_time_transcription_config.dart';
part 'src/rtt/ml_speech_real_time_transcription_listener.dart';
part 'src/rtt/ml_speech_real_time_transcription_result.dart';
part 'src/sounddetection/ml_sound_detect_constants.dart';
part 'src/sounddetection/ml_sound_detector.dart';
part 'src/translation/ml_local_translator.dart';
part 'src/translation/ml_remote_translator.dart';
part 'src/translation/ml_translate_language.dart';
part 'src/translation/ml_translate_setting.dart';
part 'src/tts/ml_tts_audio_fragment.dart';
part 'src/tts/ml_tts_callback.dart';
part 'src/tts/ml_tts_config.dart';
part 'src/tts/ml_tts_constants.dart';
part 'src/tts/ml_tts_engine.dart';
part 'src/tts/ml_tts_error.dart';
part 'src/tts/ml_tts_speaker.dart';
part 'src/tts/ml_tts_warn.dart';
