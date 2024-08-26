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

class MLSkeletonAnalyzerSetting {
  /// Detection mode 0: Detect skeleton points for normal postures.
  static const int typeNormal = 0;

  /// Detection mode 1: Detect skeleton points for yoga postures.
  static const int typeYoga = 1;

  String path;
  int? analyzerType;

  MLSkeletonAnalyzerSetting({
    required this.path,
    this.analyzerType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'analyzerType': analyzerType ?? typeNormal,
    };
  }
}
