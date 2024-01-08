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

package com.huawei.hms.flutter.health.modules.datacontroller.service;

import com.huawei.hms.flutter.health.foundation.listener.ResultListener;
import com.huawei.hms.flutter.health.foundation.listener.VoidResultListener;
import com.huawei.hms.hihealth.DataController;
import com.huawei.hms.hihealth.data.DataType;
import com.huawei.hms.hihealth.data.SampleSet;
import com.huawei.hms.hihealth.options.DeleteOptions;
import com.huawei.hms.hihealth.options.ReadOptions;
import com.huawei.hms.hihealth.options.UpdateOptions;
import com.huawei.hms.hihealth.result.ReadReply;

import java.util.List;

public interface DataControllerService {
    /**
     * Insert the user's fitness and health data into the Health platform.
     *
     * @param dataController {@link DataController} instance.
     * @param sampleSet {@link SampleSet} instance.
     * @param voidResultListener {@link VoidResultListener} listener.
     */
    void insertData(final DataController dataController, final SampleSet sampleSet,
        final VoidResultListener voidResultListener);

    /**
     * Deleting the User's Fitness and Health Data
     *
     * <p>
     * Note: Only historical data that has been inserted by the current app can be deleted from the Health platform.
     * </p>
     *
     * @param dataController {@link DataController} instance.
     * @param deleteOptions {@link DeleteOptions} instance.
     * @param voidResultListener {@link VoidResultListener} listener.
     */
    void deleteData(final DataController dataController, final DeleteOptions deleteOptions,
        final VoidResultListener voidResultListener);

    /**
     * Updating the User's Fitness and Health Data
     * </br>
     * 1. Build the condition for data update: a DataCollector object. 2. Build the sampling data set for the update:
     * create a sampling data set for the update based on the data collector. 3. Build the start time, end time, and
     * incremental step count for a DataType sampling point for the update. 4. Build a DataType sampling point for the
     * update 5. Add an updated DataType sampling point to the sampling data set for the update. You can add more
     * updated sampling points to the sampling data set for the update. 6. Build a parameter object for the update. 7.
     * Use the specified parameter object for the update to call the data controller to modify the sampling dataset.
     *
     * @param dataController {@link DataController} instance.
     * @param updateOptions {@link UpdateOptions} instance.
     * @param voidResultListener {@link VoidResultListener} listener.
     */
    void updateData(final DataController dataController, final UpdateOptions updateOptions,
        final VoidResultListener voidResultListener);

    /**
     * Querying the User's Fitness and Health Data
     * <p>
     * Note: To read historical data from the Health platform, for example, to read the number of steps taken within a
     * period of time, you can specify the read conditions in ReadOptions. Furthermore, you can specify the data
     * collector, data type, and detailed data. If data is read, the data set will be returned.
     * </p>
     *
     * @param dataController {@link DataController} instance.
     * @param readOptions {@link ReadOptions} instance.
     * @param dataResultListener {@link VoidResultListener} listener.
     */
    void readData(final DataController dataController, final ReadOptions readOptions,
        final ResultListener<ReadReply> dataResultListener);

    /**
     * Querying the Summary Fitness and Health Data of the User of the Current day
     *
     * @param dataController {@link DataController} instance.
     * @param dataType {@link DataType} instance.
     * @param dataResultListener {@link VoidResultListener} listener.
     */
    void readToday(final DataController dataController, final DataType dataType,
        final ResultListener<SampleSet> dataResultListener);

    /**
     * Querying the Summary Fitness and Health Data of the User of the Current day for multiple data types.
     *
     * @param dataController {@link DataController} instance.
     * @param dataTypes {@link List<DataType>} instance.
     * @param dataResultListener {@link VoidResultListener} listener.
     */
    void readTodayList(final DataController dataController, final List<DataType> dataTypes,
        final ResultListener<List> dataResultListener);

    /**
     * Querying the Summary Fitness and Health Data of the User between selected dates.
     *
     * @param dataController {@link DataController} instance.
     * @param dataType {@link DataType} instance.
     * @param startTime An 8-digit integer in the format of YYYYMMDD, for example, 20200803.
     * @param endTime An 8-digit integer in the format of YYYYMMDD, for example, 20200903.
     * @param dataResultListener {@link ResultListener } listener.
     */
    void readDailySummation(DataController dataController, DataType dataType, int startTime, int endTime,
        final ResultListener<SampleSet> dataResultListener);

    /**
     * Querying the Summary Fitness and Health Data of the User between selected dates.
     *
     * @param dataController {@link DataController} instance.
     * @param dataTypes {@link List<DataType>} instance.
     * @param startTime An 8-digit integer in the format of YYYYMMDD, for example, 20200803.
     * @param endTime An 8-digit integer in the format of YYYYMMDD, for example, 20200903.
     * @param dataResultListener {@link ResultListener } listener.
     */
    void readDailySummationList(DataController dataController, List<DataType> dataTypes, int startTime, int endTime,
        final ResultListener<List> dataResultListener);

    /**
     * Clearing the User's Fitness and Health Data from the Device and Cloud
     *
     * @param dataController {@link DataController} instance.
     * @param voidResultListener {@link VoidResultListener} listener.
     */
    void clearTaskData(final DataController dataController, final VoidResultListener voidResultListener);
}
