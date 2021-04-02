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

class MLTextAnalyzerSetting {
  /// Independent detection mode.
  /// Each supplied image is detected independently.
  /// This mode applies to single image detection.
  static const int OCR_DETECT_MODE = 1;

  /// Tracking mode.
  /// The detection result of the preceding frame is used as the basis to quickly detect the text position in the image.
  /// This mode applies to video stream text detection.
  static const int OCR_TRACKING_MODE = 2;

  /// Text bounding box that is a polygon.
  static const String ARC = "ARC";

  /// Text bounding box that is a quadrilateral.
  static const String NGON = "NGON";

  /// Dense text type, such as user instructions.
  static const int OCR_COMPACT_SCENE = 2;

  /// Sparse text type, such as business cards.
  static const int OCR_LOOSE_SCENE = 1;

  int ocrMode;
  String language;
  String path;
  MLFrameType frameType;
  MLFrameProperty property;
  List<String> languageList;
  String borderType;
  int textDensityScene;
  bool isRemote;

  MLTextAnalyzerSetting() {
    path = null;
    property = null;
    frameType = MLFrameType.fromBitmap;
    ocrMode = OCR_DETECT_MODE;
    language = "zh";
    languageList = null;
    borderType = ARC;
    textDensityScene = OCR_COMPACT_SCENE;
    isRemote = true;
  }

  int get getOcrMode => ocrMode;

  int get getTextDensityScene => textDensityScene;

  String get getLanguage => language;

  String get getBorderType => borderType;

  List<String> get getLanguageList => languageList;

  Map<String, dynamic> toMap() {
    return {
      "path": path,
      "property": property != null ? property.toJson() : null,
      "frameType": describeEnum(frameType),
      "ocrMode": ocrMode,
      "language": language,
      "languageList": languageList,
      "borderType": borderType,
      "textDensityScene": textDensityScene,
      "isRemote": isRemote
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MLTextAnalyzerSetting &&
        o.path == path &&
        o.frameType == frameType &&
        o.ocrMode == ocrMode &&
        o.language == language &&
        o.languageList == languageList &&
        o.borderType == borderType &&
        o.textDensityScene == textDensityScene &&
        o.isRemote == isRemote;
  }

  @override
  int get hashCode {
    return hashList([
      path,
      frameType,
      ocrMode,
      language,
      languageList,
      borderType,
      textDensityScene,
      isRemote
    ]);
  }

  @override
  String toString() =>
      'MlFaceSettings(path: $path, "frameType": $frameType, ocrMode: $ocrMode, language: $language, languageList: $languageList, borderType: $borderType, textDensityScene: $textDensityScene, isRemote: $isRemote)';
}
