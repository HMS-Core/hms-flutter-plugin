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

public interface Method {
    /**
     * Bank card methods
     */
    String BANKCARD_ANALYSE_FRAME = "bankcard#analyseFrame";
    String BANKCARD_ASYNC_ANALYSE_FRAME = "bankcard#asyncAnalyseFrame";
    String BANKCARD_DESTROY = "bankcard#destroy";
    String BANKCARD_IS_AVAILABLE = "bankcard#isAvailable";
    String BANKCARD_STOP = "bankcard#stop";

    /**
     * Form methods
     */
    String FORM_ASYNC_ANALYSE_FRAME = "form#asyncAnalyseFrame";
    String FORM_ANALYSE_FRAME = "form#analyseFrame";
    String FORM_DESTROY = "form#destroy";
    String FORM_IS_AVAILABLE = "form#isAvailable";
    String FORM_STOP = "form#stop";

    /**
     * Text methods
     */
    String TEXT_ASYNC_ANALYSE_FRAME = "text#asyncAnalyseFrame";
    String TEXT_ANALYSE_FRAME = "text#analyseFrame";
    String TEXT_GET_ANALYZE_TYPE = "text#getAnalyzeType";
    String TEXT_DESTROY = "text#destroy";
    String TEXT_IS_AVAILABLE = "text#isAvailable";
    String TEXT_STOP = "text#stop";
    String TEXT_TRANSACTION = "text#transaction";

    /**
     * Text Embedding methods
     */
    String CREATE_TEXT_EMBEDDING_ANALYZER = "createTextEmbeddingAnalyzer";
    String ANALYSE_SENTENCE_VECTOR = "analyseSentenceVector";
    String ANALYSE_SENTENCES_SIMILARITY = "analyseSentencesSimilarity";
    String ANALYSE_SIMILAR_WORDS = "analyseSimilarWords";
    String ANALYSE_WORD_VECTOR = "analyseWordVector";
    String ANALYSE_WORDS_SIMILARITY = "analyseWordsSimilarity";
    String GET_VOCABULARY_VERSION = "getVocabularyVersion";
    String ANALYSE_WORD_VECTOR_BATCH = "analyseWordVectorBatch";

    /**
     * Document methods
     */
    String ASYNC_DOCUMENT_ANALYZE = "asyncDocumentAnalyze";
    String CLOSE = "close";
    String STOP = "stop";

    /**
     * General Card methods
     */
    String CAPTURE_PREVIEW = "capturePreview";
    String CAPTURE_PHOTO = "capturePhoto";
    String CAPTURE_IMAGE = "captureImage";

    /**
     * Id Card methods
     */
    String CAPTURE_ID_CARD = "captureIdCard";
    String ANALYZE_ID_CARD_IMAGE = "analyzeIdCardImage";

    /**
     * Lens methods
     */
    String LENS_INIT = "lens#init";
    String LENS_SETUP = "lens#setup";
    String LENS_RUN = "lens#run";
    String LENS_SWITCH_CAM = "lens#switchCam";
    String LENS_CAPTURE = "lens#capture";
    String LENS_ZOOM = "lens#zoom";
    String LENS_RELEASE = "lens#release";
    String LENS_GET_LENS_TYPE = "lens#getLensType";
    String LENS_GET_DIMENSIONS = "lens#getDimensions";

    /**
     * ML Application methods
     */
    String SET_API_KEY = "setApiKey";
    String SET_ACCESS_TOKEN = "setAccessToken";
    String SET_USER_REGION = "setUserRegion";
    String GET_COUNTRY_CODE = "getCountryCode";
    String ENABLE_LOGGER = "enableLogger";
    String DISABLE_LOGGER = "disableLogger";
}
