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
import 'package:huawei_ml/utils/ml_utils.dart';

class LensViewController {
  static const int BACK_LENS = 0;
  static const int FRONT_LENS = 1;
  static const String FLASH_MODE_OFF = "off";
  static const String FLASH_MODE_AUTO = "auto";
  static const String FLASH_MODE_ON = "on";
  static const String FOCUS_MODE_CONTINUOUS_VIDEO = "continuous-video";
  static const String FOCUS_MODE_CONTINUOUS_PICTURE = "continuous-picture";

  int _textureId;
  int lensType;
  LensEngineAnalyzerOptions analyzerType;
  double applyFps;
  int dimensionWidth;
  int dimensionHeight;
  String flashMode;
  String focusMode;
  bool automaticFocus;
  List<String> analyzerList;
  int maxFrameLostCount;

  LensViewController(
      {this.lensType = BACK_LENS,
      this.applyFps = 30.0,
      this.automaticFocus = true,
      this.dimensionHeight = 1080,
      this.dimensionWidth = 1440,
      this.analyzerType,
      this.analyzerList,
      this.maxFrameLostCount = 2,
      this.flashMode = FLASH_MODE_AUTO,
      this.focusMode = FOCUS_MODE_CONTINUOUS_VIDEO});

  Map<String, dynamic> toMap() {
    return {
      "lensType": lensType,
      "analyzerType": describeEnum(analyzerType),
      "applyFps": applyFps,
      "automaticFocus": automaticFocus,
      "dimensionHeight": dimensionHeight,
      "dimensionWidth": dimensionWidth,
      "flashMode": flashMode,
      "focusMode": focusMode,
      "analyzerList": analyzerList,
      "maxFrameLostCount": maxFrameLostCount
    };
  }

  bool get isInitialized => _textureId != null;

  int get textureId => _textureId;

  void setTextureId(int id) {
    _textureId = id;
  }
}
