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
  static const int REGION_DR_AFILA = 1003;

  /// Unknown
  static const int REGION_DR_UNKNOWN = 1001;

  final String path;
  final String? productSetId;
  final int? largestNumberOfReturns;
  final int? region;

  const MLProductVisionSearchAnalyzerSetting._({
    required this.path,
    this.largestNumberOfReturns,
    this.productSetId,
    this.region,
  });

  factory MLProductVisionSearchAnalyzerSetting.local({
    required String path,
    String? productSetId,
    int? largestNumberOfReturns,
    int? region,
  }) {
    return MLProductVisionSearchAnalyzerSetting._(
      path: path,
      productSetId: productSetId,
      largestNumberOfReturns: largestNumberOfReturns,
      region: region,
    );
  }

  factory MLProductVisionSearchAnalyzerSetting.plugin({
    String? productSetId,
    int? largestNumberOfReturns,
    int? region,
  }) {
    return MLProductVisionSearchAnalyzerSetting._(
      path: '',
      productSetId: productSetId,
      largestNumberOfReturns: largestNumberOfReturns,
      region: region,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'productSetId': productSetId ?? 'vmall',
      'largestNumberOfReturns': largestNumberOfReturns ?? 20,
      'region': region ?? REGION_DR_CHINA,
    };
  }
}
