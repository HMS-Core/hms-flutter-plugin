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

package com.huawei.hms.flutter.health.modules.settingcontroller.service;

import com.huawei.hms.flutter.health.foundation.listener.ResultListener;
import com.huawei.hms.flutter.health.foundation.listener.VoidResultListener;
import com.huawei.hms.hihealth.SettingController;
import com.huawei.hms.hihealth.data.DataType;
import com.huawei.hms.hihealth.options.DataTypeAddOptions;

public interface DefaultSettingControllerService {
    /**
     * Creates and adds a customized data type.
     * <p>
     * The name of the created data type must be prefixed with the package name of the app. Otherwise, the creation
     * fails.
     *
     * @param settingController {@link SettingController} instance.
     * @param options {@link DataTypeAddOptions} instance that includes request options for creating the data
     * type.
     * @param resultListener {@link ResultListener} listener
     */
    void addDataType(final SettingController settingController, final DataTypeAddOptions options,
        final ResultListener<DataType> resultListener);

    /**
     * Disables the Health Kit function, cancels user authorization, and cancels all data records. (The task takes
     * effect in 24 hours.)
     *
     * @param settingController {@link SettingController} instance.
     * @param voidResultListener {@link VoidResultListener} listener.
     */
    void disableHiHealth(final SettingController settingController, final VoidResultListener voidResultListener);

    /**
     * Reads the data type based on the data type name.
     * <p>
     * This method is used to read the customized data types of the app.
     *
     * @param settingController {@link SettingController} instance.
     * @param dataTypeName Data type name.
     * @param resultListener {@link ResultListener} listener.
     */
    void readDataType(final SettingController settingController, final String dataTypeName,
        final ResultListener<DataType> resultListener);

    /**
     * Checks the user privacy authorization to Health Kit.
     * <p>
     * If the authorization has not been granted, the user will be redirected to the authorization screen where they can
     * authorize the Huawei Health app to open data to Health Kit.
     *
     * @param settingController {@link SettingController} instance.
     * @param voidResultListener {@link VoidResultListener} listener.
     */
    void checkHealthAppAuthorization(final SettingController settingController,
        final VoidResultListener voidResultListener);

    /**
     * Checks the user privacy authorization to Health Kit.
     *
     * @param settingController {@link SettingController} instance.
     * @param resultListener {@link ResultListener} listener.
     */
    void getHealthAppAuthorization(final SettingController settingController,
        final ResultListener<Boolean> resultListener);
}
