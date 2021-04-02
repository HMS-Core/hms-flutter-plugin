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

import 'ml_point.dart';

class MLDocumentSkewDetectResult {
  MLPoint leftTop;
  MLPoint leftBottom;
  MLPoint rightTop;
  MLPoint rightBottom;
  int resultCode;

  MLDocumentSkewDetectResult(
      {this.leftBottom,
      this.leftTop,
      this.resultCode,
      this.rightBottom,
      this.rightTop});

  MLDocumentSkewDetectResult.fromJson(Map<String, dynamic> json) {
    leftTop =
        json['leftTop'] != null ? MLPoint.fromJson(json['leftTop']) : null;
    leftBottom = json['leftBottom'] != null
        ? MLPoint.fromJson(json['leftBottom'])
        : null;
    rightTop =
        json['rightTop'] != null ? MLPoint.fromJson(json['rightTop']) : null;
    rightBottom = json['rightBottom'] != null
        ? MLPoint.fromJson(json['rightBottom'])
        : null;
    resultCode = json['resultCode'] ?? null;
  }
}

class MLDocumentSkewCorrectionResult {
  String imagePath;
  int resultCode;

  MLDocumentSkewCorrectionResult({this.imagePath, this.resultCode});

  MLDocumentSkewCorrectionResult.fromJson(Map<String, dynamic> json) {
    imagePath = json['imagePath'] ?? null;
    resultCode = json['resultCode'] ?? null;
  }
}
