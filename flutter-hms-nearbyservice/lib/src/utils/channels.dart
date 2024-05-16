/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_nearbyservice;

const String _nearbyMethodChannel = 'com.huawei.hms.flutter.nearby/method';

const String _discoveryMethodChannel =
    'com.huawei.hms.flutter.nearby.discovery/method';
const String _discoveryConnectEventChannel =
    'com.huawei.hms.flutter.nearby.discovery/event/connect_callback';
const String _discoveryScanEventChannel =
    'com.huawei.hms.flutter.nearby.discovery/event/scan_callback';

const String _transferMethodChannel =
    'com.huawei.hms.flutter.nearby.transfer/method';
const String _transferEventChannel =
    'com.huawei.hms.flutter.nearby.transfer/event';

const String _messageMethodChannel =
    'com.huawei.hms.flutter.nearby.message/method';
const String _messageEventChannel =
    'com.huawei.hms.flutter.nearby.message/event';

const String _beaconMethodChannel =
    'com.huawei.hms.flutter.nearby.beacon/method';
const String _beaconEventChannel = 'com.huawei.hms.flutter.nearby.beacon/event';
