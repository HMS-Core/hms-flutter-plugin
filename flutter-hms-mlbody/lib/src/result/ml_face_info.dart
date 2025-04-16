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

class MLFaceInfo {
  final BodyBorder? faceRect;

  const MLFaceInfo._({
    this.faceRect,
  });

  factory MLFaceInfo.fromMap(Map<dynamic, dynamic> map) {
    return MLFaceInfo._(
      faceRect:
          map['faceRect'] != null ? BodyBorder.fromMap(map['faceRect']) : null,
    );
  }
}

class MLFaceTemplateResult {
  final int? templateId;
  final MLFaceInfo? faceInfo;

  const MLFaceTemplateResult._({
    this.faceInfo,
    this.templateId,
  });

  factory MLFaceTemplateResult.fromMap(Map<dynamic, dynamic> map) {
    return MLFaceTemplateResult._(
      templateId: map['templateId'],
      faceInfo:
          map['faceInfo'] != null ? MLFaceInfo.fromMap(map['faceInfo']) : null,
    );
  }
}

class MLFaceVerificationResult {
  final MLFaceInfo? faceInfo;
  final dynamic similarity;
  final int? templateId;

  const MLFaceVerificationResult._({
    this.templateId,
    this.faceInfo,
    this.similarity,
  });

  factory MLFaceVerificationResult.fromMap(Map<dynamic, dynamic> map) {
    return MLFaceVerificationResult._(
      faceInfo:
          map['faceInfo'] != null ? MLFaceInfo.fromMap(map['faceInfo']) : null,
      similarity: map['similarity'],
      templateId: map['templateId'],
    );
  }
}
