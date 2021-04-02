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

import 'ml_tts_engine.dart';

class MLTtsConfig {
  static const String TTS_SPEAKER_FEMALE_ZH = "Female-zh";
  static const String TTS_SPEAKER_FEMALE_EN = "Female-en";
  static const String TTS_SPEAKER_MALE_ZH = "Male-zh";
  static const String TTS_SPEAKER_MALE_EN = "Male-en";
  static const String TTS_SPEAKER_FEMALE_FR = "fr-FR-st-1";
  static const String TTS_SPEAKER_FEMALE_ES = "es-ES-st-1";
  static const String TTS_SPEAKER_FEMALE_DE = "de-DE-st-1";
  static const String TTS_SPEAKER_FEMALE_IT = "it-IT-st-1";
  static const String TTS_ZH_HANS = "zh-Hans";
  static const String TTS_EN_US = "en-US";
  static const String TTS_LAN_FR_FR = "fr-FR";
  static const String TTS_LAN_ES_ES = "es-ES";
  static const String TTS_LAN_DE_DE = "de-DE";
  static const String TTS_LAN_IT_IT = "it-IT";
  static const String TTS_SPEAKER_OFFLINE_ZH_HANS_FEMALE_BOLT =
      "zh-Hans-st-bolt-1";
  static const String TTS_SPEAKER_OFFLINE_ZH_HANS_MALE_BOLT =
      "zh-Hans-st-bolt-2";
  static const String TTS_SPEAKER_OFFLINE_EN_US_FEMALE_BOLT = "en-US-st-bolt-1";
  static const String TTS_SPEAKER_OFFLINE_EN_US_MALE_BOLT = "en-US-st-bolt-2";
  static const String TTS_SPEAKER_OFFLINE_ZH_HANS_FEMALE_EAGLE =
      "zh-Hans-st-eagle-1";
  static const String TTS_SPEAKER_OFFLINE_ZH_HANS_MALE_EAGLE =
      "zh-Hans-st-eagle-2";
  static const String TTS_SPEAKER_OFFLINE_EN_US_FEMALE_EAGLE =
      "en-US-st-eagle-1";
  static const String TTS_SPEAKER_OFFLINE_EN_US_MALE_EAGLE = "en-US-st-eagle-2";
  static const String TTS_SPEAKER_OFFLINE_EN_US_FEMALE_BEE = "en-US-st-bee-1";
  static const String TTS_SPEAKER_OFFLINE_FR_FR_FEMALE_BEE = "fr-FR-st-bee-1";
  static const String TTS_SPEAKER_OFFLINE_ES_ES_FEMALE_BEE = "es-ES-st-bee-1";
  static const String TTS_SPEAKER_OFFLINE_DE_DE_FEMALE_BEE = "de-DE-st-bee-1";
  static const String TTS_SPEAKER_OFFLINE_IT_IT_FEMALE_BEE = "it-IT-st-bee-1";
  static const String TTS_ONLINE_MODE = "online";
  static const String TTS_OFFLINE_MODE = "offline";

  String text;
  String language;
  String person;
  String synthesizeMode;
  double speed;
  double volume;
  int queuingMode;

  MLTtsConfig() {
    text = null;
    speed = 1.0;
    volume = 1.0;
    queuingMode = MLTtsEngine.QUEUE_APPEND;
    person = TTS_SPEAKER_FEMALE_EN;
    language = TTS_EN_US;
    synthesizeMode = TTS_ONLINE_MODE;
  }

  String get getLanguage => language;

  String get getPerson => person;

  String get getSynthesizeMode => synthesizeMode;

  double get getVolume => volume;

  double get getSpeed => speed;

  Map<String, dynamic> toMap() {
    return {
      "text": text,
      "language": language,
      "person": person,
      "speed": speed,
      "volume": volume,
      "queuingMode": queuingMode,
      "synthesizeMode": synthesizeMode
    };
  }
}
