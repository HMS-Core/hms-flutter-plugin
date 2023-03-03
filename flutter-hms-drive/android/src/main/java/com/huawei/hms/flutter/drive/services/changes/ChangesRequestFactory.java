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

package com.huawei.hms.flutter.drive.services.changes;

import android.content.Context;

import androidx.annotation.Nullable;

import com.huawei.cloud.services.drive.Drive;
import com.huawei.cloud.services.drive.Drive.Changes;
import com.huawei.cloud.services.drive.DriveRequest;
import com.huawei.cloud.services.drive.model.Channel;
import com.huawei.hms.flutter.drive.common.Constants.ChangesRequestType;
import com.huawei.hms.flutter.drive.common.service.DriveRequestFactory;
import com.huawei.hms.flutter.drive.common.utils.DriveUtils;

import java.io.IOException;

public class ChangesRequestFactory extends DriveRequestFactory implements IChangesRequest {
    public ChangesRequestFactory(Drive drive, Context context) {
        super(drive, context);
    }

    protected <T extends DriveRequest<?>> T buildRequest(ChangesRequestType changesRequestType,
        ChangesRequestOptions requestOptions, @Nullable Channel channel, Class<T> type) throws IOException {
        DriveRequest<?> request;
        switch (changesRequestType) {
            case GET_START_CURSOR:
                request = changesApi().getStartCursor();
                break;
            case LIST:
                request = changesApi().list(requestOptions.getCursor());
                break;
            case SUBSCRIBE:
                request = changesApi().subscribe(requestOptions.getCursor(), channel);
                break;
            default:
                throw new IllegalStateException("Unsupported changes request type");
        }
        if (request != null) {
            // Set the request options and cast it to the given request class.
            return type.cast(requestBuilder(request, requestOptions));
        } else {
            throw new IOException("Couldn't create the changes request");
        }
    }

    private Changes changesApi() {
        return getDrive().changes();
    }

    protected <T extends DriveRequest<?>> T requestBuilder(T request, ChangesRequestOptions requestOptions) {
        if (requestOptions == null) {
            return request;
        }
        // Sets the base drive request options via the base drive request factory class.
        setBasicRequestOptions(request, requestOptions);
        if (request instanceof Drive.Changes.List || request instanceof Drive.Changes.Subscribe) {
            // Comments related options
            setCursor(request, requestOptions.getCursor());
            setContainers(request, requestOptions.getContainers());
            setIncludeDeleted(request, requestOptions.isIncludeDeleted());
            setPageSize(request, requestOptions.getPageSize());
            setCursor(request, requestOptions.getCursor());
        }
        return request;
    }

    @Override
    public void setCursor(DriveRequest<?> request, String cursor) {
        if (DriveUtils.isNotNullAndEmpty(cursor)) {
            if (request instanceof Drive.Changes.List) {
                ((Changes.List) request).setCursor(cursor);
            } else if (request instanceof Drive.Changes.Subscribe) {
                ((Changes.Subscribe) request).setCursor(cursor);
            }
        }
    }

    @Override
    public void setPageSize(DriveRequest<?> request, Integer pageSize) {
        if (pageSize != null && pageSize > 0) {
            if (request instanceof Drive.Changes.List) {
                ((Changes.List) request).setPageSize(pageSize);
            } else if (request instanceof Drive.Changes.Subscribe) {
                ((Changes.Subscribe) request).setPageSize(pageSize);
            }
        }
    }

    @Override
    public void setContainers(DriveRequest<?> request, String containers) {
        if (DriveUtils.isNotNullAndEmpty(containers)) {
            if (request instanceof Drive.Changes.List) {
                ((Changes.List) request).setContainers(containers);
            } else if (request instanceof Drive.Changes.Subscribe) {
                ((Changes.Subscribe) request).setContainers(containers);
            }
        }
    }

    @Override
    public void setIncludeDeleted(DriveRequest<?> request, Boolean includeDeleted) {
        if (includeDeleted == null) {
            includeDeleted = Boolean.FALSE;
        }
        if (request instanceof Changes.List) {
            ((Changes.List) request).setIncludeDeleted(includeDeleted);
        } else if (request instanceof Changes.Subscribe) {
            ((Changes.Subscribe) request).setIncludeDeleted(includeDeleted);
        }
    }
}
