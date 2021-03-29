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
import 'InAppPurchaseData.dart';

class PurchaseResultInfo {
  String? returnCode;
  InAppPurchaseData? inAppPurchaseData;
  String? inAppDataSignature;
  String? errMsg;
  String rawValue;

  PurchaseResultInfo({
    this.inAppDataSignature,
    this.inAppPurchaseData,
    this.returnCode,
    this.errMsg,
    required this.rawValue,
  });

  factory PurchaseResultInfo.fromJson(String str) =>
      PurchaseResultInfo.fromMap(str);

  String toJson() => json.encode(toMap());

  factory PurchaseResultInfo.fromMap(String source) {
    Map<dynamic, dynamic> jsonMap = json.decode(source);
    return PurchaseResultInfo(
      returnCode: jsonMap["returnCode"]?.toString(),
      inAppPurchaseData: jsonMap["inAppPurchaseData"] == null
          ? null
          : InAppPurchaseData.fromJson(jsonMap["inAppPurchaseData"]),
      inAppDataSignature: jsonMap["inAppDataSignature"],
      errMsg: jsonMap["errMsg"],
      rawValue: source,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "returnCode": returnCode,
      "inAppPurchaseData": inAppPurchaseData?.toJson(),
      "inAppDataSignature": inAppDataSignature,
      "errMsg": errMsg,
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    return o is PurchaseResultInfo &&
        o.returnCode == returnCode &&
        o.inAppPurchaseData == inAppPurchaseData &&
        o.inAppDataSignature == inAppDataSignature &&
        o.errMsg == errMsg;
  }

  @override
  int get hashCode =>
      returnCode.hashCode ^
      inAppPurchaseData.hashCode ^
      inAppDataSignature.hashCode ^
      errMsg.hashCode;
}
