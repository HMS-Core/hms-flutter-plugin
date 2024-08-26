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

class ML3DFaceAnalyzerSetting {
  /// Precision preference mode.
  /// This mode will detect more faces and be more precise in detecting key points and contours, but will run slower.
  static const int typePrecision = 1;

  /// Speed preference mode.
  /// Compared with the precision preference mode,
  /// this mode will detect fewer faces and be less precise in detecting key points and contours, but will run faster.
  static const int typeSpeed = 2;

  String path;
  int? performanceType;
  bool? tracingAllowed;

  ML3DFaceAnalyzerSetting({
    required this.path,
    this.performanceType,
    this.tracingAllowed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'performanceType': performanceType ?? typePrecision,
      'tracingAllowed': tracingAllowed ?? false,
    };
  }
}
