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

import 'dart:convert' show json;

import 'package:flutter/material.dart';

class ScanTextOptions {
  //Text options
  Color textColor;
  double textSize;

  //if true originalValue of the scan will be displayed on rectangle.
  bool showText;

  //if false text will remain in rectangle bounds.
  bool showTextOutBounds;

  //For text background
  Color textBackgroundColor;

  //if true text will auto size itself
  bool autoSizeText;

  //Auto size text options
  int minTextSize;
  int granularity;

  ScanTextOptions({
    this.textColor = Colors.black,
    this.textSize = 35.0,
    this.showText = true,
    this.showTextOutBounds = false,
    this.textBackgroundColor = Colors.transparent,
    this.autoSizeText = false,
    this.minTextSize = 24,
    this.granularity = 2,
  });

  factory ScanTextOptions.fromJson(String str) =>
      ScanTextOptions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScanTextOptions.fromMap(Map<String, dynamic> json) => ScanTextOptions(
        textColor: json["textColor"] == null ? null : Color(json["textColor"]),
        textSize: json["textSize"] == null ? null : json["textSize"],
        showText: json["showText"] == null ? null : json["showText"],
        showTextOutBounds: json["showTextOutBounds"] == null
            ? null
            : json["showTextOutBounds"],
        textBackgroundColor: json["textBackgroundColor"] == null
            ? null
            : Color(json["textBackgroundColor"]),
        autoSizeText:
            json["autoSizeText"] == null ? null : json["autoSizeText"],
        minTextSize: json["minTextSize"] == null ? null : json["minTextSize"],
        granularity: json["granularity"] == null ? null : json["granularity"],
      );

  Map<dynamic, dynamic> toMap() => {
        "textColor": textColor.value,
        "textSize": textSize,
        "showText": showText,
        "showTextOutBounds": showTextOutBounds,
        "textBackgroundColor": textBackgroundColor.value,
        "autoSizeText": autoSizeText,
        "minTextSize": minTextSize,
        "granularity": granularity,
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final ScanTextOptions check = o;
    return o is ScanTextOptions &&
        check.textColor == textColor &&
        check.textSize == textSize &&
        check.showText == showText &&
        check.showTextOutBounds == showTextOutBounds &&
        check.textBackgroundColor == textBackgroundColor &&
        check.autoSizeText == autoSizeText &&
        check.minTextSize == minTextSize &&
        check.granularity == granularity;
  }

  @override
  int get hashCode => hashValues(
        textColor,
        textSize,
        showText,
        showTextOutBounds,
        textBackgroundColor,
        autoSizeText,
        minTextSize,
        granularity,
      );
}
