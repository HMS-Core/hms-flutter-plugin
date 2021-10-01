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

/// Information returned when the isSandboxActivated API is successfully called.
class IsSandboxActivatedResult {
  String? errMsg;
  bool? isSandboxApk;
  bool? isSandboxUser;
  String? returnCode;
  String? versionFrMarket;
  String? versionInApk;
  Status? status;

  IsSandboxActivatedResult({
    this.errMsg,
    this.isSandboxApk,
    this.isSandboxUser,
    this.returnCode,
    this.versionFrMarket,
    this.versionInApk,
    this.status,
  });

  factory IsSandboxActivatedResult.fromJson(String str) =>
      IsSandboxActivatedResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IsSandboxActivatedResult.fromMap(Map<dynamic, dynamic> json) =>
      IsSandboxActivatedResult(
        errMsg: json["errMsg"] == null ? null : json["errMsg"],
        isSandboxApk:
            json["isSandboxApk"] == null ? null : json["isSandboxApk"],
        isSandboxUser:
            json["isSandboxUser"] == null ? null : json["isSandboxUser"],
        returnCode:
            json["returnCode"] == null ? null : json["returnCode"].toString(),
        versionFrMarket:
            json["versionFrMarket"] == null ? null : json["versionFrMarket"],
        versionInApk:
            json["versionInApk"] == null ? null : json["versionInApk"],
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() {
    return {
      'errMsg': errMsg,
      'isSandboxApk': isSandboxApk,
      'isSandboxUser': isSandboxUser,
      'returnCode': returnCode,
      'versionFrMarket': versionFrMarket,
      'versionInApk': versionInApk,
      'status': status == null ? null : status!.toMap(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is IsSandboxActivatedResult &&
        this.errMsg == other.errMsg &&
        this.isSandboxApk == other.isSandboxApk &&
        this.isSandboxUser == other.isSandboxUser &&
        this.returnCode == other.returnCode &&
        this.versionFrMarket == other.versionFrMarket &&
        this.versionInApk == other.versionInApk &&
        this.status == other.status;
  }

  @override
  int get hashCode =>
      errMsg.hashCode ^
      isSandboxApk.hashCode ^
      isSandboxUser.hashCode ^
      returnCode.hashCode ^
      versionFrMarket.hashCode ^
      versionInApk.hashCode ^
      status.hashCode;
}
