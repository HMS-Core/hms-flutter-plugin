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

class LanguageModelDownloadStrategy {
  bool _needWifi = false;
  bool _needCharging = false;
  bool _needDeviceIdle = false;
  int? _region;

  void needWifi() {
    _needWifi = true;
  }

  void needCharging() {
    _needCharging = true;
  }

  void needDeviceIdle() {
    _needDeviceIdle = true;
  }

  void setRegion(int region) {
    _region = region;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'needWifi': _needWifi,
      'needCharging': _needCharging,
      'needDeviceIdle': _needDeviceIdle,
      'region': _region ?? 1002,
    };
  }
}
