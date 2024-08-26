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

class MLSpeechRealTimeTranscriptionConfig {
  static const String LAN_ZH_CN = 'zh-CN';
  static const String LAN_EN_US = 'en-US';
  static const String LAN_FR_FR = 'fr-FR';
  static const String LAN_ES_ES = 'es-ES';
  static const String LAN_EN_IN = 'en-IN';
  static const String LAN_DE_DE = 'de-DE';
  static const String SCENES_SHOPPING = 'shopping';

  String? language;
  String? scene;
  bool? punctuationEnabled;
  bool? sentenceTimeOffsetEnabled;
  bool? wordTimeOffsetEnabled;

  MLSpeechRealTimeTranscriptionConfig({
    this.language,
    this.scene,
    this.punctuationEnabled,
    this.sentenceTimeOffsetEnabled,
    this.wordTimeOffsetEnabled,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'language': language ?? LAN_EN_US,
      'scene': scene ?? SCENES_SHOPPING,
      'punctuationEnabled': punctuationEnabled ?? true,
      'sentenceTimeOffsetEnabled': sentenceTimeOffsetEnabled ?? false,
      'wordTimeOffsetEnabled': wordTimeOffsetEnabled ?? false,
    };
  }
}
