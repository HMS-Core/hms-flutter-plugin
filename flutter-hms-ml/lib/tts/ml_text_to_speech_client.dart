/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:flutter/services.dart';
import 'package:huawei_ml/tts/ml_text_to_speech_settings.dart';

class MlTextToSpeechClient {
  static const MethodChannel _channel = const MethodChannel("tts");

  static Future getSpeechFromText(MlTextToSpeechSettings settings) async {
    await _channel.invokeMethod("getSpeechFromText", settings.toMap());
  }

  static Future<bool> pauseSpeech() async {
    final bool result = await _channel.invokeMethod("pauseSpeech");
    return result;
  }

  static Future<bool> resumeSpeech() async {
    final bool result = await _channel.invokeMethod("resumeSpeech");
    return result;
  }

  static Future<String> stopTextToSpeech() async {
    final String response = await _channel.invokeMethod("stopTextToSpeech");
    return response;
  }
}
