/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_scan;

class HmsScanError {
  final String? errorCode;
  final String? errorMessage;

  const HmsScanError({
    this.errorCode,
    this.errorMessage,
  });
}

class HmsScanErrors {
  //Default View Errors
  static const HmsScanError scanUtilNoCameraPermission = HmsScanError(
    errorCode: '1',
    errorMessage: 'No Camera Permission',
  );
  static const HmsScanError scanUtilNoReadPermission = HmsScanError(
    errorCode: '2',
    errorMessage: 'No Read Permission',
  );

  //Decode Multi Errors
  static const HmsScanError decodeMultiAsyncCouldntFind = HmsScanError(
    errorCode: '13',
    errorMessage: "Multi Async - Couldn't find anything.",
  );
  static const HmsScanError decodeMultiAsyncOnFailure = HmsScanError(
    errorCode: '14',
    errorMessage: 'Multi Async - On Failure',
  );
  static const HmsScanError decodeMultiSyncCouldntFind = HmsScanError(
    errorCode: '15',
    errorMessage: "Multi Sync - Couldn't find anything.",
  );

  //Multi Processor Camera
  static const HmsScanError mpCameraScanModeError = HmsScanError(
    errorCode: '16',
    errorMessage: 'Please check your scan mode.',
  );

  //Decode With Bitmap
  static const HmsScanError decodeWithBitmapError = HmsScanError(
    errorCode: '17',
    errorMessage: 'Please check your barcode and scan type.',
  );

  //Build Bitmap
  static const HmsScanError buildBitmap = HmsScanError(
    errorCode: '18',
    errorMessage: 'Barcode generation failed.',
  );

  //Analyzer Error
  static const HmsScanError hmsScanAnalyzerError = HmsScanError(
    errorCode: '19',
    errorMessage: 'Analyzer is not available.',
  );

  //Remote View Error
  static const HmsScanError remoteViewError = HmsScanError(
    errorCode: '20',
    errorMessage: 'Remote View is not initialized.',
  );

  //Multi Processor channel initialization
  static const HmsScanError mpChannelError = HmsScanError(
    errorCode: '21',
    errorMessage: 'Multi Processor Channel cannot be initialized.',
  );

  //Decode
  static const HmsScanError ScanNoDetected = HmsScanError(
    errorCode: '4096',
    errorMessage: 'No barcode is detected.',
  );
}
