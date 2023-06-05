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

class ScanResponseList {
  final List<ScanResponse?>? scanResponseList;

  ScanResponseList({
    this.scanResponseList,
  });

  factory ScanResponseList.fromJson(String str) {
    return ScanResponseList.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory ScanResponseList.fromMap(List<dynamic> parsedJson) {
    List<ScanResponse?> scanResponseInnerList = <ScanResponse>[];
    scanResponseInnerList = parsedJson
        .map((dynamic i) => i == null ? null : ScanResponse.fromMap(i))
        .toList();

    return ScanResponseList(scanResponseList: scanResponseInnerList);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'scanResponseList': scanResponseList == null
          ? null
          : List<dynamic>.from(
              scanResponseList!.map(
                (ScanResponse? x) => x?.toMap(),
              ),
            ),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is ScanResponseList &&
        listEquals(other.scanResponseList, scanResponseList);
  }

  @override
  int get hashCode {
    return scanResponseList.hashCode;
  }
}
