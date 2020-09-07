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
import 'ml_asr_settings.dart';

class MlAsrClient {
  static const MethodChannel _channel = const MethodChannel("asr");

  static Future<String> getTextFromSpeech(MLAsrSettings settings) async {
    return await _channel.invokeMethod("analyzeVoice", settings.toMap());
  }

  static Future<String> stopRecognition() async {
    return await _channel.invokeMethod("stopRecognition");
  }
}
