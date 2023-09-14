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

public interface Channel {
    String BASE_CHANNEL = "huawei.hms.flutter.ml.image";
    String CLASSIFICATION_CHANNEL = BASE_CHANNEL + ".classification";
    String APPLICATION_CHANNEL = BASE_CHANNEL + ".application";
    String OBJECT_CHANNEL = BASE_CHANNEL + ".object";
    String LANDMARK_CHANNEL = BASE_CHANNEL + ".landmark";
    String SEGMENTATION_CHANNEL = BASE_CHANNEL + ".segmentation";
    String IMAGE_RESOLUTION_CHANNEL = BASE_CHANNEL + ".image_resolution";
    String DOCUMENT_CORRECTION = BASE_CHANNEL + ".document_correction";
    String TEXT_RESOLUTION = BASE_CHANNEL + ".text_resolution";
    String SCENE = BASE_CHANNEL + ".scene";
    String CUSTOM_MODEL = BASE_CHANNEL + ".custom_model";
    String IMAGE_LENS = BASE_CHANNEL + ".image_lens";
    String PRODUCT = BASE_CHANNEL + ".product";
}
