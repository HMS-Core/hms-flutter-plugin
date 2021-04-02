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
library constants.channel;

import 'package:flutter/services.dart';

/// HUAWEI Flutter Health Kit - Method Channels
const MethodChannel health_account_method_channel =
    MethodChannel('com.huawei.hms.flutter.health/health_auth');
const MethodChannel health_activity_record_method_channel =
    MethodChannel('com.huawei.hms.flutter.health/activity_records');
const MethodChannel health_data_controller_method_channel =
    MethodChannel('com.huawei.hms.flutter.health/data_controller');
const MethodChannel health_setting_controller_method_channel =
    MethodChannel('com.huawei.hms.flutter.health/setting_controller');
const MethodChannel health_auto_recorder_method_channel =
    MethodChannel('com.huawei.hms.flutter.health/auto_recorder');
const EventChannel health_auto_recorder_event_channel =
    EventChannel('com.huawei.hms.flutter.health/auto_recorder_event');
const MethodChannel health_ble_controller_method_channel =
    MethodChannel('com.huawei.hms.flutter.health/ble_controller');
const EventChannel health_ble_controller_event_channel =
    EventChannel('com.huawei.hms.flutter.health/ble_controller_event');
