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

package com.huawei.hms.flutter.health.modules.autorecorder.service;

import com.huawei.hms.flutter.health.modules.autorecorder.listener.VoidOnCompleteListener;
import com.huawei.hms.hihealth.AutoRecorderController;
import com.huawei.hms.hihealth.data.DataType;

import java.util.Map;

public interface AutoRecorderService {
    /**
     * Record data via DataType supported by Huawei.
     *
     * @param autoRecorderController AutoRecorderController instance.
     * @param dataType DataType instance.
     * @param notificationProperties Map that contains properties of the foreground notification.
     * @param listener AutoRecorderTaskResultListener instance.
     */
    void startRecord(final AutoRecorderController autoRecorderController, final DataType dataType,
        final Map<String, Object> notificationProperties, final VoidOnCompleteListener listener);

    /**
     * Stop recording by specifying the data type.
     *
     * @param autoRecorderController AutoRecorderController instance.
     * @param dataType DataType instance.
     * @param listener AutoRecorderTaskResultListener instance.
     */
    void stopRecord(final AutoRecorderController autoRecorderController, final DataType dataType,
        final VoidOnCompleteListener listener);
}
