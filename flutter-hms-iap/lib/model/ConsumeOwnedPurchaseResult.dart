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

import 'ConsumePurchaseData.dart';
import 'Status.dart';

class ConsumeOwnedPurchaseResult {
  ConsumePurchaseData consumePurchaseData;
  String dataSignature;
  String errMsg;
  int returnCode;
  Status status;

  ConsumeOwnedPurchaseResult({
    this.consumePurchaseData,
    this.dataSignature,
    this.errMsg,
    this.returnCode,
    this.status,
  });

  factory ConsumeOwnedPurchaseResult.fromJson(String source) =>
      ConsumeOwnedPurchaseResult.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  factory ConsumeOwnedPurchaseResult.fromMap(Map<String, dynamic> map) =>
      ConsumeOwnedPurchaseResult(
        consumePurchaseData: map["consumePurchaseData"] == null
            ? null
            : ConsumePurchaseData.fromJson(map["consumePurchaseData"]),
        dataSignature:
            map["dataSignature"] == null ? null : map["dataSignature"],
        errMsg: map["errMsg"] == null ? null : map["errMsg"],
        returnCode: map["returnCode"] == null ? null : map["returnCode"],
        status: map["status"] == null ? null : Status.fromJson(map["status"]),
      );

  Map<String, dynamic> toMap() => {
        "consumePurchaseData":
            consumePurchaseData == null ? null : consumePurchaseData.toJson(),
        "dataSignature": dataSignature == null ? null : dataSignature,
        "errMsg": errMsg == null ? null : errMsg,
        "returnCode": returnCode == null ? null : returnCode,
        "status": status == null ? null : status.toJson(),
      };
}
