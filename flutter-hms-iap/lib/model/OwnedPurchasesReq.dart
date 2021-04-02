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

class OwnedPurchasesReq {
  String continuationToken;
  int priceType;

  OwnedPurchasesReq({
    @required this.priceType,
    this.continuationToken,
  });

  factory OwnedPurchasesReq.fromJson(String str) =>
      OwnedPurchasesReq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OwnedPurchasesReq.fromMap(Map<String, dynamic> json) =>
      OwnedPurchasesReq(
        continuationToken: json['continuationToken'] == null
            ? null
            : json['continuationToken'],
        priceType: json['priceType'] == null ? null : json['priceType'],
      );

  Map<String, dynamic> toMap() {
    return {
      "continuationToken": continuationToken,
      "priceType": priceType,
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final OwnedPurchasesReq check = o;
    return o is OwnedPurchasesReq &&
        check.continuationToken == continuationToken &&
        check.priceType == priceType;
  }

  @override
  int get hashCode => continuationToken.hashCode ^ priceType.hashCode;
}
