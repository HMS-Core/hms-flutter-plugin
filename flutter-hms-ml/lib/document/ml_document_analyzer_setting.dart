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
import 'package:huawei_ml/models/ml_frame_property.dart';
import 'package:huawei_ml/utils/ml_utils.dart';

class MLDocumentAnalyzerSetting {
  String path;
  MLFrameType frameType;
  MLFrameProperty property;
  String borderType;
  List<String> languageList;
  bool enableFingerPrintVerification;

  MLDocumentAnalyzerSetting() {
    path = null;
    property = null;
    frameType = MLFrameType.fromBitmap;
    borderType = "ARC";
    languageList = null;
    enableFingerPrintVerification = true;
  }

  String get getBorderType => borderType;

  List<String> get getLanguageList => languageList;

  bool get isFingerPrintVerificationEnabled => enableFingerPrintVerification;

  Map<String, dynamic> toMap() {
    return {
      "path": path,
      "property": property != null ? property.toJson() : null,
      "frameType": describeEnum(frameType),
      "borderType": borderType,
      "languageList": languageList,
      "fingerPrint": enableFingerPrintVerification
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MLDocumentAnalyzerSetting &&
        o.path == path &&
        o.frameType == frameType &&
        o.languageList == languageList &&
        o.borderType == borderType &&
        o.enableFingerPrintVerification == enableFingerPrintVerification;
  }

  @override
  int get hashCode {
    return hashList([
      path,
      frameType,
      languageList,
      borderType,
      enableFingerPrintVerification
    ]);
  }

  @override
  String toString() =>
      'MlFaceSettings(path: $path, frameType: $frameType, languageList: $languageList, borderType: $borderType, enableFingerPrintVerification: $enableFingerPrintVerification)';
}
