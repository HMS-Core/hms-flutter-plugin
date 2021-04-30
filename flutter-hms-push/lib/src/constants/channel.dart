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

import 'package:flutter/services.dart';

/// Includes Constant Method and Event Channel definitions for communicating with the native platform.
const MethodChannel methodChannel =
    MethodChannel('com.huawei.flutter.push/method');
const EventChannel tokenEventChannel =
    EventChannel('com.huawei.flutter.push/token');
const EventChannel multiSenderTokenEventChannel =
    EventChannel('com.huawei.flutter.push/multi_sender_token');
const EventChannel remoteMessageReceiveEventChannel =
    EventChannel('com.huawei.flutter.push/remote_message_receive');
const EventChannel remoteMessageSendStatusEventChannel =
    EventChannel('com.huawei.flutter.push/remote_message_send_status');
const EventChannel remoteMessageNotificationIntentEventChannel =
    EventChannel('com.huawei.flutter.push/remote_message_notification_intent');
const EventChannel notificationOpenEventChannel =
    EventChannel('com.huawei.flutter.push/notification_open');
const EventChannel localNotificationClickEventChannel =
    EventChannel('com.huawei.flutter.push/local_notification_click');
const MethodChannel backgroundMessageChannel =
    MethodChannel('com.huawei.flutter.push/background');
