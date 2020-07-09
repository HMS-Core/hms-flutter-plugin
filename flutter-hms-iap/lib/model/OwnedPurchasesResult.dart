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

import 'InAppPurchaseData.dart';
import 'Status.dart';

class OwnedPurchasesResult {
  String continuationToken;
  String errMsg;
  List<InAppPurchaseData> inAppPurchaseDataList;
  List<String> inAppSignature;
  List<String> itemList;
  int returnCode;
  Status status;
  List<String> placedInappPurchaseDataList;
  List<String> placedInappSignatureList;

  OwnedPurchasesResult({
    this.continuationToken,
    this.errMsg,
    this.inAppPurchaseDataList,
    this.inAppSignature,
    this.itemList,
    this.returnCode,
    this.status,
    this.placedInappPurchaseDataList,
    this.placedInappSignatureList,
  });

  factory OwnedPurchasesResult.fromJson(String source) =>
      OwnedPurchasesResult.fromMap(json.decode(source));

  factory OwnedPurchasesResult.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return OwnedPurchasesResult(
        continuationToken:
            map["continuationToken"] == null ? null : map["continuationToken"],
        errMsg: map["errMsg"] == null ? null : map["errMsg"],
        inAppPurchaseDataList: map["inAppPurchaseDataList"] == null
            ? null
            : List<InAppPurchaseData>.from(map["inAppPurchaseDataList"]
                .map((x) => InAppPurchaseData.fromJson(x))).toList(),
        inAppSignature: map["inAppSignature"] == null
            ? null
            : List<String>.from(map["inAppSignature"].map((x) => x)),
        itemList: map["itemList"] == null
            ? null
            : List<String>.from(map["itemList"].map((x) => x)),
        returnCode: map["returnCode"] == null ? null : map["returnCode"],
        status: map["status"] == null ? null : Status.fromJson(map["status"]),
        placedInappPurchaseDataList: map["placedInappPurchaseDataList"] == null
            ? null
            : List<String>.from(map["placedInappPurchaseDataList"]),
        placedInappSignatureList: map["placedInappSignatureList"] == null
            ? null
            : List<String>.from(map["placedInappSignatureList"]));
  }

  Map<String, dynamic> toMap() => {
        "continuationToken":
            continuationToken == null ? null : continuationToken,
        "errMsg": errMsg == null ? null : errMsg,
        "inAppPurchaseDataList": inAppPurchaseDataList == null
            ? null
            : List<dynamic>.from(inAppPurchaseDataList.map((x) => x)),
        "inAppSignature": inAppSignature == null
            ? null
            : List<dynamic>.from(inAppSignature.map((x) => x)),
        "itemList": itemList == null
            ? null
            : List<dynamic>.from(itemList.map((x) => x)),
        "returnCode": returnCode == null ? null : returnCode,
        "status": status == null ? null : status.toJson(),
        "placedInappPurchaseDataList": placedInappPurchaseDataList == null
            ? null
            : List<String>.from(placedInappPurchaseDataList.map((x) => x)),
        "placedInappSignatureList": placedInappSignatureList == null
            ? null
            : List<String>.from(placedInappSignatureList.map((x) => x))
      };

  String toJson() => json.encode(toMap());
}
