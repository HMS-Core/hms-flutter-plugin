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

class MLTtsConstants {
  /// Chinese female voice.
  static const String TTS_SPEAKER_FEMALE_ZH = 'Female-zh';

  /// Chinese female voice (Yifei).
  static const String TTS_SPEAKER_FEMALE_ZH_2 = 'zh-Hans-st-3';

  /// English female voice.
  static const String TTS_SPEAKER_FEMALE_EN = 'Female-en';

  /// English female voice (Catherine).
  static const String TTS_SPEAKER_FEMALE_EN_2 = 'en-US-st-3';

  /// Chinese male voice.
  static const String TTS_SPEAKER_MALE_ZH = 'Male-zh';

  /// Chinese male voice (Xiaozhong).
  static const String TTS_SPEAKER_MALE_ZH_2 = 'zh-Hans-st-4';

  /// English male voice.
  static const String TTS_SPEAKER_MALE_EN = 'Male-en';

  /// English male voice (John, American English).
  static const String TTS_SPEAKER_MALE_EN_2 = 'en-US-st-4';
  static const String TTS_SPEAKER_FEMALE_ZH_HQ = 'zh-Hans-hq-1';
  static const String TTS_SPEAKER_FEMALE_EN_HQ = 'en-US-hq-1';
  static const String TTS_SPEAKER_MALE_ZH_HQ = 'zh-Hans-hq-2';
  static const String TTS_SPEAKER_MALE_EN_HQ = 'en-US-hq-2';
  static const String TTS_SPEAKER_FEMALE_FR = 'fr-FR-st-1';
  static const String TTS_SPEAKER_FEMALE_ES = 'es-ES-st-1';
  static const String TTS_SPEAKER_FEMALE_DE = 'de-DE-st-1';
  static const String TTS_SPEAKER_FEMALE_IT = 'it-IT-st-1';
  static const String TTS_SPEAKER_FEMALE_AR = 'ar-AR-st-1';
  static const String TTS_SPEAKER_FEMALE_RU = 'ru-RU-st-1';
  static const String TTS_SPEAKER_FEMALE_TH = 'th-TH-st-1';
  static const String TTS_SPEAKER_FEMALE_PL = 'pl-PL-st-1';
  static const String TTS_SPEAKER_FEMALE_MS = 'ms-MS-st-1';
  static const String TTS_SPEAKER_FEMALE_TR = 'tr-TR-st-1';
  static const String TTS_ZH_HANS = 'zh-Hans';
  static const String TTS_EN_US = 'en-US';
  static const String TTS_LAN_FR_FR = 'fr-FR';
  static const String TTS_LAN_ES_ES = 'es-ES';
  static const String TTS_LAN_DE_DE = 'de-DE';
  static const String TTS_LAN_IT_IT = 'it-IT';
  static const String TTS_LAN_AR_AR = 'ar-AR';
  static const String TTS_LAN_RU_RU = 'ru-RU';
  static const String TTS_LAN_TH_TH = 'th-TH';
  static const String TTS_LAN_PL_PL = 'pl-PL';
  static const String TTS_LAN_MS_MS = 'ms-MS';
  static const String TTS_LAN_TR_TR = 'tr-TR';
  static const String TTS_SPEAKER_OFFLINE_ZH_HANS_FEMALE_BOLT =
      'zh-Hans-st-bolt-1';
  static const String TTS_SPEAKER_OFFLINE_ZH_HANS_MALE_BOLT =
      'zh-Hans-st-bolt-2';
  static const String TTS_SPEAKER_OFFLINE_EN_US_FEMALE_BOLT = 'en-US-st-bolt-1';
  static const String TTS_SPEAKER_OFFLINE_EN_US_MALE_BOLT = 'en-US-st-bolt-2';
  static const String TTS_SPEAKER_OFFLINE_ZH_HANS_FEMALE_EAGLE =
      'zh-Hans-st-eagle-1';
  static const String TTS_SPEAKER_OFFLINE_ZH_HANS_MALE_EAGLE =
      'zh-Hans-st-eagle-2';
  static const String TTS_SPEAKER_OFFLINE_EN_US_FEMALE_EAGLE =
      'en-US-st-eagle-1';
  static const String TTS_SPEAKER_OFFLINE_EN_US_MALE_EAGLE = 'en-US-st-eagle-2';
  static const String TTS_SPEAKER_OFFLINE_EN_US_FEMALE_BEE = 'en-US-st-bee-1';
  static const String TTS_SPEAKER_OFFLINE_FR_FR_FEMALE_BEE = 'fr-FR-st-bee-1';
  static const String TTS_SPEAKER_OFFLINE_ES_ES_FEMALE_BEE = 'es-ES-st-bee-1';
  static const String TTS_SPEAKER_OFFLINE_DE_DE_FEMALE_BEE = 'de-DE-st-bee-1';
  static const String TTS_SPEAKER_OFFLINE_IT_IT_FEMALE_BEE = 'it-IT-st-bee-1';
  static const String TTS_SPEAKER_OFFLINE_EN_US_FEMALE_FLY = 'en-US-st-fly-1';
  static const String TTS_SPEAKER_OFFLINE_FR_FR_FEMALE_FLY = 'fr-FR-st-fly-1';
  static const String TTS_SPEAKER_OFFLINE_ES_ES_FEMALE_FLY = 'es-ES-st-fly-1';
  static const String TTS_SPEAKER_OFFLINE_DE_DE_FEMALE_FLY = 'de-DE-st-fly-1';
  static const String TTS_SPEAKER_OFFLINE_IT_IT_FEMALE_FLY = 'it-IT-st-fly-1';
  static const String TTS_SPEAKER_OFFLINE_AR_AR_FEMALE_FLY = 'ar-AR-st-fly-1';
  static const String TTS_SPEAKER_OFFLINE_RU_RU_FEMALE_FLY = 'ru-RU-st-fly-1';
  static const String TTS_SPEAKER_OFFLINE_TH_TH_FEMALE_FLY = 'th-TH-st-fly-1';
  static const int EVENT_PLAY_START = 1;
  static const int EVENT_PLAY_RESUME = 2;
  static const int EVENT_PLAY_PAUSE = 3;
  static const int EVENT_PLAY_STOP = 4;
  static const int EVENT_SYNTHESIS_START = 5;
  static const int EVENT_SYNTHESIS_END = 6;
  static const int EVENT_SYNTHESIS_COMPLETE = 7;
  static const String EVENT_PLAY_STOP_INTERRUPTED = 'interrupted';
  static const String EVENT_SYNTHESIS_INTERRUPTED = 'interrupted';
  static const int LANGUAGE_AVAILABLE = 0;
  static const int LANGUAGE_NOT_SUPPORT = 1;
  static const int LANGUAGE_UPDATING = 2;
  static const String TTS_ONLINE_MODE = 'online';
  static const String TTS_OFFLINE_MODE = 'offline';
}
