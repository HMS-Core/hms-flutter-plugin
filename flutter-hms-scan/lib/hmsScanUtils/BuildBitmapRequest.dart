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
import 'dart:typed_data';
import 'package:flutter/material.dart' show Color, Colors, required;
import 'dart:ui' show hashValues;
import 'package:huawei_scan/utils/HmsScanTypes.dart';

class BuildBitmapRequest {
  String content;
  int type;
  int width;
  int height;
  int margin;
  Color bitmapColor;
  Color backgroundColor;
  Uint8List qrLogo;

  BuildBitmapRequest({
    @required this.content,
    this.type = HmsScanTypes.QRCode,
    this.width = 700,
    this.height = 700,
    this.margin = 1,
    this.bitmapColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.qrLogo,
  });

  factory BuildBitmapRequest.fromJson(String str) =>
      BuildBitmapRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BuildBitmapRequest.fromMap(Map<String, dynamic> json) =>
      BuildBitmapRequest(
        content: json["content"] == null ? null : json["content"],
        type: json["type"] == null ? null : json["type"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        margin: json["margin"] == null ? null : json["margin"],
        bitmapColor:
            json["bitmapColor"] == null ? null : Color(json["bitmapColor"]),
        backgroundColor:
            json["backgroundColor"] == null ? null : Color(json["bitmapColor"]),
        qrLogo: json["qrLogo"],
      );

  Map<String, dynamic> toMap() => {
        'content': content,
        'type': type,
        'width': width,
        'height': height,
        'bitmapColor': bitmapColor.value,
        'margin': margin,
        'backgroundColor': backgroundColor.value,
        'qrLogo': qrLogo?.toString(),
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final BuildBitmapRequest check = o;
    return o is BuildBitmapRequest &&
        check.content == content &&
        check.type == type &&
        check.width == width &&
        check.height == height &&
        check.bitmapColor == bitmapColor &&
        check.margin == margin &&
        check.backgroundColor == backgroundColor &&
        check.qrLogo == qrLogo;
  }

  @override
  int get hashCode => hashValues(
        content,
        type,
        width,
        height,
        bitmapColor,
        margin,
        backgroundColor,
        qrLogo,
      );
}
