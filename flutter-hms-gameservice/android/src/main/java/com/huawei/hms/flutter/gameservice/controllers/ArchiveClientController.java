/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.gameservice.controllers;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.util.Log;
import android.util.Pair;

import com.huawei.hms.flutter.gameservice.common.Constants;
import com.huawei.hms.flutter.gameservice.common.listener.DefaultListResultListener;
import com.huawei.hms.flutter.gameservice.common.listener.DefaultResultListener;
import com.huawei.hms.flutter.gameservice.common.utils.ValueGetter;
import com.huawei.hms.jos.games.ArchivesClient;
import com.huawei.hms.jos.games.Games;
import com.huawei.hms.jos.games.archive.ArchiveDetails;
import com.huawei.hms.jos.games.archive.ArchiveSummary;
import com.huawei.hms.jos.games.archive.ArchiveSummaryUpdate;
import com.huawei.hms.jos.games.archive.OperationResult;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

import java.security.InvalidParameterException;
import java.util.Map;

public class ArchiveClientController {
    private static final String TAG = "ArchiveClientController";

    private Activity activity;

    private ArchivesClient archivesClient;

    public ArchiveClientController(Activity activity) {
        this.activity = activity;
        archivesClient = Games.getArchiveClient(activity);
    }

    public void onMethodCall(final MethodCall call, final Result result) {
        final Pair<String, String> methodNamePair = ValueGetter.methodNameExtractor(call);
        switch (Constants.ArchiveClientController.getEnum(methodNamePair.second)) {
            case ADD_ARCHIVE:
                addArchive(call, result);
                break;
            case REMOVE_ARCHIVE:
                removeArchive(call, result);
                break;
            case GET_LIMIT_THUMBNAIL_SIZE:
                getLimitThumbnailSize(call, result);
                break;
            case GET_LIMIT_DETAILS_SIZE:
                getLimitDetailsSize(call, result);
                break;
            case SHOW_ARCHIVE_LIST_INTENT:
                showArchiveIntent(call, result);
                break;
            case GET_ARCHIVE_SUMMARY_LIST:
                getArchiveSummaryList(call, result);
                break;
            case LOAD_ARCHIVE_DETAILS:
                loadArchiveDetails(call, result);
                break;
            case UPDATE_ARCHIVE_BY_DATA:
                updateArchiveByData(call, result);
                break;
            case UPDATE_ARCHIVE:
                updateArchive(call, result);
                break;
            case GET_THUMBNAIL:
                getThumbnail(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void addArchive(final MethodCall call, final Result result) {
        DefaultResultListener<ArchiveSummary> listener = new DefaultResultListener<>(result, activity, call.method);
        ArchiveDetails archiveDetails = new ArchiveDetails.Builder().build();
        archiveDetails.set(call.argument("detailsContent"));
        ArchiveSummaryUpdate archiveSummaryUpdate = new HMSArchiveSummaryUpdateBuilder(
            call.argument("update")).setAllParams().build();
        boolean isSupportCache = ValueGetter.getBoolean("isSupportCache", call);
        archivesClient.addArchive(archiveDetails, archiveSummaryUpdate, isSupportCache)
            .addOnSuccessListener(listener)
            .addOnFailureListener(listener);
    }

    private void removeArchive(final MethodCall call, final Result result) {
        DefaultResultListener<String> listener = new DefaultResultListener<>(result, activity, call.method);
        Map<String, Object> archiveSummaryMap = ValueGetter.getMap(call.argument("summary"));
        if (archiveSummaryMap.containsKey("id")) {
            // Obtain the summary with the summary id and remove the archive.
            archivesClient.loadArchiveDetails(ValueGetter.getString("id", archiveSummaryMap))
                .addOnSuccessListener(
                    operationResult -> archivesClient.removeArchive(operationResult.getArchive().getSummary())
                        .addOnSuccessListener(listener)
                        .addOnFailureListener(listener))
                .addOnFailureListener(
                    e -> Log.e(TAG, "Error while removing the archive, getSummary is failed: " + e.toString(), null));
        } else {
            result.error(Constants.UNKNOWN_ERROR, "ArchiveSummary id is not present, please check the parameters",
                null);
        }
    }

    private void getLimitThumbnailSize(final MethodCall call, final Result result) {
        DefaultResultListener<Integer> listener = new DefaultResultListener<>(result, activity, call.method);
        archivesClient.getLimitThumbnailSize().addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private void getLimitDetailsSize(final MethodCall call, final Result result) {
        DefaultResultListener<Integer> listener = new DefaultResultListener<>(result, activity, call.method);
        archivesClient.getLimitDetailsSize().addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private void showArchiveIntent(final MethodCall call, final Result result) {
        DefaultResultListener<Intent> listener = new DefaultResultListener<>(result, activity, call.method);
        String title = ValueGetter.getString("title", call);
        boolean allowAddBtn = ValueGetter.getBoolean("allowAddButton", call);
        boolean allowDeleteBtn = ValueGetter.getBoolean("allowDeleteButton", call);
        int maxArchive = ValueGetter.getInt("maxArchive", call);
        archivesClient.getShowArchiveListIntent(title, allowAddBtn, allowDeleteBtn, maxArchive)
            .addOnSuccessListener(listener)
            .addOnFailureListener(listener);
    }

    private void getArchiveSummaryList(final MethodCall call, final Result result) {
        DefaultListResultListener<ArchiveSummary> listener = new DefaultListResultListener<>(result,
            ArchiveSummary.class, activity.getApplicationContext(), call.method);
        boolean isRealTime = ValueGetter.getBoolean("isRealTime", call);
        archivesClient.getArchiveSummaryList(isRealTime).addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private void loadArchiveDetails(final MethodCall call, final Result result) {
        DefaultResultListener<OperationResult> listener = new DefaultResultListener<>(result, activity, call.method);
        /// Set diff strategy to a default value.
        int diffStrategy = 999;
        String archiveId = "";
        // If an archive summary is specified as the argument, parse the archive id.
        if (call.argument("summary") != null) {
            Map<String, Object> summaryMap = ValueGetter.getMap(call.argument("summary"));
            if (summaryMap.containsKey("id")) {
                archiveId = ValueGetter.getString("id", summaryMap);
                if (call.argument("diffStrategy") != null) {
                    diffStrategy = ValueGetter.getInt("diffStrategy", call);
                }
            }
            // If archiveId is specified call loadArchiveDetails by archiveId.
        } else if (call.argument("archiveId") != null) {
            archiveId = ValueGetter.getString("archiveId", call);
            if (call.argument("diffStrategy") != null) {
                diffStrategy = ValueGetter.getInt("diffStrategy", call);
            }
        }
        // Check if default value of diffStrategy is changed. (When specified from Flutter side)
        if (!archiveId.isEmpty()) {
            if (diffStrategy != 999) {
                diffStrategy = ValueGetter.getInt("diffStrategy", call);
                archivesClient.loadArchiveDetails(archiveId, diffStrategy)
                    .addOnSuccessListener(listener)
                    .addOnFailureListener(listener);
            } else {
                archivesClient.loadArchiveDetails(archiveId)
                    .addOnSuccessListener(listener)
                    .addOnFailureListener(listener);
            }
        } else {
            throw new InvalidParameterException("Please specify an ArchiveSummary object or an archiveId.");
        }
    }

    private void updateArchiveByData(final MethodCall call, final Result result) {
        DefaultResultListener<OperationResult> listener = new DefaultResultListener<>(result, activity, call.method);
        String archiveId = ValueGetter.getString("archiveId", call);
        ArchiveSummaryUpdate archiveSummaryUpdate = new HMSArchiveSummaryUpdateBuilder(
            call.argument("update")).setAllParams().build();
        ArchiveDetails archiveDetails = new ArchiveDetails.Builder().build();
        archiveDetails.set(call.argument("archiveContent"));
        archivesClient.updateArchive(archiveId, archiveSummaryUpdate, archiveDetails)
            .addOnSuccessListener(listener)
            .addOnFailureListener(listener);
    }

    private void updateArchive(final MethodCall call, final Result result) {
        DefaultResultListener<OperationResult> listener = new DefaultResultListener<>(result, activity, call.method);
        Map<String, Object> archiveMap = ValueGetter.getMap(call.argument("archive"));
        Map<String, Object> summaryMap = ValueGetter.getMap(archiveMap.get("summary"));
        if (summaryMap.containsKey("id")) {
            String archiveId = ValueGetter.getString("id", summaryMap);
            archivesClient.loadArchiveDetails(archiveId)
                .addOnSuccessListener(operationResult -> archivesClient.updateArchive(operationResult.getArchive())
                    .addOnSuccessListener(listener)
                    .addOnFailureListener(listener))
                .addOnFailureListener(e -> Log.e(TAG,
                    "Error on updateArchive, specified Archive can't be obtained, error is: " + e.toString(), null));
        } else {
            result.error(Constants.UNKNOWN_ERROR, "Archive id can't be obtained", null);
        }
    }

    private void getThumbnail(final MethodCall call, final Result result) {
        DefaultResultListener<Bitmap> listener = new DefaultResultListener<>(result, activity, call.method);
        String archiveId = ValueGetter.getString("archiveId", call);
        archivesClient.getThumbnail(archiveId).addOnSuccessListener(listener).addOnFailureListener(listener);
    }

    private static class HMSArchiveSummaryUpdateBuilder {
        private ArchiveSummaryUpdate.Builder builder;

        private Map<String, Object> callMap;

        HMSArchiveSummaryUpdateBuilder(final Map<String, Object> callMap) {
            this.callMap = callMap;
            this.builder = new ArchiveSummaryUpdate.Builder();
        }

        HMSArchiveSummaryUpdateBuilder setAllParams() {
            return this.setCurrentProgress().setActiveTime().setDescInfo().setThumbnail().setThumbnailMimeType();
        }

        HMSArchiveSummaryUpdateBuilder setActiveTime() {
            if (ValueGetter.hasKey(callMap, "activeTime")) {
                builder.setActiveTime(ValueGetter.getLong("activeTime", callMap));
            }
            return this;
        }

        HMSArchiveSummaryUpdateBuilder setCurrentProgress() {
            if (ValueGetter.hasKey(callMap, "currentProgress")) {
                builder.setCurrentProgress(ValueGetter.getLong("currentProgress", callMap));
            }
            return this;
        }

        HMSArchiveSummaryUpdateBuilder setDescInfo() {
            if (ValueGetter.hasKey(callMap, "descInfo")) {
                builder.setDescInfo(ValueGetter.getString("descInfo", callMap));
            }
            return this;
        }

        HMSArchiveSummaryUpdateBuilder setThumbnail() {
            if (ValueGetter.hasKey(callMap, "thumbnail")) {
                builder.setThumbnail(ValueGetter.getBitmapFromBytes(callMap, "thumbnail"));
            }
            return this;
        }

        HMSArchiveSummaryUpdateBuilder setThumbnailMimeType() {
            if (ValueGetter.hasKey(callMap, "thumbnailMimeType")) {
                builder.setThumbnailMimeType(ValueGetter.getString("thumbnailMimeType", callMap));
            }
            return this;
        }

        ArchiveSummaryUpdate build() {
            return builder.build();
        }
    }

}
