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

class DefaultViewRequest {
  int scanType;
  List<int> additionalScanTypes;

  DefaultViewRequest({@required this.scanType, this.additionalScanTypes});

  factory DefaultViewRequest.fromJson(String str) =>
      DefaultViewRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DefaultViewRequest.fromMap(Map<String, dynamic> json) =>
      DefaultViewRequest(
          scanType: json["scanType"] == null ? null : json["scanType"],
          additionalScanTypes: json["additionalScanTypes"] == null
              ? null
              : List<int>.from(json["additionalScanTypes"].map((x) => x)));

  Map<dynamic, dynamic> toMap() =>
      {"scanType": scanType, "additionalScanTypes": additionalScanTypes};

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final DefaultViewRequest check = o;
    return o is DefaultViewRequest &&
        check.scanType == scanType &&
        check.additionalScanTypes == additionalScanTypes;
  }

  @override
  int get hashCode => hashValues(
        scanType,
        additionalScanTypes,
      );
}
