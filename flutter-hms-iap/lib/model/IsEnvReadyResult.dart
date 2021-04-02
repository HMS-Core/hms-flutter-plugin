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

import 'Status.dart';

class IsEnvReadyResult {
  String returnCode;
  Status status;

  IsEnvReadyResult({
    this.returnCode,
    this.status,
  });

  factory IsEnvReadyResult.fromJson(String str) =>
      IsEnvReadyResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IsEnvReadyResult.fromMap(Map<String, dynamic> json) =>
      IsEnvReadyResult(
        returnCode:
            json["returnCode"] == null ? null : json["returnCode"].toString(),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() {
    return {
      "returnCode": returnCode,
      "status": status == null ? null : status.toMap(),
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final IsEnvReadyResult check = o;
    return o is IsEnvReadyResult &&
        check.returnCode == returnCode &&
        check.status == status;
  }

  @override
  int get hashCode => returnCode.hashCode ^ status.hashCode;
}
