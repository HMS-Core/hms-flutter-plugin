/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/
import 'dart:convert';

import 'Status.dart';

class IsSandboxActivatedResult {
  String errMsg;
  bool isSandboxApk;
  bool isSandboxUser;
  int returnCode;
  String versionFrMarket;
  String versionInApk;
  Status status;

  IsSandboxActivatedResult({
    this.errMsg,
    this.isSandboxApk,
    this.isSandboxUser,
    this.returnCode,
    this.versionFrMarket,
    this.versionInApk,
    this.status,
  });

  factory IsSandboxActivatedResult.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;
    return IsSandboxActivatedResult(
      errMsg: map["errMsg"] == null ? null : map["errMsg"],
      isSandboxApk: map["isSandboxApk"] == null ? null : map["isSandboxApk"],
      isSandboxUser: map["isSandboxUser"] == null ? null : map["isSandboxUser"],
      returnCode: map["returnCode"] == null ? null : map["returnCode"],
      versionFrMarket:
          map["versionFrMarket"] == null ? null : map["versionFrMarket"],
      versionInApk: map["versionInApk"] == null ? null : map["versionInApk"],
      status: Status.fromJson(map["status"]) == null
          ? null
          : Status.fromJson(map["status"]),
    );
  }

  factory IsSandboxActivatedResult.fromJson(String source) =>
      IsSandboxActivatedResult.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errMsg'] = this.errMsg;
    data['isSandboxApk'] = this.isSandboxApk;
    data['isSandboxUser'] = this.isSandboxUser;
    data['returnCode'] = this.returnCode;
    data['versionFrMarket'] = this.versionFrMarket;
    data['versionInApk'] = this.versionInApk;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    return data;
  }

  String toJson() => json.encode(toMap());
}
