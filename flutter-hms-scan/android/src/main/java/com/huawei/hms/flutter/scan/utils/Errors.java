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

package com.huawei.hms.flutter.scan.utils;

import com.huawei.hms.hmsscankit.ScanUtil;

public enum Errors {

    //Scan Utils Errors
    scanUtilNoCameraPermission(String.valueOf(ScanUtil.ERROR_NO_CAMERA_PERMISSION), "NO CAMERA PERMISSION"),
    scanUtilNoReadPermission(String.valueOf(ScanUtil.ERROR_NO_READ_PERMISSION), "NO READ PERMISSION"),

    //Decode Multi Errors
    decodeMultiAsyncCouldntFind("13", "Multi Async - Couldn't find anything."),
    decodeMultiAsyncOnFailure("14", "Multi Async - On Failure"),
    decodeMultiSyncCouldntFind("15", "Multi Sync - Couldn't find anything."),

    //Multi Processor Camera
    mpCameraScanModeError("16", "Please check your scan mode."),

    //Decode With Bitmap
    decodeWithBitmapError("17", "Please check your barcode and scan type."),

    //Build Bitmap
    buildBitmap("18", "Barcode generation failed."),

    //HmsScanAnalyzer
    hmsScanAnalyzerError("19", "Analyzer is not available."),

    //Remote View Error
    remoteViewError("20", "Remote View is not initialized."),

    //Multi Processor channel initialization
    mpChannelError("21", "Multi Processor Channel cannot be initialized.");

    private final String errorCode;
    private final String errorMessage;

    Errors(String errorCode, String errorMessage) {
        this.errorCode = errorCode;
        this.errorMessage = errorMessage;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

}
