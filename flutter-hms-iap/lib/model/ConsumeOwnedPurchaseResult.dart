/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'ConsumePurchaseData.dart';
import 'Status.dart';

class ConsumeOwnedPurchaseResult {
  ConsumePurchaseData? consumePurchaseData;
  String? dataSignature;
  String? errMsg;
  String? returnCode;
  Status? status;
  String? rawValue;

  ConsumeOwnedPurchaseResult({
    this.consumePurchaseData,
    this.dataSignature,
    this.errMsg,
    this.returnCode,
    this.status,
    this.rawValue,
  });

  factory ConsumeOwnedPurchaseResult.fromJson(String source) =>
      ConsumeOwnedPurchaseResult.fromMap(source);

  String toJson() => json.encode(toMap());

  factory ConsumeOwnedPurchaseResult.fromMap(String source) {
    Map<String, dynamic> jsonMap = json.decode(source);
    return ConsumeOwnedPurchaseResult(
      consumePurchaseData: jsonMap["consumePurchaseData"] == null
          ? null
          : ConsumePurchaseData.fromJson(jsonMap["consumePurchaseData"]),
      dataSignature: jsonMap["dataSignature"],
      errMsg: jsonMap["errMsg"],
      returnCode: jsonMap["returnCode"].toString(),
      status:
          jsonMap["status"] == null ? null : Status.fromMap(jsonMap["status"]),
      rawValue: source,
    );
  }

  Map<String, dynamic> toMap() => {
        "consumePurchaseData": consumePurchaseData?.toJson(),
        "dataSignature": dataSignature,
        "errMsg": errMsg,
        "returnCode": returnCode,
        "status": status?.toMap(),
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    return o is ConsumeOwnedPurchaseResult &&
        o.consumePurchaseData == consumePurchaseData &&
        o.dataSignature == dataSignature &&
        o.errMsg == errMsg &&
        o.returnCode == returnCode &&
        o.status == status;
  }

  @override
  int get hashCode =>
      consumePurchaseData.hashCode ^
      dataSignature.hashCode ^
      errMsg.hashCode ^
      returnCode.hashCode ^
      status.hashCode;
}
