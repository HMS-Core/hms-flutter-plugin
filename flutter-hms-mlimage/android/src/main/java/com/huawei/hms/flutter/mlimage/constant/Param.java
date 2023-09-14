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

public interface Param {
    // Classification params
    String CLASSIFICATION_IDENTITY = "classificationIdentity";
    String NAME = "name";
    String POSSIBILITY = "possibility";
    String PATH = "path";
    String IS_REMOTE = "isRemote";

    // Object Detection params
    String BORDER = "border";
    String TRACING_IDENTITY = "tracingIdentity";
    String TYPE = "type";

    // Landmark params
    String LANDMARK = "landmark";
    String LANDMARK_IDENTITY = "landmarkIdentity";
    String POSITION_INFOS = "positionInfos";

    // Segmentation params
    String FOREGROUND = "foreground";
    String GRAYSCALE = "grayscale";
    String MASKS = "masks";
    String ORIGINAL = "original";

    // Super Resolution params
    String BYTES = "bytes";

    // Document Skew params
    String LEFT_TOP = "leftTop";
    String RIGHT_TOP = "rightTop";
    String LEFT_BOTTOM = "leftBottom";
    String RIGHT_BOTTOM = "rightBottom";
    String RESULT_CODE = "resultCode";

    // Application params
    String KEY = "key";
    String TOKEN = "token";

    // Scene Detection params
    String RESULT = "result";
    String CONFIDENCE = "confidence";

    // Custom Model params
    String MODEL_NAME = "modelName";
    String ASSET_PATH = "assetPath";
    String LABEL_FILE_NAME = "labelFileName";
    String SETTINGS = "settings";
    String INPUTS = "inputs";
    String OUTPUTS = "outputs";
}
