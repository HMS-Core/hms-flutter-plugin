/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.mltext.constant;

public interface CallbackTypes {
    String BCR_CANCELED = "Bank card capture canceled";
    String GCR_CANCELED = "General card capture canceled";
    String ID_CARD_CANCELED = "Id card recognition canceled!";
    String BCR_FAILED = "Bank card capture failed";
    String GCR_FAILED = "General card capture failed";
    String ID_CARD_FAILED = "Id card recognition failed!";
    String FORM_FAILED = "Sync form recognition failed";
    String BCR_DENIED = "Bank card capture denied";
    String GCR_DENIED = "General card capture denied";
    String ID_CARD_DENIED = "Id card recognition denied!";
    String LENS_CAPTURE = "Lens capture";
    String LENS_IS_NULL = "Lens engine is null";
    String LENS_ANALYZER_TYPE = "Analyzer type must be provided!";
    String LENS_TEXTURE = "Lens texture is not initialized!";
    String LENS_ENGINE = "Lens engine is not initialized!";
    String NOT_INITIALIZED = "ml-text-001";
}
