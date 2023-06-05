/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_scan;

typedef CustomizedCameraListener = Function(ScanResponse response);
typedef CustomizedLifeCycleListener = Function(
  CustomizedViewEvent lifecycleStatus,
);

class CustomizedViewRequest {
  int? scanType;
  List<int>? additionalScanTypes;

  int? rectHeight;
  int? rectWidth;

  bool? flashOnLightChange;
  bool? isFlashAvailable;
  bool? isGalleryAvailable;
  bool? continuouslyScan;
  bool? enableReturnBitmap;

  CustomizedCameraListener? customizedCameraListener;
  CustomizedLifeCycleListener? customizedLifeCycleListener;

  CustomizedViewRequest({
    this.scanType,
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

  factory CustomizedViewRequest.fromJson(String str) {
    return CustomizedViewRequest.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory CustomizedViewRequest.fromMap(Map<String, dynamic> json) {
    return CustomizedViewRequest(
      scanType: json['scanType'],
      additionalScanTypes: json['additionalScanTypes'] == null
          ? null
          : List<int>.from(
              json['additionalScanTypes'].map((dynamic x) => x),
            ),
      rectHeight: json['rectHeight'],
      rectWidth: json['rectWidth'],
      flashOnLightChange: json['flashOnLightChange'],
      isFlashAvailable: json['isFlashAvailable'],
      isGalleryAvailable: json['isGalleryAvailable'],
      continuouslyScan: json['continuouslyScan'],
      enableReturnBitmap: json['enableReturnBitmap'],
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <dynamic, dynamic>{
      'scanType': scanType,
      'additionalScanTypes': additionalScanTypes,
      'rectHeight': rectHeight,
      'rectWidth': rectWidth,
      'flashOnLightChange': flashOnLightChange,
      'isFlashAvailable': isFlashAvailable,
      'isGalleryAvailable': isGalleryAvailable,
      'continuouslyScan': continuouslyScan,
      'enableReturnBitmap': enableReturnBitmap,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is CustomizedViewRequest &&
        other.scanType == scanType &&
        listEquals(other.additionalScanTypes, additionalScanTypes) &&
        other.rectHeight == rectHeight &&
        other.rectWidth == rectWidth &&
        other.flashOnLightChange == flashOnLightChange &&
        other.isFlashAvailable == isFlashAvailable &&
        other.isGalleryAvailable == isGalleryAvailable &&
        other.continuouslyScan == continuouslyScan &&
        other.enableReturnBitmap == enableReturnBitmap;
  }

  @override
  int get hashCode {
    return Object.hash(
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
}

enum CustomizedViewEvent { onStart, onResume, onPause, onDestroy, onStop }
