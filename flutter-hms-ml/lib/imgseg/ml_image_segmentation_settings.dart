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

import 'package:huawei_ml/helpers/img_seg_helpers.dart';

class MlImageSegmentationSettings {
  String path;
  int analyzerType;
  int scene;
  bool exactMode;

  MlImageSegmentationSettings() {
    path = null;
    analyzerType = ImgSegmentationAnalyzerType.IMAGE_SEG;
    scene = ImgSegmentationScene.ALL;
    exactMode = true;
  }

  Map<String, dynamic> toMap() {
    return {
      "settings": {
        "path": json.encode(path),
        "scene": scene,
        "analyzerType": analyzerType,
        "exactMode": exactMode
      }
    };
  }
}
