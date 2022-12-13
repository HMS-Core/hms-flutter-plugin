/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

class DefaultViewRequest {
  int? scanType;
  List<int>? additionalScanTypes;

  DefaultViewRequest({
    this.scanType,
    this.additionalScanTypes,
  });

  factory DefaultViewRequest.fromJson(String str) {
    return DefaultViewRequest.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory DefaultViewRequest.fromMap(Map<String, dynamic> json) {
    return DefaultViewRequest(
      scanType: json['scanType'],
      additionalScanTypes: json['additionalScanTypes'] == null
          ? null
          : List<int>.from(
              json['additionalScanTypes'].map((dynamic x) => x),
            ),
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <dynamic, dynamic>{
      'scanType': scanType,
      'additionalScanTypes': additionalScanTypes,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is DefaultViewRequest &&
        other.scanType == scanType &&
        listEquals(other.additionalScanTypes, additionalScanTypes);
  }

  @override
  int get hashCode {
    return hashValues(
      scanType,
      additionalScanTypes,
    );
  }
}
