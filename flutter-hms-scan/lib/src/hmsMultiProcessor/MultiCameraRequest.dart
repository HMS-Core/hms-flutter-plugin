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

typedef MultiCameraListener = Function(ScanResponse response);

class MultiCameraRequest {
  int? scanMode;
  int? scanType;
  List<int>? additionalScanTypes;

  List<Color>? colorList;
  static const List<Color> defaultColorList = <Color>[Colors.yellow];

  double? strokeWidth;

  bool? isGalleryAvailable;

  ScanTextOptions? scanTextOptions;

  MultiCameraListener? multiCameraListener;

  MultiCameraRequest({
    this.scanType,
    this.scanMode,
    this.multiCameraListener,
    this.additionalScanTypes,
    this.colorList = defaultColorList,
    this.strokeWidth = 4.0,
    this.isGalleryAvailable = true,
    this.scanTextOptions,
  });

  factory MultiCameraRequest.fromJson(String str) {
    return MultiCameraRequest.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory MultiCameraRequest.fromMap(Map<String, dynamic> json) {
    return MultiCameraRequest(
      scanMode: json['scanMode'],
      scanType: json['scanType'],
      additionalScanTypes: json['additionalScanTypes'] == null
          ? null
          : List<int>.from(
              json['additionalScanTypes'].map((dynamic x) => x),
            ),
      colorList: json['colorList'] == null
          ? null
          : List<Color>.from(
              json['colorList'].map((dynamic x) => Color(x)),
            ),
      strokeWidth: json['strokeWidth'],
      isGalleryAvailable: json['isGalleryAvailable'],
      scanTextOptions: json['scanTextOptions'] == null
          ? null
          : ScanTextOptions.fromJson(json['scanTextOptions']),
    );
  }

  Map<dynamic, dynamic> toMap() {
    List<String> colorListIntValues = <String>[];
    for (int i = 0; i < (colorList?.length ?? 0); i++) {
      colorListIntValues.add(colorList![i].value.toString());
    }
    return <dynamic, dynamic>{
      'scanType': scanType,
      'scanMode': scanMode,
      'additionalScanTypes': additionalScanTypes,
      'colorList': colorListIntValues,
      'strokeWidth': strokeWidth,
      'isGalleryAvailable': isGalleryAvailable,
      'scanTextOptions':
          scanTextOptions == null ? null : scanTextOptions!.toJson()
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is MultiCameraRequest &&
        other.scanType == scanType &&
        other.scanMode == scanMode &&
        other.multiCameraListener == multiCameraListener &&
        listEquals(other.additionalScanTypes, additionalScanTypes) &&
        listEquals(other.colorList, colorList) &&
        other.scanTextOptions == scanTextOptions &&
        other.strokeWidth == strokeWidth &&
        other.isGalleryAvailable == isGalleryAvailable;
  }

  @override
  int get hashCode {
    return Object.hash(
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
}
