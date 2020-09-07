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

import 'package:huawei_ml/helpers/card_helpers.dart';

class MlGeneralCardSettings {
  String path;
  String language;
  String tipText;
  int orientation;
  int scanBoxCornerColor;
  int tipTextColor;
  int backButtonResId;
  int photoButtonResId;

  MlGeneralCardSettings() {
    path = null;
    language = "zh";
    orientation = CardOrientation.ORIENTATION_AUTO;
    scanBoxCornerColor = 0xFF00FF00;
    tipText = "Recognizing..";
    tipTextColor = 0xFF00FF00;
    backButtonResId = 2131165292;
    photoButtonResId = 2131165293;
  }

  Map<String, dynamic> toMap() {
    return {
      "settings": {
        "path": json.encode(path),
        "captureConfig": {"language": language},
        "captureUiConfig": {
          "orientation": orientation,
          "scanBoxCornerColor": scanBoxCornerColor,
          "tipText": tipText,
          "tipTextColor": tipTextColor,
          "backButtonResId": backButtonResId,
          "photoButtonResId": photoButtonResId,
        }
      }
    };
  }
}
