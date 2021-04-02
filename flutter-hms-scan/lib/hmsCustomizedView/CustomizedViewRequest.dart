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

import 'package:flutter/foundation.dart' show required;
import 'dart:ui' show hashValues;

import 'package:huawei_scan/model/ScanResponse.dart';

typedef CustomizedCameraListener(ScanResponse response);
typedef CustomizedLifeCycleListener(CustomizedViewEvent lifecycleStatus);

class CustomizedViewRequest {
  int scanType;
  List<int> additionalScanTypes;

  int rectHeight;
  int rectWidth;

  bool flashOnLightChange;
  bool isFlashAvailable;
  bool isGalleryAvailable;
  bool continuouslyScan;
  bool enableReturnBitmap;

  CustomizedCameraListener customizedCameraListener;
  CustomizedLifeCycleListener customizedLifeCycleListener;

  CustomizedViewRequest({
    @required this.scanType,
    this.additionalScanTypes,
    this.rectHeight = 240,
    this.rectWidth = 240,
    this.flashOnLightChange = false,
    this.isFlashAvailable = false,
    this.isGalleryAvailable = true,
    this.continuouslyScan = true,
    this.enableReturnBitmap = false,
    this.customizedCameraListener,
    this.customizedLifeCycleListener,
  });

  factory CustomizedViewRequest.fromJson(String str) =>
      CustomizedViewRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomizedViewRequest.fromMap(Map<String, dynamic> json) =>
      CustomizedViewRequest(
        scanType: json["scanType"] == null ? null : json["scanType"],
        additionalScanTypes: json["additionalScanTypes"] == null
            ? null
            : List<int>.from(json["additionalScanTypes"].map((x) => x)),
        rectHeight: json["rectHeight"] == null ? null : json["rectHeight"],
        rectWidth: json["rectWidth"] == null ? null : json["rectWidth"],
        flashOnLightChange: json["flashOnLightChange"] == null
            ? null
            : json["flashOnLightChange"],
        isFlashAvailable:
            json["isFlashAvailable"] == null ? null : json["isFlashAvailable"],
        isGalleryAvailable: json["isGalleryAvailable"] == null
            ? null
            : json["isGalleryAvailable"],
        continuouslyScan:
            json["continuouslyScan"] == null ? null : json["continuouslyScan"],
        enableReturnBitmap: json["enableReturnBitmap"],
      );

  Map<dynamic, dynamic> toMap() => {
        "scanType": scanType,
        "additionalScanTypes": additionalScanTypes,
        "rectHeight": rectHeight,
        "rectWidth": rectWidth,
        "flashOnLightChange": flashOnLightChange,
        "isFlashAvailable": isFlashAvailable,
        "isGalleryAvailable": isGalleryAvailable,
        "continuouslyScan": continuouslyScan,
        "enableReturnBitmap": enableReturnBitmap,
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final CustomizedViewRequest check = o;
    return o is CustomizedViewRequest &&
        check.scanType == scanType &&
        check.additionalScanTypes == additionalScanTypes &&
        check.rectHeight == rectHeight &&
        check.rectWidth == rectWidth &&
        check.flashOnLightChange == flashOnLightChange &&
        check.isFlashAvailable == isFlashAvailable &&
        check.isGalleryAvailable == isGalleryAvailable &&
        check.continuouslyScan == continuouslyScan &&
        check.enableReturnBitmap == enableReturnBitmap;
  }

  @override
  int get hashCode => hashValues(
        scanType,
        additionalScanTypes,
        rectHeight,
        rectWidth,
        flashOnLightChange,
        isFlashAvailable,
        isGalleryAvailable,
        continuouslyScan,
        enableReturnBitmap,
      );
}

enum CustomizedViewEvent { onStart, onResume, onPause, onDestroy, onStop }
