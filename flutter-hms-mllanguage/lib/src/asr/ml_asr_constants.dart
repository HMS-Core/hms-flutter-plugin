/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

abstract class MLAsrConstants {
  static const String FEATURE = "FEATURE";
  static const String LANGUAGE = "LANGUAGE";
  static const String PUNCTUATION_ENABLE = "PUNCTUATION_ENABLE";
  static const String SCENES = "scenes";
  static const String SCENES_SHOPPING = "shopping";
  static const int FEATURE_WORDFLUX = 11;
  static const int FEATURE_ALLINONE = 12;
  static const String ACTION_HMS_ASR_SPEECH =
      "com.huawei.hms.mlsdk.action.RECOGNIZE_SPEECH";
  static const String WAVE_PAINE_ENCODING = "ENCODING";
  static const String WAVE_PAINE_SAMPLE_RATE = "SAMPLE_RATE";
  static const String WAVE_PAINE_BIT_WIDTH = "BIT_WIDTH";
  static const String WAVE_PAINE_CHANNEL_COUNT = "CHANNEL_COUNT";
  static const int STATE_LISTENING = 1;
  static const int STATE_NO_SOUND = 2;
  static const int STATE_NO_SOUND_TIMES_EXCEED = 3;
  static const int STATE_NO_UNDERSTAND = 6;
  static const int STATE_NO_NETWORK = 7;
  static const int STATE_WAITING = 9;
  @deprecated
  static const String LAN_ZH = "zh";
  static const String LAN_ZH_CN = "zh-CN";
  static const String LAN_EN_US = "en-US";
  static const String LAN_FR_FR = "fr-FR";
  static const String LAN_ES_ES = "es-ES";
  static const String LAN_EN_IN = "en-IN";
  static const String LAN_DE_DE = "de-DE";
  static const String LAN_RU_RU = "ru-RU";
  static const String LAN_IT_IT = "it-IT";
  static const String LAN_AR = "ar";
  static const String LAN_TH_TH = "th-TH";
  static const String LAN_FIL_PH = "fil-PH";
  static const String LAN_MS_MY = "ms-MY";
  static const int ERR_NO_NETWORK = 11202;
  static const int ERR_SERVICE_UNAVAILABLE = 11203;
  static const int ERR_NO_UNDERSTAND = 11204;
  static const int ERR_INVALIDATE_TOKEN = 11219;
}
