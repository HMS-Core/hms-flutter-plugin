/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.push.constants;

public enum Channel {

    TOKEN_CHANNEL("com.huawei.flutter.push/token"),
    MULTI_SENDER_TOKEN_CHANNEL("com.huawei.flutter.push/multi_sender_token"),
    REMOTE_MESSAGE_RECEIVE_CHANNEL("com.huawei.flutter.push/remote_message_receive"),
    REMOTE_MESSAGE_SEND_STATUS_CHANNEL("com.huawei.flutter.push/remote_message_send_status"),
    REMOTE_MESSAGE_NOTIFICATION_INTENT_CHANNEL("com.huawei.flutter.push/remote_message_notification_intent"),
    NOTIFICATION_OPEN_CHANNEL("com.huawei.flutter.push/notification_open"),
    LOCAL_NOTIFICATION_CLICK_CHANNEL("com.huawei.flutter.push/local_notification_click"),
    METHOD_CHANNEL("com.huawei.flutter.push/method"),
    BACKGROUND_MESSAGE_CHANNEL("com.huawei.flutter.push/background");

    private String id;

    Channel(String id) {
        this.id = id;
    }

    public String id() {
        return id;
    }

}
