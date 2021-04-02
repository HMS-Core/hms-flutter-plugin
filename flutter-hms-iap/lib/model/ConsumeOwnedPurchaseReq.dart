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

class ConsumeOwnedPurchaseReq {
  String purchaseToken;
  String developerChallenge;

  ConsumeOwnedPurchaseReq({
    @required this.purchaseToken,
    this.developerChallenge,
  });

  factory ConsumeOwnedPurchaseReq.fromJson(String str) =>
      ConsumeOwnedPurchaseReq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConsumeOwnedPurchaseReq.fromMap(Map<String, dynamic> json) =>
      ConsumeOwnedPurchaseReq(
        purchaseToken:
            json['purchaseToken'] == null ? null : json['purchaseToken'],
        developerChallenge: json['developerChallange'] == null
            ? null
            : json['developerChallange'],
      );

  Map<String, dynamic> toMap() {
    return {
      'purchaseToken': purchaseToken,
      'developerChallenge': developerChallenge
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final ConsumeOwnedPurchaseReq check = o;
    return o is ConsumeOwnedPurchaseReq &&
        check.purchaseToken == purchaseToken &&
        check.developerChallenge == developerChallenge;
  }

  @override
  int get hashCode => purchaseToken.hashCode ^ developerChallenge.hashCode;
}
