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
import 'package:flutter/material.dart' show Color, Colors;
import 'package:flutter/foundation.dart' show required;
import 'package:huawei_scan/hmsMultiProcessor/ScanTextOptions.dart';
import 'dart:ui' show hashValues;
import 'package:huawei_scan/model/ScanResponse.dart';

typedef MultiCameraListener(ScanResponse response);

class MultiCameraRequest {
  int scanMode;
  int scanType;
  List<int> additionalScanTypes;

  List<Color> colorList;
  List<String> colorListIntValues = [];
  static const List<Color> defaultColorList = [Colors.yellow];

  double strokeWidth;

  bool isGalleryAvailable;

  ScanTextOptions scanTextOptions;

  MultiCameraListener multiCameraListener;

  MultiCameraRequest({
    @required this.scanType,
    @required this.scanMode,
    this.multiCameraListener,
    this.additionalScanTypes,
    this.colorList = defaultColorList,
    this.strokeWidth = 4.0,
    this.isGalleryAvailable = true,
    this.scanTextOptions,
  });

  factory MultiCameraRequest.fromJson(String str) =>
      MultiCameraRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MultiCameraRequest.fromMap(Map<String, dynamic> json) =>
      MultiCameraRequest(
        scanMode: json["scanMode"] == null ? null : json["scanMode"],
        scanType: json["scanType"] == null ? null : json["scanType"],
        additionalScanTypes: json["additionalScanTypes"] == null
            ? null
            : List<int>.from(json["additionalScanTypes"].map((x) => x)),
        colorList: json["colorList"] == null
            ? null
            : List<Color>.from(json["colorList"].map((x) => Color(x))),
        strokeWidth: json["strokeWidth"] == null ? null : json["strokeWidth"],
        isGalleryAvailable: json["isGalleryAvailable"] == null
            ? null
            : json["isGalleryAvailable"],
        scanTextOptions: json["scanTextOptions"] == null
            ? null
            : ScanTextOptions.fromJson(json["scanTextOptions"]),
      );

  Map<dynamic, dynamic> toMap() {
    colorListIntValues = [];
    for (int i = 0; i < colorList.length; i++) {
      colorListIntValues.add(colorList[i].value.toString());
    }
    return {
      "scanType": scanType,
      "scanMode": scanMode,
      "additionalScanTypes": additionalScanTypes,
      "colorList": colorListIntValues,
      "strokeWidth": strokeWidth,
      "isGalleryAvailable": isGalleryAvailable,
      "scanTextOptions":
          scanTextOptions == null ? null : scanTextOptions.toJson()
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final MultiCameraRequest check = o;
    return o is MultiCameraRequest &&
        check.scanType == scanType &&
        check.scanMode == scanMode &&
        check.multiCameraListener == multiCameraListener &&
        check.additionalScanTypes == additionalScanTypes &&
        check.colorList == colorList &&
        check.scanTextOptions == scanTextOptions &&
        check.strokeWidth == strokeWidth &&
        check.isGalleryAvailable == isGalleryAvailable;
  }

  @override
  int get hashCode => hashValues(
        scanType,
        scanMode,
        multiCameraListener,
        additionalScanTypes,
        colorList,
        scanTextOptions,
        strokeWidth,
        isGalleryAvailable,
      );
}
