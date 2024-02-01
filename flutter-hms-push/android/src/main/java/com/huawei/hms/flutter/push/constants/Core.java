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

public interface Core {
    String RAW = "raw";

    String CLIENT_APP_ID = "client/app_id";
    String DEFAULT_TOKEN_SCOPE = "HCM";
    String REMOTE_MESSAGE_UPLINK_TO = "push.hcm.upstream";

    String PREFERENCE_NAME = "huawei_hms_flutter_push";

    String DEFAULT_MESSAGE = "HMS Push";
    long DEFAULT_VIBRATE_DURATION = 250L;
    String NOTIFICATION_CHANNEL_ID = "huawei-hms-flutter-push-channel-id";
    String NOTIFICATION_CHANNEL_NAME = "huawei-hms-flutter-push-channel";
    String NOTIFICATION_CHANNEL_DESC = "Huawei HMS Push";

    interface Resource {
        String MIPMAP = "mipmap";
        String NOTIFICATION = "ic_notification";
        String LAUNCHER = "ic_launcher";
        String DEFAULT = "default";
    }

    interface NotificationType {
        String NOW = "NOW";
        String SCHEDULED = "SCHEDULED";
    }

    interface ScheduledPublisher {
        String NOTIFICATION_ID = "notificationId";
        String BOOT_EVENT = "android.intent.action.BOOT_COMPLETED";
    }
}
