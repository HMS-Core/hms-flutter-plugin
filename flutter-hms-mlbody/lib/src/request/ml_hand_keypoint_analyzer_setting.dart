/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_ml_body.dart';

class MLHandKeyPointAnalyzerSetting {
  /// Maximum number of returned hand regions.
  static const int maxHandsNum = 10;

  /// Recognition result return mode. TYPE_ALL indicates that all results are returned.
  static const int typeAll = 0;

  /// Recognition result return mode. TYPE_KEYPOINT_ONLY indicates that only hand keypoint information is returned.
  static const int typeKeyPointOnly = 1;

  /// Recognition result return mode. TYPE_RECT_ONLY indicates that only palm information is returned.
  static const int typeRectOnly = 2;

  String path;
  int? sceneType;
  int? maxHandResults;

  MLHandKeyPointAnalyzerSetting({
    required this.path,
    this.maxHandResults,
    this.sceneType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'sceneType': sceneType ?? typeAll,
      'maxHandResults': maxHandResults ?? maxHandsNum,
    };
  }
}
