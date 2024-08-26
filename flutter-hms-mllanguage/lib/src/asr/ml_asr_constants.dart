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

abstract class MLAsrConstants {
  static const String FEATURE = 'FEATURE';

  static const String LANGUAGE = 'LANGUAGE';

  static const String PUNCTUATION_ENABLE = 'PUNCTUATION_ENABLE';

  /// Set the key of the application scenario.
  static const String SCENES = 'scenes';

  /// The application scenario is shopping. Currently, only Chinese is supported.
  static const String SCENES_SHOPPING = 'shopping';

  /// The recognition result is returned in real time.
  static const int FEATURE_WORDFLUX = 11;

  /// After the speech is complete, the recognition result is returned at a time.
  static const int FEATURE_ALLINONE = 12;

  /// Action name used for creating the Intent parameter in startRecognizing.
  static const String ACTION_HMS_ASR_SPEECH =
      'com.huawei.hms.mlsdk.action.RECOGNIZE_SPEECH';

  static const String WAVE_PAINE_ENCODING = 'ENCODING';

  static const String WAVE_PAINE_SAMPLE_RATE = 'SAMPLE_RATE';

  static const String WAVE_PAINE_BIT_WIDTH = 'BIT_WIDTH';

  static const String WAVE_PAINE_CHANNEL_COUNT = 'CHANNEL_COUNT';

  /// Status code in the onState callback, indicating that the recorder is ready.
  static const int STATE_LISTENING = 1;

  /// Status code in the onState callback, indicating that no speech is detected within 3s.
  static const int STATE_NO_SOUND = 2;

  /// Status code in the onState callback, indicating that no result is detected within 6s.
  static const int STATE_NO_SOUND_TIMES_EXCEED = 3;

  /// Status code in the onState callback, indicating that the current frame fails to be detected on the cloud.
  static const int STATE_NO_UNDERSTAND = 6;

  /// Status code in the onState callback, indicating that no network is available in the current environment.
  static const int STATE_NO_NETWORK = 7;

  /// Status code in the onState callback, indicating that data is sent for the first time on a weak network.
  static const int STATE_WAITING = 9;

  /// Mandarin Chinese (Simplified Chinese).
  /// The value is the same as that of LAN_ZH_CN.
  @Deprecated('Use LAN_ZH_CN')
  static const String LAN_ZH = 'zh';

  /// Mandarin Chinese (Simplified Chinese).
  static const String LAN_ZH_CN = 'zh-CN';

  /// English (US).
  static const String LAN_EN_US = 'en-US';

  /// French (France).
  static const String LAN_FR_FR = 'fr-FR';

  /// Spanish (Spain).
  static const String LAN_ES_ES = 'es-ES';

  static const String LAN_EN_IN = 'en-IN';

  /// German.
  static const String LAN_DE_DE = 'de-DE';

  /// Russian.
  static const String LAN_RU_RU = 'ru-RU';

  /// Italian.
  static const String LAN_IT_IT = 'it-IT';

  /// Arabic.
  static const String LAN_AR = 'ar';

  /// Turkish.
  static const String LAN_TR_TR = 'tr-TR';

  /// Thai.
  static const String LAN_TH_TH = 'th-TH';

  /// Filipino.
  static const String LAN_FIL_PH = 'fil-PH';

  /// Malay.
  static const String LAN_MS_MY = 'ms-MY';

  /// Network error.
  static const int ERR_NO_NETWORK = 11202;

  /// Service unavailable.
  static const int ERR_SERVICE_UNAVAILABLE = 11203;

  /// Speech unrecognized.
  static const int ERR_NO_UNDERSTAND = 11204;

  /// Authentication failed.
  static const int ERR_INVALIDATE_TOKEN = 11219;
}
