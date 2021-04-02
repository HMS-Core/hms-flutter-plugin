/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:flutter/material.dart';

class MLSpeechRealTimeTranscriptionConfig {
  static const String LAN_ZH_CN = "zh-CN";
  static const String LAN_EN_US = "en-US";
  static const String LAN_FR_FR = "fr-FR";
  static const String LAN_ES_ES = "es-ES";
  static const String LAN_EN_IN = "en-IN";
  static const String LAN_DE_DE = "de-DE";
  static const String SCENES_SHOPPING = "shopping";

  String language;
  String scene;
  bool punctuationEnabled;
  bool sentenceTimeOffsetEnabled;
  bool wordTimeOffsetEnabled;

  MLSpeechRealTimeTranscriptionConfig() {
    language = LAN_EN_US;
    scene = SCENES_SHOPPING;
    punctuationEnabled = true;
    sentenceTimeOffsetEnabled = false;
    wordTimeOffsetEnabled = false;
  }

  String get getLanguage => language;

  bool get isPunctuationEnable => punctuationEnabled;

  bool get isSentenceTimeOffsetEnable => sentenceTimeOffsetEnabled;

  bool get isWordTimeOffsetEnable => wordTimeOffsetEnabled;

  Map<String, dynamic> toMap() {
    return {
      "language": language,
      "scene": scene,
      "punctuationEnabled": punctuationEnabled,
      "sentenceTimeOffsetEnabled": sentenceTimeOffsetEnabled,
      "wordTimeOffsetEnabled": wordTimeOffsetEnabled
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MLSpeechRealTimeTranscriptionConfig &&
        o.language == language &&
        o.scene == scene &&
        o.punctuationEnabled == punctuationEnabled &&
        o.sentenceTimeOffsetEnabled == sentenceTimeOffsetEnabled &&
        o.wordTimeOffsetEnabled == wordTimeOffsetEnabled;
  }

  @override
  int get hashCode {
    return hashList([
      language,
      scene,
      punctuationEnabled,
      sentenceTimeOffsetEnabled,
      wordTimeOffsetEnabled
    ]);
  }
}
