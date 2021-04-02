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

import 'package:huawei_ml/utils/channels.dart';

class MLSoundDetector {
  static const int SOUND_DETECT_ERROR_NO_MEM = 12201;
  static const int SOUND_DETECT_ERROR_FATAL_ERROR = 12202;
  static const int SOUND_DETECT_ERROR_AUDIO = 12203;
  static const int SOUND_DETECT_ERROR_INTERNAL = 12298;
  static const int SOUND_EVENT_TYPE_LAUGHTER = 0;
  static const int SOUND_EVENT_TYPE_BABY_CRY = 1;
  static const int SOUND_EVENT_TYPE_SNORING = 2;
  static const int SOUND_EVENT_TYPE_SNEEZE = 3;
  static const int SOUND_EVENT_TYPE_SCREAMING = 4;
  static const int SOUND_EVENT_TYPE_MEOW = 5;
  static const int SOUND_EVENT_TYPE_BARK = 6;
  static const int SOUND_EVENT_TYPE_WATER = 7;
  static const int SOUND_EVENT_TYPE_CAR_ALARM = 8;
  static const int SOUND_EVENT_TYPE_DOOR_BELL = 9;
  static const int SOUND_EVENT_TYPE_KNOCK = 10;
  static const int SOUND_EVENT_TYPE_ALARM = 11;
  static const int SOUND_EVENT_TYPE_STEAM_WHISTLE = 12;

  Future<int> startSoundDetector() async {
    return await Channels.soundDetectionMethodChannel
        .invokeMethod("startSoundDetector");
  }

  Future<bool> stopSoundDetector() async {
    return await Channels.soundDetectionMethodChannel
        .invokeMethod("stopSoundDetector");
  }

  Future<bool> destroySoundDetector() async {
    return await Channels.soundDetectionMethodChannel
        .invokeMethod("destroySoundDetector");
  }
}
