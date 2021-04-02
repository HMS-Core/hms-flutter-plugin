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

class MLTranslateSetting {
  String sourceTextOnRemote;
  String sourceLangCode;
  String targetLangCode;
  int region;
  bool needWifi;
  bool needCharging;
  bool needDeviceIdle;

  MLTranslateSetting() {
    sourceTextOnRemote = null;
    sourceLangCode = "en";
    targetLangCode = "zh";
    region = 1002;
    needWifi = true;
    needCharging = false;
    needDeviceIdle = false;
  }

  Map<String, dynamic> toMap() {
    return {
      "sourceText": sourceTextOnRemote,
      "sourceLang": sourceLangCode,
      "targetLang": targetLangCode,
      "region": region,
      "needWifi": needWifi,
      "needCharging": needCharging,
      "needDeviceIdle": needDeviceIdle
    };
  }

  String get getSourceLangCode => sourceLangCode;

  String get getTargetLangCode => targetLangCode;

  bool get isWifiNeeded => needWifi;

  bool get isChargingNeeded => needCharging;

  bool get isDeviceIdleNeeded => needDeviceIdle;

  int get getRegion => region;
}
