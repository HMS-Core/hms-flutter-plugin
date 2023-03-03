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

package com.huawei.hms.flutter.drive.services.files;

import android.content.Context;

import com.huawei.cloud.base.http.AbstractInputStreamContent;
import com.huawei.cloud.services.drive.Drive;
import com.huawei.cloud.services.drive.Drive.Files;
import com.huawei.cloud.services.drive.Drive.Files.Copy;
import com.huawei.cloud.services.drive.Drive.Files.Delete;
import com.huawei.cloud.services.drive.Drive.Files.EmptyRecycle;
import com.huawei.cloud.services.drive.Drive.Files.Get;
import com.huawei.cloud.services.drive.Drive.Files.List;
import com.huawei.cloud.services.drive.Drive.Files.Subscribe;
import com.huawei.cloud.services.drive.Drive.Files.Update;
import com.huawei.cloud.services.drive.DriveRequest;
import com.huawei.cloud.services.drive.model.Channel;
import com.huawei.cloud.services.drive.model.File;
import com.huawei.hms.flutter.drive.common.Constants.FilesRequestType;
import com.huawei.hms.flutter.drive.common.service.DriveRequestFactory;

import java.io.IOException;

public class FilesRequestFactory extends DriveRequestFactory implements IFilesRequest {

    public FilesRequestFactory(final Drive drive, Context context) {
        super(drive, context);
    }

    protected <T extends DriveRequest<?>> T buildRequest(final FilesRequestType driveRequestType,
        final FilesRequestOptions requestOptions, final Class<T> type, final File file,
        final AbstractInputStreamContent fileContent, final Channel channel) throws IOException {
        final DriveRequest<?> request;
        switch (driveRequestType) {
            case COPY:
                request = filesApi().copy(requestOptions.getFileId(), file);
                break;
            case CREATE:
                if (fileContent == null) {
                    request = filesApi().create(file);
                } else {
                    request = filesApi().create(file, fileContent);
                }
                break;
            case DELETE:
                request = filesApi().delete(requestOptions.getFileId());
                break;
            case EMPTY_RECYCLE:
                request = filesApi().emptyRecycle();
                break;
            case GET:
                request = filesApi().get(requestOptions.getFileId());
                break;
            case LIST:
                request = filesApi().list();
                break;
            case UPDATE:
                if (fileContent == null) {
                    request = filesApi().update(requestOptions.getFileId(), file);
                } else {
                    request = filesApi().update(requestOptions.getFileId(), file, fileContent);
                }
                break;
            case SUBSCRIBE:
                request = filesApi().subscribe(requestOptions.getFileId(), channel);
                break;
            default:
                throw new IOException("Unsupported files request type");
        }
        if (request != null) {
            // Set the request options and cast it to the given request class.
            return type.cast(requestBuilder(request, requestOptions));
        } else {
            throw new IOException("Couldn't create the files request");
        }
    }

    private Files filesApi() {
        return getDrive().files();
    }

    protected <T extends DriveRequest<?>> T requestBuilder(final T request, final FilesRequestOptions requestOptions) {
        // Sets the base drive request options via the base drive request factory class.
        setBasicRequestOptions(request, requestOptions);

        // Files related options
        setFileId(request, requestOptions.getFileId());
        setContainers(request, requestOptions.getContainers());
        setAcknowledgeDownloadRisk(request, requestOptions.getAcknowledgeDownloadRisk());
        setOrderBy(request, requestOptions.getOrderBy());
        setQueryParam(request, requestOptions.getQueryParam());
        setPageSize(request, requestOptions.getPageSize());
        setCursor(request, requestOptions.getCursor());
        setAddParentFolder(request, requestOptions.getAddParentFolder());
        setRemoveParentFolder(request, requestOptions.getRemoveParentFolder());
        return request;
    }

    @Override
    public void setFileId(final DriveRequest<?> request, final String fileID) {
        if (request instanceof Files.Copy) {
            ((Copy) request).setFileId(fileID);
        } else if (request instanceof Files.Delete) {
            ((Delete) request).setFileId(fileID);
        } else if (request instanceof Files.Get) {
            ((Get) request).setFileId(fileID);
        } else if (request instanceof Files.Update) {
            ((Update) request).setFileId(fileID);
        } else if (request instanceof Files.Subscribe) {
            ((Subscribe) request).setFileId(fileID);
        }
    }

    @Override
    public void setContainers(final DriveRequest<?> request, final String containers) {
        if (request instanceof Files.EmptyRecycle) {
            ((EmptyRecycle) request).setContainers(containers);
        } else if (request instanceof Files.List) {
            ((List) request).setContainers(containers);
        }
    }

    @Override
    public void setAcknowledgeDownloadRisk(final DriveRequest<?> request, final Boolean acknowledgeDownloadRisk) {
        if (request instanceof Files.Get) {
            ((Get) request).setAcknowledgeDownloadRisk(acknowledgeDownloadRisk);
        }
    }

    @Override
    public void setOrderBy(final DriveRequest<?> request, final String orderBy) {
        if (request instanceof Files.List) {
            ((List) request).setOrderBy(orderBy);
        }
    }

    @Override
    public void setQueryParam(final DriveRequest<?> request, final String queryParam) {
        if (request instanceof Files.List) {
            ((List) request).setQueryParam(queryParam);
        }
    }

    @Override
    public void setPageSize(final DriveRequest<?> request, final Integer pageSize) {
        if (request instanceof Files.List) {
            ((List) request).setPageSize(pageSize);
        }
    }

    @Override
    public void setCursor(final DriveRequest<?> request, final String cursor) {
        if (request instanceof Files.List) {
            ((List) request).setCursor(cursor);
        }
    }

    @Override
    public void setAddParentFolder(final DriveRequest<?> request, final String addParentFolder) {
        if (request instanceof Files.Update) {
            ((Update) request).setAddParentFolder(addParentFolder);
        }
    }

    @Override
    public void setRemoveParentFolder(final DriveRequest<?> request, final String removeParentFolder) {
        if (request instanceof Files.Update) {
            ((Update) request).setRemoveParentFolder(removeParentFolder);
        }
    }
}
