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

import 'ml_point.dart';

class MLDocumentSkewDetectResult {
  MLImagePoint? leftTop;
  MLImagePoint? leftBottom;
  MLImagePoint? rightTop;
  MLImagePoint? rightBottom;
  int? resultCode;

  MLDocumentSkewDetectResult({
    this.leftBottom,
    this.leftTop,
    this.resultCode,
    this.rightBottom,
    this.rightTop,
  });

  factory MLDocumentSkewDetectResult.fromJson(Map<String, dynamic> json) {
    return MLDocumentSkewDetectResult(
      leftTop: json['leftTop'] != null
          ? MLImagePoint(
              x: json['leftTop']['x'],
              y: json['leftTop']['y'],
            )
          : null,
      leftBottom: json['leftBottom'] != null
          ? MLImagePoint(
              x: json['leftBottom']['x'],
              y: json['leftBottom']['y'],
            )
          : null,
      rightTop: json['rightTop'] != null
          ? MLImagePoint(
              x: json['rightTop']['x'],
              y: json['rightTop']['y'],
            )
          : null,
      rightBottom: json['rightBottom'] != null
          ? MLImagePoint(
              x: json['rightBottom']['x'],
              y: json['rightBottom']['y'],
            )
          : null,
      resultCode: json['resultCode'] ?? null,
    );
  }
}
