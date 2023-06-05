/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_health;

const MethodChannel _healthAccountMethodChannel = MethodChannel(
  'com.huawei.hms.flutter.health/health_auth',
);
const MethodChannel _healthActivityRecordMethodChannel = MethodChannel(
  'com.huawei.hms.flutter.health/activity_records',
);
const MethodChannel _healthDataControllerMethodChannel = MethodChannel(
  'com.huawei.hms.flutter.health/data_controller',
);
const MethodChannel _healthSettingControllerMethodChannel = MethodChannel(
  'com.huawei.hms.flutter.health/setting_controller',
);
const MethodChannel _healthAutoRecorderMethodChannel = MethodChannel(
  'com.huawei.hms.flutter.health/auto_recorder',
);
const MethodChannel _appInfoMethodChannel = MethodChannel(
  'com.huawei.hms.flutter.health/app_info',
);
const MethodChannel _healthRecordControllerMethodChannel = MethodChannel(
  'com.huawei.hms.flutter.health/health_record_controller',
);
const EventChannel _healthAutoRecorderEventChannel = EventChannel(
  'com.huawei.hms.flutter.health/auto_recorder_event',
);
