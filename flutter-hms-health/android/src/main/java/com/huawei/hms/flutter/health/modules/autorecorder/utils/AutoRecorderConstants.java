/*
 * Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.health.modules.autorecorder.utils;

import com.huawei.hms.flutter.health.modules.autorecorder.service.AutoRecorderService;

public final class AutoRecorderConstants {
    public static final String AUTO_RECORDER_MODULE = "HMSAutoRecorder";

    /**
     * Constant Method Names.
     */
    public static final String START_RECORD = "startRecord";

    public static final String STOP_RECORD = "stopRecord";

    /**
     * Constant Variable Keys That used in implementing the {@link AutoRecorderService}.
     */
    public static final String BACKGROUND_SERVICE = "HealthKitService";

    public static final String START_BACKGROUND_SERVICE_ACTION = "hms.intent.action.start_auto_recorder_foreground";

    public static final String STOP_BACKGROUND_SERVICE_ACTION = "hms.intent.action.stop_auto_recorder_foreground";

    public static final String AUTO_RECORDER_INTENT_ACTION = "hms.intent.action.auto_recorder_intent";

    /**
     * Notification property keys.
     */
    public static final String MIPMAP = "mipmap";

    public static final String TICKER = "ticker";

    public static final String TITLE = "title";

    public static final String TEXT = "text";

    public static final String SUB_TEXT = "subText";

    public static final String CHRONOMETER = "chronometer";

    private AutoRecorderConstants() {
    }
}
