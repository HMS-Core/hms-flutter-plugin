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

class MLDocumentSkewCorrectionAnalyzer {
  /// Text box correction failed.
  static const int CORRECTION_FAILED = 2;

  /// Text box detection failed.
  static const int DETECT_FAILED = 1;

  /// Incorrect input parameter for text box detection/correction.
  static const int IMAGE_DATA_ERROR = 3;

  /// Text box detection/correction succeeded.
  static const int SUCCESS = 0;

  late MethodChannel _channel;

  MLDocumentSkewCorrectionAnalyzer() {
    _channel = const MethodChannel('$baseChannel.document_correction');
  }

  Future<MLDocumentSkewDetectResult> analyseFrame(String imagePath) async {
    return MLDocumentSkewDetectResult.fromJson(
      json.decode(
        await _channel.invokeMethod(
          mAnalyzeFrame,
          <String, dynamic>{
            'path': imagePath,
          },
        ),
      ),
    );
  }

  Future<MLDocumentSkewCorrectionResult> syncDocumentSkewCorrect() async {
    return MLDocumentSkewCorrectionResult.fromJson(
      await _channel.invokeMethod(
        mSyncDocumentSkewCorrect,
      ),
    );
  }

  Future<MLDocumentSkewDetectResult> asyncDocumentSkewDetect(
    String imagePath,
  ) async {
    return MLDocumentSkewDetectResult.fromJson(
      json.decode(
        await _channel.invokeMethod(
          mAsyncDocumentSkewDetect,
          <String, dynamic>{
            'path': imagePath,
          },
        ),
      ),
    );
  }

  Future<MLDocumentSkewCorrectionResult> asyncDocumentSkewCorrect() async {
    return MLDocumentSkewCorrectionResult.fromJson(
      await _channel.invokeMethod(
        mAsyncDocumentSkewCorrect,
      ),
    );
  }

  Future<bool> stop() async {
    return await _channel.invokeMethod(
      mStop,
    );
  }
}
