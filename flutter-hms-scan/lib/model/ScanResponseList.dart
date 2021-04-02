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
import 'package:huawei_scan/model/ScanResponse.dart';

class ScanResponseList {
  final List<ScanResponse> scanResponseList;

  ScanResponseList({
    this.scanResponseList,
  });

  factory ScanResponseList.fromJson(String str) =>
      ScanResponseList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScanResponseList.fromMap(List<dynamic> parsedJson) {
    List<ScanResponse> scanResponseInnerList = new List<ScanResponse>();
    scanResponseInnerList =
        parsedJson.map((i) => ScanResponse.fromMap(i)).toList();

    return new ScanResponseList(scanResponseList: scanResponseInnerList);
  }

  Map<String, dynamic> toMap() => {
        "scanResponseList": scanResponseList == null
            ? null
            : List<dynamic>.from(scanResponseList.map((x) => x.toMap())),
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final ScanResponseList check = o;
    return o is ScanResponseList && check.scanResponseList == scanResponseList;
  }

  @override
  int get hashCode => scanResponseList.hashCode;
}
