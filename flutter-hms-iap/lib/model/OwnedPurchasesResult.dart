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
import 'dart:ui' show hashList;
import 'package:flutter/foundation.dart';
import 'InAppPurchaseData.dart';
import 'Status.dart';

class OwnedPurchasesResult {
  String continuationToken;
  String errMsg;
  List<InAppPurchaseData> inAppPurchaseDataList;
  List<String> inAppSignature;
  List<String> itemList;
  String returnCode;
  Status status;
  List<String> placedInappPurchaseDataList;
  List<String> placedInappSignatureList;
  String rawValue;

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
    this.rawValue,
  });

  factory OwnedPurchasesResult.fromJson(String str) =>
      OwnedPurchasesResult.fromMap(str);

  String toJson() => json.encode(toMap());

  factory OwnedPurchasesResult.fromMap(String source) {
    Map<String, dynamic> jsonMap = json.decode(source);
    return OwnedPurchasesResult(
      continuationToken: jsonMap["continuationToken"] == null
          ? null
          : jsonMap["continuationToken"],
      errMsg: jsonMap["errMsg"] == null ? null : jsonMap["errMsg"],
      inAppPurchaseDataList: jsonMap["inAppPurchaseDataList"] == null
          ? null
          : List<InAppPurchaseData>.from(jsonMap["inAppPurchaseDataList"]
              .map((x) => InAppPurchaseData.fromJson(x))).toList(),
      inAppSignature: jsonMap["inAppSignature"] == null
          ? null
          : List<String>.from(jsonMap["inAppSignature"].map((x) => x)),
      itemList: jsonMap["itemList"] == null
          ? null
          : List<String>.from(jsonMap["itemList"].map((x) => x)),
      returnCode: jsonMap["returnCode"] == null
          ? null
          : jsonMap["returnCode"].toString(),
      status:
          jsonMap["status"] == null ? null : Status.fromMap(jsonMap["status"]),
      placedInappPurchaseDataList:
          jsonMap["placedInappPurchaseDataList"] == null
              ? null
              : List<String>.from(jsonMap["placedInappPurchaseDataList"]),
      placedInappSignatureList: jsonMap["placedInappSignatureList"] == null
          ? null
          : List<String>.from(jsonMap["placedInappSignatureList"]),
      rawValue: source,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "continuationToken": continuationToken == null ? null : continuationToken,
      "errMsg": errMsg == null ? null : errMsg,
      "inAppPurchaseDataList": inAppPurchaseDataList == null
          ? null
          : List<dynamic>.from(inAppPurchaseDataList.map((x) => x)),
      "inAppSignature": inAppSignature == null
          ? null
          : List<dynamic>.from(inAppSignature.map((x) => x)),
      "itemList":
          itemList == null ? null : List<dynamic>.from(itemList.map((x) => x)),
      "returnCode": returnCode == null ? null : returnCode,
      "status": status == null ? null : status.toMap(),
      "placedInappPurchaseDataList": placedInappPurchaseDataList == null
          ? null
          : List<String>.from(placedInappPurchaseDataList.map((x) => x)),
      "placedInappSignatureList": placedInappSignatureList == null
          ? null
          : List<String>.from(placedInappSignatureList.map((x) => x)),
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final OwnedPurchasesResult check = o;
    return o is OwnedPurchasesResult &&
        check.continuationToken == continuationToken &&
        check.errMsg == errMsg &&
        listEquals(check.inAppPurchaseDataList, inAppPurchaseDataList) &&
        listEquals(check.inAppSignature, inAppSignature) &&
        listEquals(check.itemList, itemList) &&
        check.returnCode == returnCode &&
        check.status == status &&
        listEquals(
            check.placedInappPurchaseDataList, placedInappPurchaseDataList) &&
        listEquals(check.placedInappSignatureList, placedInappSignatureList);
  }

  @override
  int get hashCode =>
      continuationToken.hashCode ^
      errMsg.hashCode ^
      hashList(inAppPurchaseDataList) ^
      hashList(inAppSignature) ^
      hashList(itemList) ^
      returnCode.hashCode ^
      status.hashCode ^
      hashList(placedInappPurchaseDataList) ^
      hashList(placedInappSignatureList);
}
