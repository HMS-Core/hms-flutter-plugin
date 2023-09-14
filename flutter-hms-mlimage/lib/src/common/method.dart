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

part of huawei_ml_image;

/// Classification
const String asyncClassification = 'asyncClassification';
const String syncClassification = 'syncClassification';
const String mStop = 'stop';
const String mGetAnalyzerType = 'getAnalyzerType';

/// Object
const String mAnalyzeFrame = 'analyzeFrame';
const String mAsyncAnalyzeFrame = 'asyncAnalyzeFrame';
const String stopObject = 'stopObjectAnalyzer';

/// Document Skew Correction
const String mSyncDocumentSkewCorrect = 'syncDocumentSkewCorrect';
const String mAsyncDocumentSkewDetect = 'asyncDocumentSkewDetect';
const String mAsyncDocumentSkewCorrect = 'asyncDocumentSkewCorrect';

/// Custom Model
const String mCreateBitmap = 'createBitmap';
const String mDownloadRemoteModel = 'downloadRemoteModel';
const String mPrepareExecutor = 'prepareExecutor';
const String mStartExecutor = 'startExecutor';
const String mGetOutputIndex = 'getOutputIndex';
const String mStopModelExecutor = 'stopModelExecutor';

/// Product Vision
const String mAnalyzeProduct = 'analyzeProduct';
const String mAnalyzeProductWithPlugin = 'analyzeProductWithPlugin';
const String mStopProductAnalyzer = 'stopProductAnalyzer';

/// Lens Engine
const String setup = 'lens#setup';
const String mInit = 'lens#init';
const String mRun = 'lens#run';
const String mRelease = 'lens#release';
const String mCapture = 'lens#capture';
const String mZoom = 'lens#zoom';
const String mGetLensType = 'lens#getLensType';
const String mGetDimensions = 'lens#getDimensions';
const String mSwitchCam = 'lens#switchCam';
