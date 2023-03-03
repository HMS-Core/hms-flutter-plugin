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

package com.huawei.hms.flutter.drive.services.historyversions;

import android.content.Context;

import androidx.annotation.Nullable;

import com.huawei.cloud.services.drive.Drive;
import com.huawei.cloud.services.drive.Drive.HistoryVersions;
import com.huawei.cloud.services.drive.DriveRequest;
import com.huawei.cloud.services.drive.model.HistoryVersion;
import com.huawei.hms.flutter.drive.common.Constants.DriveRequestType;
import com.huawei.hms.flutter.drive.common.service.DriveRequestFactory;
import com.huawei.hms.flutter.drive.common.utils.DriveUtils;

import java.io.IOException;

public class HistoryVersionsRequestFactory extends DriveRequestFactory implements IHistoryVersionsRequest {

    public HistoryVersionsRequestFactory(Drive drive, Context context) {
        super(drive, context);
    }

    protected <T extends DriveRequest<?>> T buildRequest(DriveRequestType driveRequestType,
        HistoryVersionsRequestOptions requestOptions, @Nullable HistoryVersion historyVersion, Class<T> type)
        throws IOException {
        DriveRequest<?> request;
        switch (driveRequestType) {
            case GET:
                request = historyVersionsApi().get(requestOptions.getFileId(), requestOptions.getHistoryVersionId());
                break;
            case DELETE:
                request = historyVersionsApi().delete(requestOptions.getFileId(), requestOptions.getHistoryVersionId());
                break;
            case LIST:
                request = historyVersionsApi().list(requestOptions.getFileId());
                break;
            case UPDATE:
                request = historyVersionsApi().update(requestOptions.getFileId(), requestOptions.getHistoryVersionId(),
                    historyVersion);
                break;
            case CREATE:
                // History Versions does not support create.
                throw new IOException("Unsupported history versions request type");
            default:
                throw new IOException("Unsupported comment request type");
        }
        if (request != null) {
            // Set the request options and cast it to the given request class.
            return type.cast(requestBuilder(request, requestOptions));
        } else {
            throw new IOException("Couldn't create the comments request");
        }
    }

    private HistoryVersions historyVersionsApi() {
        return getDrive().historyVersions();
    }

    protected <T extends DriveRequest<?>> T requestBuilder(T request, HistoryVersionsRequestOptions requestOptions) {
        if (DriveUtils.isNullOrEmpty(requestOptions.getFields())) {
            requestOptions.setFields("*");
        }
        // Sets the base drive request options via the base drive request factory class.
        setBasicRequestOptions(request, requestOptions);

        // History versions related options.
        setFileId(request, requestOptions.getFileId());
        setHistoryVersionId(request, requestOptions.getHistoryVersionId());
        setAcknowledgeDownloadRisk(request, requestOptions.getAcknowledgeDownloadRisk());
        setPageSize(request, requestOptions.getPageSize());
        setCursor(request, requestOptions.getCursor());

        return request;
    }

    @Override
    public void setFileId(DriveRequest<?> request, String fileId) {
        if (DriveUtils.isNullOrEmpty(fileId)) {
            return;
        }
        if (request instanceof HistoryVersions.Delete) {
            ((HistoryVersions.Delete) request).setFileId(fileId);
        } else if (request instanceof HistoryVersions.Get) {
            ((HistoryVersions.Get) request).setFileId(fileId);
        } else if (request instanceof HistoryVersions.Update) {
            ((HistoryVersions.Update) request).setFileId(fileId);
        } else if (request instanceof HistoryVersions.List) {
            ((HistoryVersions.List) request).setFileId(fileId);
        }
    }

    @Override
    public void setHistoryVersionId(DriveRequest<?> request, String historyVersionId) {
        if (DriveUtils.isNullOrEmpty(historyVersionId)) {
            return;
        }
        if (request instanceof HistoryVersions.Delete) {
            ((HistoryVersions.Delete) request).setHistoryVersionId(historyVersionId);
        } else if (request instanceof HistoryVersions.Get) {
            ((HistoryVersions.Get) request).setHistoryVersionId(historyVersionId);
        } else if (request instanceof HistoryVersions.Update) {
            ((HistoryVersions.Update) request).setHistoryVersionId(historyVersionId);
        }
    }

    @Override
    public void setAcknowledgeDownloadRisk(DriveRequest<?> request, Boolean acknowledgeDownloadRisk) {
        if (acknowledgeDownloadRisk == null) {
            acknowledgeDownloadRisk = Boolean.FALSE;
        }
        if (request instanceof HistoryVersions.Get) {
            ((HistoryVersions.Get) request).setAcknowledgeDownloadRisk(acknowledgeDownloadRisk);
        }
    }

    @Override
    public void setPageSize(DriveRequest<?> request, Integer pageSize) {
        if (pageSize != null && pageSize > 0 && request instanceof HistoryVersions.List) {
            ((HistoryVersions.List) request).setPageSize(pageSize);
        }
    }

    @Override
    public void setCursor(DriveRequest<?> request, String cursor) {
        if (DriveUtils.isNullOrEmpty(cursor) && request instanceof HistoryVersions.List) {
            ((HistoryVersions.List) request).setCursor(cursor);
        }
    }
}
