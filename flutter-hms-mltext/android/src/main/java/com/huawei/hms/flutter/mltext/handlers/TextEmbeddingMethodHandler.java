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

package com.huawei.hms.flutter.mltext.handlers;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mltext.constant.Method;
import com.huawei.hms.flutter.mltext.constant.Param;
import com.huawei.hms.flutter.mltext.utils.Commons;
import com.huawei.hms.flutter.mltext.utils.FromMap;
import com.huawei.hms.flutter.mltext.utils.TextResponseHandler;
import com.huawei.hms.mlsdk.textembedding.MLTextEmbeddingAnalyzer;
import com.huawei.hms.mlsdk.textembedding.MLTextEmbeddingAnalyzerFactory;
import com.huawei.hms.mlsdk.textembedding.MLTextEmbeddingSetting;
import com.huawei.hms.mlsdk.textembedding.MLVocabularyVersion;

import org.json.JSONObject;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class TextEmbeddingMethodHandler implements MethodChannel.MethodCallHandler {
    private final static String TAG = TextEmbeddingMethodHandler.class.getSimpleName();
    private final TextResponseHandler responseHandler;
    private MLTextEmbeddingAnalyzer analyzer;

    public TextEmbeddingMethodHandler(final Activity activity) {
        this.responseHandler = TextResponseHandler.getInstance(activity);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        responseHandler.setup(TAG, call.method, result);
        switch (call.method) {
            case Method.CREATE_TEXT_EMBEDDING_ANALYZER:
                createTextEmbeddingAnalyzer(call);
                break;
            case Method.ANALYSE_SENTENCE_VECTOR:
                analyseSentenceVector(call);
                break;
            case Method.ANALYSE_SENTENCES_SIMILARITY:
                analyseSentencesSimilarity(call);
                break;
            case Method.ANALYSE_SIMILAR_WORDS:
                analyseSimilarWords(call);
                break;
            case Method.ANALYSE_WORD_VECTOR:
                analyseWordVector(call);
                break;
            case Method.ANALYSE_WORDS_SIMILARITY:
                analyseWordsSimilarity(call);
                break;
            case Method.GET_VOCABULARY_VERSION:
                getVocabularyVersion();
                break;
            case Method.ANALYSE_WORD_VECTOR_BATCH:
                analyseWordVectorBatch(call);
                break;
            default:
                result.notImplemented();
                break;
        }

    }

    private void createTextEmbeddingAnalyzer(MethodCall call) {
        final String language = FromMap.toString(Param.LANGUAGE, call.argument(Param.LANGUAGE), false);
        final MLTextEmbeddingSetting setting = new MLTextEmbeddingSetting.Factory().setLanguage(language).create();
        analyzer = MLTextEmbeddingAnalyzerFactory.getInstance().getMLTextEmbeddingAnalyzer(setting);
        responseHandler.success(true);
    }

    private void analyseSentenceVector(MethodCall call) {
        if (analyzer == null) {
            responseHandler.noService();
            return;
        }
        final String sentence = FromMap.toString(Param.SENTENCE, call.argument(Param.SENTENCE), false);
        analyzer.analyseSentenceVector(sentence)
                .addOnSuccessListener(floats -> responseHandler.success(Arrays.asList(floats)))
                .addOnFailureListener(responseHandler::exception);
    }

    private void analyseSentencesSimilarity(MethodCall call) {
        if (analyzer == null) {
            responseHandler.noService();
            return;
        }
        final String sentence1 = FromMap.toString(Param.SENTENCE1, call.argument(Param.SENTENCE1), true);
        final String sentence2 = FromMap.toString(Param.SENTENCE2, call.argument(Param.SENTENCE2), true);
        analyzer.analyseSentencesSimilarity(sentence1, sentence2)
                .addOnSuccessListener(responseHandler::success)
                .addOnFailureListener(responseHandler::exception);
    }

    private void analyseWordVector(MethodCall call) {
        if (analyzer == null) {
            responseHandler.noService();
            return;
        }
        final String word = FromMap.toString(Param.WORD, call.argument(Param.WORD), false);
        analyzer.analyseWordVector(word)
                .addOnSuccessListener(floats -> responseHandler.success(Arrays.asList(floats)))
                .addOnFailureListener(responseHandler::exception);
    }

    private void analyseWordsSimilarity(MethodCall call) {
        if (analyzer == null) {
            responseHandler.noService();
            return;
        }
        final String word1 = FromMap.toString(Param.WORD1, call.argument(Param.WORD1), true);
        final String word2 = FromMap.toString(Param.WORD2, call.argument(Param.WORD2), true);
        analyzer.analyseWordsSimilarity(word1, word2)
                .addOnSuccessListener(responseHandler::success)
                .addOnFailureListener(responseHandler::exception);
    }

    private void analyseSimilarWords(MethodCall call) {
        if (analyzer == null) {
            responseHandler.noService();
            return;
        }
        final String word = FromMap.toString(Param.WORD, call.argument(Param.WORD), false);
        final Integer number = FromMap.toInteger(Param.NUMBER, call.argument(Param.NUMBER));
        analyzer.analyseSimilarWords(word, number != null ? number : 1)
                .addOnSuccessListener(responseHandler::success)
                .addOnFailureListener(responseHandler::exception);
    }

    private void getVocabularyVersion() {
        if (analyzer == null) {
            responseHandler.noService();
            return;
        }
        analyzer.getVocabularyVersion()
                .addOnSuccessListener(mlVocabularyVersion -> responseHandler
                        .success(vocabularyVersionToMap(mlVocabularyVersion).toString()))
                .addOnFailureListener(responseHandler::exception);
    }

    private void analyseWordVectorBatch(@NonNull MethodCall call) {
        if (analyzer == null) {
            responseHandler.noService();
            return;
        }
        final List<String> words = FromMap.toStringArrayList(Param.WORDS, call.argument(Param.WORDS));
        analyzer.analyseWordVectorBatch(Commons.getStringSet(words))
                .addOnSuccessListener(stringMap -> {
                    Map<String, Object> map = new HashMap<>();
                    for (Map.Entry<String, Float[]> m : stringMap.entrySet()) {
                        map.put(m.getKey(), Commons.getArrayFromFloats(m.getValue()));
                    }
                    responseHandler.success(map);
                }).addOnFailureListener(responseHandler::exception);
    }

    private JSONObject vocabularyVersionToMap(MLVocabularyVersion vocabularyVersion) {
        Map<String, Object> vocabularyMap = new HashMap<>();
        vocabularyMap.put(Param.DICTIONARY_DIMENSION, vocabularyVersion.getDictionaryDimension());
        vocabularyMap.put(Param.DICTIONARY_SIZE, vocabularyVersion.getDictionarySize());
        vocabularyMap.put(Param.VERSION_NUMBER, vocabularyVersion.getVersionNo());
        return new JSONObject(vocabularyMap);
    }
}
