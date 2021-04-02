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
import 'package:flutter/foundation.dart' show required;

class PurchaseIntentReq {
  int priceType;
  String productId;
  String developerPayload;
  String reservedInfor;

  PurchaseIntentReq({
    @required this.priceType,
    @required this.productId,
    this.developerPayload,
    this.reservedInfor,
  });

  factory PurchaseIntentReq.fromJson(String str) =>
      PurchaseIntentReq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PurchaseIntentReq.fromMap(Map<String, dynamic> json) =>
      PurchaseIntentReq(
        priceType: json['priceType'] == null ? null : json['priceType'],
        productId: json['productId'] == null ? null : json['productId'],
        developerPayload:
            json['developerPayload'] == null ? null : json['developerPayload'],
        reservedInfor:
            json['reservedInfor'] == null ? null : json['reservedInfor'],
      );

  Map<String, dynamic> toMap() {
    return {
      "priceType": priceType,
      "productId": productId,
      "developerPayload": developerPayload,
      "reservedInfor": reservedInfor,
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final PurchaseIntentReq check = o;
    return o is PurchaseIntentReq &&
        check.priceType == priceType &&
        check.productId == productId &&
        check.developerPayload == developerPayload &&
        check.reservedInfor == reservedInfor;
  }

  @override
  int get hashCode =>
      priceType.hashCode ^
      productId.hashCode ^
      developerPayload.hashCode ^
      reservedInfor.hashCode;
}
