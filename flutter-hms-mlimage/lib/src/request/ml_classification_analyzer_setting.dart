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

class MLClassificationAnalyzerSetting {
  final String path;
  final double? minAcceptablePossibility;
  final bool? fingerprintVerification;
  final bool? isRemote;
  final int? largestNumberOfReturns;

  const MLClassificationAnalyzerSetting._({
    required this.path,
    this.isRemote,
    this.fingerprintVerification,
    this.largestNumberOfReturns,
    this.minAcceptablePossibility,
  });

  factory MLClassificationAnalyzerSetting.create({
    required String path,
    double? minAcceptablePossibility,
    bool? fingerprintVerification,
    bool? isRemote,
    int? largestNumberOfReturns,
  }) {
    return MLClassificationAnalyzerSetting._(
      path: path,
      minAcceptablePossibility: minAcceptablePossibility,
      fingerprintVerification: fingerprintVerification,
      isRemote: isRemote,
      largestNumberOfReturns: largestNumberOfReturns,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'fingerprintVerification': fingerprintVerification ?? false,
      'isRemote': isRemote ?? true,
      'minAcceptablePossibility': minAcceptablePossibility ?? 0.5,
      'largestNumberOfReturns': largestNumberOfReturns ?? 10,
    };
  }
}
