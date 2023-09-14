/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.mlimage.constant;

public interface Method {
    /**
     * Classification methods
     */
    String ASYNC_CLASSIFICATION = "asyncClassification";
    String SYNC_CLASSIFICATION = "syncClassification";
    String GET_ANALYZER_TYPE = "getAnalyzerType";
    String STOP = "stop";

    /**
     * Object Detection & Landmark methods
     */
    String ASYNC_ANALYZE_FRAME = "asyncAnalyzeFrame";
    String ANALYZE_FRAME = "analyzeFrame";
    String STOP_OBJECT_DETECTION = "stopObjectAnalyzer";

    /**
     * Document Skew Correction methods
     */
    String SYNC_DOCUMENT_SKEW_CORRECT = "syncDocumentSkewCorrect";
    String ASYNC_DOCUMENT_SKEW_DETECT = "asyncDocumentSkewDetect";
    String ASYNC_DOCUMENT_SKEW_CORRECT = "asyncDocumentSkewCorrect";

    /**
     * ML Application methods
     */
    String SET_API_KEY = "setApiKey";
    String SET_ACCESS_TOKEN = "setAccessToken";
    String SET_USER_REGION = "setUserRegion";
    String GET_COUNTRY_CODE = "getCountryCode";
    String ENABLE_LOGGER = "enableLogger";
    String DISABLE_LOGGER = "disableLogger";

    /**
     * Custom Model methods
     */
    String CREATE_BITMAP = "createBitmap";
    String DOWNLOAD_REMOTE_MODEL = "downloadRemoteModel";
    String PREPARE_EXECUTOR = "prepareExecutor";
    String START_EXECUTOR = "startExecutor";
    String GET_OUTPUT_INDEX = "getOutputIndex";
    String STOP_EXECUTOR = "stopModelExecutor";
}
