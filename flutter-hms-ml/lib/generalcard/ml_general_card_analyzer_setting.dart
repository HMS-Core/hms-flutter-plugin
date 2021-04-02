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

import 'package:flutter/material.dart';

class MLGeneralCardAnalyzerSetting {
  String path;
  String language;
  int backButtonResId;
  int photoButtonResId;
  Color scanBoxCornerColor;
  Color tipTextColor;
  String tipText;
  int torchOnResId;
  int torchOffResId;

  MLGeneralCardAnalyzerSetting() {
    path = null;
    language = "zh";
    scanBoxCornerColor = Colors.green;
    tipText = "Recognizing..";
    tipTextColor = Colors.white;
    backButtonResId = 2131165292;
    photoButtonResId = 2131165293;
    torchOnResId = 2131165294;
    torchOffResId = 2131165295;
  }

  Map<String, dynamic> toMap() {
    return {
      "path": path,
      "language": language,
      "scanBoxCornerColor": '#${scanBoxCornerColor.value.toRadixString(16)}',
      "tipText": tipText,
      "tipTextColor": '#${tipTextColor.value.toRadixString(16)}',
      "backButtonResId": backButtonResId,
      "photoButtonResId": photoButtonResId,
      "torchOnResId": torchOnResId,
      "torchOffResId": torchOffResId
    };
  }

  String get getLanguage => language;

  String get getTipText => tipText;

  Color get getScanBoxCornerColor => scanBoxCornerColor;

  Color get getTipTextColor => tipTextColor;

  int get getBackButtonResId => backButtonResId;

  int get getPhotoButtonResId => photoButtonResId;

  int get getTorchOnResId => torchOnResId;

  int get getTorchOffResId => torchOffResId;
}
