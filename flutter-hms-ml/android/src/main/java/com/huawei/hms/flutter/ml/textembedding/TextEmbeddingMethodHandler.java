/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.ml.textembedding;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.hmf.tasks.Task;
import com.huawei.hms.flutter.ml.logger.HMSLogger;
import com.huawei.hms.flutter.ml.utils.HmsMlUtils;
import com.huawei.hms.flutter.ml.utils.MlConstants;
import com.huawei.hms.mlsdk.textembedding.MLTextEmbeddingAnalyzer;
import com.huawei.hms.mlsdk.textembedding.MLTextEmbeddingAnalyzerFactory;
import com.huawei.hms.mlsdk.textembedding.MLTextEmbeddingException;
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

    private Activity activity;
    private MethodChannel.Result mResult;
    private MLTextEmbeddingAnalyzer analyzer;

    public TextEmbeddingMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            case "createTextEmbeddingAnalyzer":
                createTextEmbeddingAnalyzer(call);
                break;
            case "analyseSentenceVector":
                analyseSentenceVector(call);
                break;
            case "analyseSentencesSimilarity":
                analyseSentencesSimilarity(call);
                break;
            case "analyseSimilarWords":
                analyseSimilarWords(call);
                break;
            case "analyseWordVector":
                analyseWordVector(call);
                break;
            case "analyseWordsSimilarity":
                analyseWordsSimilarity(call);
                break;
            case "getVocabularyVersion":
                getVocabularyVersion();
                break;
            case "analyseWordVectorBatch":
                analyseWordVectorBatch(call);
                break;
            default:
                mResult.notImplemented();
                break;
        }

    }

    private void createTextEmbeddingAnalyzer(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("createTextEmbeddingAnalyzer");
        String language = call.argument("language");
        MLTextEmbeddingSetting setting = new MLTextEmbeddingSetting.Factory().setLanguage(language).create();
        this.analyzer = MLTextEmbeddingAnalyzerFactory.getInstance().getMLTextEmbeddingAnalyzer(setting);
        HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("createTextEmbeddingAnalyzer");
        mResult.success(true);
    }

    private void analyseSentenceVector(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("analyseSentenceVector");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseSentenceVector", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }
        String sentence = call.argument("sentence");

        if (sentence == null || sentence.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseSentenceVector", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Sentence is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        Task<Float[]> sentenceVectorTask = analyzer.analyseSentenceVector(sentence);
        sentenceVectorTask.addOnSuccessListener(floats -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseSentenceVector");
            mResult.success(Arrays.asList(floats));
        }).addOnFailureListener(e -> {
            if (e instanceof MLTextEmbeddingException) {
                MLTextEmbeddingException embeddingException = (MLTextEmbeddingException) e;
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseSentenceVector", String.valueOf(embeddingException.getErrCode()));
                mResult.error(TAG, embeddingException.getMessage(), embeddingException.getErrCode());
            } else {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseSentenceVector", e.getMessage());
                mResult.error(TAG, e.getMessage(), "");
            }
        });
    }

    private void analyseSentencesSimilarity(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("analyseSentencesSimilarity");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseSentencesSimilarity", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }

        String sentence1 = call.argument("sentence1");
        String sentence2 = call.argument("sentence2");

        if (sentence1 == null || sentence1.isEmpty() || sentence2 == null || sentence2.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseSentencesSimilarity", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Sentences must not be null", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        Task<Float> sentencesSimilarityTask = analyzer.analyseSentencesSimilarity(sentence1, sentence2);
        sentencesSimilarityTask.addOnSuccessListener(aFloat -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseSentencesSimilarity");
            mResult.success(aFloat);
        }).addOnFailureListener(e -> {
            if (e instanceof MLTextEmbeddingException) {
                MLTextEmbeddingException embeddingException = (MLTextEmbeddingException) e;
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseSentencesSimilarity", String.valueOf(embeddingException.getErrCode()));
                mResult.error(TAG, embeddingException.getMessage(), embeddingException.getErrCode());
            } else {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseSentencesSimilarity", e.getMessage());
                mResult.error(TAG, e.getMessage(), "");
            }
        });
    }

    private void analyseWordVector(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("analyseWordVector");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseWordVector", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }

        String word = call.argument("word");

        if (word == null || word.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseWordVector", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Word is missing", MlConstants.ILLEGAL_PARAMETER);
            return;
        }
        Task<Float[]> wordVectorTask = analyzer.analyseWordVector(word);
        wordVectorTask.addOnSuccessListener(floats -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseWordVector");
            mResult.success(Arrays.asList(floats));
        }).addOnFailureListener(e -> {
            if (e instanceof MLTextEmbeddingException) {
                MLTextEmbeddingException embeddingException = (MLTextEmbeddingException) e;
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseWordVector", String.valueOf(embeddingException.getErrCode()));
                mResult.error(TAG, embeddingException.getMessage(), embeddingException.getErrCode());
            } else {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseWordVector", e.getMessage());
                mResult.error(TAG, e.getMessage(), "");
            }
        });
    }

    private void analyseWordsSimilarity(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("analyseWordsSimilarity");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseWordsSimilarity", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }

        String word1 = call.argument("word1");
        String word2 = call.argument("word2");

        if (word1 == null || word1.isEmpty() || word2 == null || word2.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseWordsSimilarity", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Parameters must not be null", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        Task<Float> wordsSimilarityTask = analyzer.analyseWordsSimilarity(word1, word2);
        wordsSimilarityTask.addOnSuccessListener(aFloat -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseWordsSimilarity");
            mResult.success(aFloat);
        }).addOnFailureListener(e -> {
            if (e instanceof MLTextEmbeddingException) {
                MLTextEmbeddingException embeddingException = (MLTextEmbeddingException) e;
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseWordsSimilarity", String.valueOf(embeddingException.getErrCode()));
                mResult.error(TAG, embeddingException.getMessage(), embeddingException.getErrCode());
            } else {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseWordsSimilarity", e.getMessage());
                mResult.error(TAG, e.getMessage(), "");
            }
        });
    }

    private void analyseSimilarWords(MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("analyseSimilarWords");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseSimilarWords", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }

        String word = call.argument("word");
        Integer number = call.argument("number");

        if (word == null || word.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseSimilarWords", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Word must not be null", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        Task<List<String>> multipleSimilarityWordsTask = analyzer.analyseSimilarWords(word, number != null ? number : 1);
        multipleSimilarityWordsTask.addOnSuccessListener(strings -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseSimilarWords");
            mResult.success(strings);
        }).addOnFailureListener(e -> {
            if (e instanceof MLTextEmbeddingException) {
                MLTextEmbeddingException embeddingException = (MLTextEmbeddingException) e;
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseSimilarWords", String.valueOf(embeddingException.getErrCode()));
                mResult.error(TAG, embeddingException.getMessage(), embeddingException.getErrCode());
            } else {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseSimilarWords", e.getMessage());
                mResult.error(TAG, e.getMessage(), "");
            }
        });
    }

    private void getVocabularyVersion() {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("getVocabularyVersion");
        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getVocabularyVersion", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }

        Task<MLVocabularyVersion> vocabularyVersionTask = analyzer.getVocabularyVersion();
        vocabularyVersionTask.addOnSuccessListener(mlVocabularyVersion -> {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getVocabularyVersion");
            mResult.success(vocabularyVersionToMap(mlVocabularyVersion).toString());
        }).addOnFailureListener(e -> {
            if (e instanceof MLTextEmbeddingException) {
                MLTextEmbeddingException embeddingException = (MLTextEmbeddingException) e;
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getVocabularyVersion", String.valueOf(embeddingException.getErrCode()));
                mResult.error(TAG, embeddingException.getMessage(), embeddingException.getErrCode());
            } else {
                HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("getVocabularyVersion", e.getMessage());
                mResult.error(TAG, e.getMessage(), "");
            }
        });
    }

    private void analyseWordVectorBatch(@NonNull MethodCall call) {
        HMSLogger.getInstance(activity.getApplicationContext()).startMethodExecutionTimer("analyseWordVectorBatch");
        List<String> words = call.argument("words");

        if (analyzer == null) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseWordVectorBatch", MlConstants.UNINITIALIZED_ANALYZER);
            mResult.error(TAG, "Analyzer is not initialized", MlConstants.UNINITIALIZED_ANALYZER);
            return;
        }

        if (words == null || words.isEmpty()) {
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseWordVectorBatch", MlConstants.ILLEGAL_PARAMETER);
            mResult.error(TAG, "Set of words must not be null", MlConstants.ILLEGAL_PARAMETER);
            return;
        }

        Task<Map<String, Float[]>> vectorBatchTask = analyzer.analyseWordVectorBatch(HmsMlUtils.getStringSet(words));

        vectorBatchTask.addOnSuccessListener(stringMap -> {
            Map<String, Object> map = new HashMap<>();
            for (Map.Entry<String, Float[]> m : stringMap.entrySet()) {
                map.put(m.getKey(), HmsMlUtils.getArrayFromFloats(m.getValue()));
            }
            HMSLogger.getInstance(activity.getApplicationContext()).sendSingleEvent("analyseWordVectorBatch");
            mResult.success(map);
        }).addOnFailureListener(e -> HmsMlUtils.handleException(activity, TAG, e, "analyseWordVectorBatch", mResult));
    }

    private JSONObject vocabularyVersionToMap(MLVocabularyVersion vocabularyVersion) {
        Map<String, Object> vocabularyMap = new HashMap<>();
        vocabularyMap.put("dictionaryDimension", vocabularyVersion.getDictionaryDimension());
        vocabularyMap.put("dictionarySize", vocabularyVersion.getDictionarySize());
        vocabularyMap.put("versionNumber", vocabularyVersion.getVersionNo());
        return new JSONObject(vocabularyMap);
    }
}
