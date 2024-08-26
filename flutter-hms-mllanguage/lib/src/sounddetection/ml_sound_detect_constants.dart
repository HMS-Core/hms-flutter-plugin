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

class MLSoundDetectConstants {
  /// Detection failure: memory exhausted.
  static const int SOUND_DETECT_ERROR_NO_MEM = 12201;

  /// Detection failure: fatal error.
  static const int SOUND_DETECT_ERROR_FATAL_ERROR = 12202;

  /// Detection failure: microphone error.
  static const int SOUND_DETECT_ERROR_AUDIO = 12203;

  /// Detection failure: internal error.
  static const int SOUND_DETECT_ERROR_INTERNAL = 12298;

  /// Detection result type: laughter.
  static const int SOUND_EVENT_TYPE_LAUGHTER = 0;

  /// Detection result type: baby crying sound.
  static const int SOUND_EVENT_TYPE_BABY_CRY = 1;

  /// Detection result type: snore.
  static const int SOUND_EVENT_TYPE_SNORING = 2;

  /// Detection result type: sneeze.
  static const int SOUND_EVENT_TYPE_SNEEZE = 3;

  /// Detection result type: shout.
  static const int SOUND_EVENT_TYPE_SCREAMING = 4;

  /// Detection result type: cat's meow.
  static const int SOUND_EVENT_TYPE_MEOW = 5;

  /// Detection result type: dog's bark.
  static const int SOUND_EVENT_TYPE_BARK = 6;

  /// Detection result type: babble of running water.
  static const int SOUND_EVENT_TYPE_WATER = 7;

  /// Detection result type: car horn sound.
  static const int SOUND_EVENT_TYPE_CAR_ALARM = 8;

  /// Detection result type: doorbell sound.
  static const int SOUND_EVENT_TYPE_DOOR_BELL = 9;

  /// Detection result type: knock.
  static const int SOUND_EVENT_TYPE_KNOCK = 10;

  /// Detection result type: fire alarm sound.
  static const int SOUND_EVENT_TYPE_ALARM = 11;

  /// Detection result type: alarm sound.
  static const int SOUND_EVENT_TYPE_STEAM_WHISTLE = 12;
}
