/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

class MLLandmarkAnalyzerSetting {
  static const int STEADY_PATTERN = 1;

  static const int NEWEST_PATTERN = 2;

  String path;
  int? patternType;
  int? largestNumberOfReturns;

  factory MLLandmarkAnalyzerSetting.create(
      {required String path, int? patternType, int? largestNumberOfReturns}) {
    return MLLandmarkAnalyzerSetting._(
        path: path,
        largestNumberOfReturns: largestNumberOfReturns,
        patternType: patternType);
  }

  MLLandmarkAnalyzerSetting._(
      {required this.path, this.largestNumberOfReturns, this.patternType});

  Map<String, dynamic> toMap() {
    return {
      "path": path,
      "largestNumberOfReturns": largestNumberOfReturns ?? 10,
      "patternType": patternType ?? STEADY_PATTERN
    };
  }
}
