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

/// Request information of the obtainOwnedPurchases or obtainOwnedPurchaseRecord API.
class OwnedPurchasesReq {
  String? continuationToken;
  int priceType;
  String? signatureAlgorithm;

  OwnedPurchasesReq({
    required this.priceType,
    this.continuationToken,
    this.signatureAlgorithm,
  });

  factory OwnedPurchasesReq.fromJson(String str) =>
      OwnedPurchasesReq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OwnedPurchasesReq.fromMap(Map<String, dynamic> json) =>
      OwnedPurchasesReq(
        continuationToken: json['continuationToken'] == null
            ? null
            : json['continuationToken'],
        priceType: json['priceType'],
        signatureAlgorithm: json['signatureAlgorithm'],
      );

  Map<String, dynamic> toMap() {
    return {
      "continuationToken": continuationToken,
      "priceType": priceType,
      "signatureAlgorithm": signatureAlgorithm,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is OwnedPurchasesReq &&
        this.continuationToken == other.continuationToken &&
        this.priceType == other.priceType &&
        this.signatureAlgorithm == other.signatureAlgorithm;
  }

  @override
  int get hashCode =>
      continuationToken.hashCode ^
      priceType.hashCode ^
      signatureAlgorithm.hashCode;
}
