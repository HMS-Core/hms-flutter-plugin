/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

package com.huawei.hms.flutter.site.listeners;

import android.content.Context;

import com.huawei.hms.flutter.site.utils.HMSLogger;
import com.huawei.hms.flutter.site.utils.ObjectSerializer;
import com.huawei.hms.site.api.SearchResultListener;
import com.huawei.hms.site.api.model.SearchStatus;

import io.flutter.plugin.common.MethodChannel.Result;

public class SearchResultListenerImpl<T> implements SearchResultListener<T> {
    private final Context context;
    private final Result result;
    private final String methodName;

    public SearchResultListenerImpl(final Context context, final Result result, final String methodName) {
        this.context = context;
        this.result = result;
        this.methodName = methodName;
    }

    @Override
    public void onSearchResult(final T o) {
        result.success(ObjectSerializer.INSTANCE.toJson(o));
        HMSLogger.getInstance(context).sendSingleEvent(methodName);
    }

    @Override
    public void onSearchError(final SearchStatus searchStatus) {
        final String errorCode = searchStatus.getErrorCode();
        final String errorMessage = searchStatus.getErrorCode();
        result.error(errorCode, errorMessage, null);
        HMSLogger.getInstance(context).sendSingleEvent(methodName, errorCode);
    }
}
