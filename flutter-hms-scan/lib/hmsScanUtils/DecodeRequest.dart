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

import 'dart:typed_data' show Uint8List;
import 'package:flutter/foundation.dart' show required;
import 'dart:ui' show hashValues;

class DecodeRequest {
  Uint8List data;
  String dataString;
  int scanType;
  List<int> additionalScanTypes;

  DecodeRequest(
      {@required this.data, @required this.scanType, this.additionalScanTypes});

  DecodeRequest.fromJson(Map<dynamic, dynamic> json) {
    data = json["data"];
    scanType = json["scanType"];
    additionalScanTypes = json["additionalScanTypes"];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<String, dynamic>();
    data["data"] = this.data;
    data["scanType"] = this.scanType;
    data["additionalScanTypes"] = this.additionalScanTypes;
    return data;
  }

  Map<dynamic, dynamic> toMap() {
    dataString = data.toString();
    return {
      "data": dataString,
      "scanType": scanType,
      "additionalScanTypes": additionalScanTypes
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final DecodeRequest check = o;
    return o is DecodeRequest &&
        check.data == data &&
        check.dataString == dataString &&
        check.scanType == scanType &&
        check.additionalScanTypes == additionalScanTypes;
  }

  @override
  int get hashCode => hashValues(
        data,
        dataString,
        scanType,
        additionalScanTypes,
      );
}
