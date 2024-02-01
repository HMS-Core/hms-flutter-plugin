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

public enum PushIntent {

    TOKEN_INTENT_ACTION("hms.intent.action.TOKEN"),
    MULTI_SENDER_TOKEN_INTENT_ACTION("hms.intent.action.MULTI_SENDER_TOKEN"),
    TOKEN_ERROR("TOKEN_ERROR"),
    MULTI_SENDER_TOKEN_ERROR("MULTI_SENDER_TOKEN_ERROR"),
    TOKEN("TOKEN"),
    MULTI_SENDER_TOKEN("MULTI_SENDER_TOKEN"),
    REMOTE_DATA_MESSAGE_INTENT_ACTION("hms.intent.action.DATA_MESSAGE"),
    DATA_MESSAGE("DATA_MESSAGE"),
    REMOTE_MESSAGE_SENT_DELIVERED_ACTION("hms.intent.action.REMOTE_MESSAGE_SENT_DELIVERED"),
    REMOTE_MESSAGE_NOTIFICATION_INTENT_ACTION("hms.intent.action.REMOTE_MESSAGE_NOTIFICATION_INTENT"),
    CUSTOM_INTENT("CUSTOM_INTENT"),
    REMOTE_MESSAGE("REMOTE_MESSAGE"),
    REMOTE_MESSAGE_ERROR("REMOTE_MESSAGE_ERROR"),
    LOCAL_NOTIFICATION_ACTION("hms.intent.action.LOCAL_NOTIFICATION_ACTION"),
    LOCAL_NOTIFICATION_CLICK_ACTION("hms.intent.action.LOCAL_NOTIFICATION_CLICK_ACTION"),
    LOCAL_NOTIFICATION_CLICK("LOCAL_NOTIFICATION_CLICK"),
    NOTIFICATION_OPEN_ACTION("hms.intent.action.NOTIFICATION_OPEN_ACTION"),
    NOTIFICATION_OPEN("NOTIFICATION_OPEN");

    private String id;

    PushIntent(String id) {
        this.id = id;
    }

    public String id() {
        return id;
    }

}
