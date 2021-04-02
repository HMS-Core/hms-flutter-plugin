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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:huawei_ml/utils/ml_utils.dart';

class MLProductVisionSearchAnalyzerSetting {
  /// Singapore
  static const int REGION_DR_SINGAPORE = 1007;

  /// China
  static const int REGION_DR_CHINA = 1002;

  /// Germany
  static const int REGION_DR_GERMAN = 1006;

  /// Russia
  static const int REGION_DR_RUSSIA = 1005;

  /// Europe
  static const int REGION_DR_EUROPE = 1004;

  ///
  static const int REGION_DR_AFILA = 1003;

  /// Unknown
  static const int REGION_DR_UNKNOWN = 1001;

  String path;
  String productSetId;
  MLFrameType frameType;
  int largestNumberOfReturns;
  int region;

  MLProductVisionSearchAnalyzerSetting() {
    path = null;
    productSetId = "vmall";
    frameType = MLFrameType.fromBitmap;
    largestNumberOfReturns = 20;
    region = REGION_DR_CHINA;
  }

  String get getProductSetId => productSetId;

  int get getRegion => region;

  int get getLargestNumberOfReturns => largestNumberOfReturns;

  Map<String, dynamic> toMap() {
    return {
      "path": path,
      "productSetId": productSetId,
      "frameType": describeEnum(frameType),
      "largestNumberOfReturns": largestNumberOfReturns,
      "region": region
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MLProductVisionSearchAnalyzerSetting &&
        o.path == path &&
        o.productSetId == productSetId &&
        o.frameType == frameType &&
        o.largestNumberOfReturns == largestNumberOfReturns &&
        o.region == region;
  }

  @override
  int get hashCode {
    return hashList(
        [path, productSetId, frameType, largestNumberOfReturns, region]);
  }
}
