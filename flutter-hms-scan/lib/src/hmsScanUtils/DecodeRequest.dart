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

class DecodeRequest {
  Uint8List? data;
  String? dataString;
  int? scanType;
  List<int>? additionalScanTypes;
  bool? photoMode;
  bool? parseResult;
  bool? multiMode;

  DecodeRequest(
      {this.data,
      this.scanType,
      this.additionalScanTypes,
      this.photoMode,
      this.parseResult,
      this.multiMode});

  DecodeRequest.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'];
    scanType = json['scanType'];
    additionalScanTypes = json['additionalScanTypes'];
    photoMode = json['photoMode'];
    parseResult = json['parseResult'];
    multiMode = json['multiMode'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['scanType'] = scanType;
    data['additionalScanTypes'] = additionalScanTypes;
    data['photoMode'] = photoMode;
    data['parseResult'] = parseResult;
    data['multiMode'] = multiMode;
    return data;
  }

  Map<dynamic, dynamic> toMap() {
    dataString = data.toString();
    return <dynamic, dynamic>{
      'data': dataString,
      'scanType': scanType,
      'additionalScanTypes': additionalScanTypes,
      'photoMode': photoMode,
      'parseResult': parseResult,
      'multiMode': multiMode
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is DecodeRequest &&
        other.data == data &&
        other.dataString == dataString &&
        other.scanType == scanType &&
        listEquals(other.additionalScanTypes, additionalScanTypes) &&
        other.photoMode == photoMode &&
        other.parseResult == parseResult &&
        other.multiMode == multiMode;
  }

  @override
  int get hashCode {
    return Object.hash(
      data,
      dataString,
      scanType,
      additionalScanTypes,
      multiMode,
    );
  }
}
