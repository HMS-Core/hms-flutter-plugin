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

class MLLandmarkAnalyzerSetting {
  static const int STEADY_PATTERN = 1;
  static const int NEWEST_PATTERN = 2;

  final String path;
  final int? patternType;
  final int? largestNumberOfReturns;

  const MLLandmarkAnalyzerSetting._({
    required this.path,
    this.largestNumberOfReturns,
    this.patternType,
  });

  factory MLLandmarkAnalyzerSetting.create({
    required String path,
    int? patternType,
    int? largestNumberOfReturns,
  }) {
    return MLLandmarkAnalyzerSetting._(
      path: path,
      largestNumberOfReturns: largestNumberOfReturns,
      patternType: patternType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'largestNumberOfReturns': largestNumberOfReturns ?? 10,
      'patternType': patternType ?? STEADY_PATTERN,
    };
  }
}
