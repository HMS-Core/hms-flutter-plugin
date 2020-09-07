/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'dart:convert';

import 'package:huawei_ml/helpers/text_helpers.dart';

class MlTextSettings {
  int ocrMode;
  String language;
  String path;
  List<String> languageList;
  String borderType;
  int textDensityScene;

  MlTextSettings() {
    path = null;
    ocrMode = MlTextOcrMode.OCR_DETECT_MODE;
    language = MlTextLanguage.English;
    languageList = null;
    borderType = MlTextBorderType.ARC;
    textDensityScene = MlTextDensityScene.OCR_COMPACT_SCENE;
  }

  Map<String, dynamic> toMap() {
    return {
      "settings": {
        "path": json.encode(path),
        "ocrMode": ocrMode,
        "language": language,
        "languageList": languageList,
        "borderType": borderType,
        "textDensityScene": textDensityScene
      }
    };
  }
}
