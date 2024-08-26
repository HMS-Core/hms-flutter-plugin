/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.mltext.constant;

public interface Channel {
    String BASE_CHANNEL = "huawei.hms.flutter.ml.text";
    String TEXT_ANALYZER_CHANNEL = BASE_CHANNEL + ".text_analyzer";
    String DOCUMENT_CHANNEL = BASE_CHANNEL + ".document";
    String BANKCARD_CHANNEL = BASE_CHANNEL + ".bankcard";
    String GCR_CHANNEL = BASE_CHANNEL + ".gcr";
    String FORM_CHANNEL = BASE_CHANNEL + ".form";
    String ICR_CHANNEL = BASE_CHANNEL + ".icr";
    String TEXT_EMBEDDING_CHANNEL = BASE_CHANNEL + ".text_embedding";
    String APPLICATION_CHANNEL = BASE_CHANNEL + ".application";
    String LENS_CHANNEL = BASE_CHANNEL + ".lens";
    String NO_SERVICE_WARNING = "Analyzer or engine must be initialized first!";
    String CHANNEL_REMOTE_KEY = "channelRemoteId";
    String CUSTOMIZED_VIEW = BASE_CHANNEL + ".customized_view";
    String REMOTE_VIEW = BASE_CHANNEL + ".remote_view";
}
