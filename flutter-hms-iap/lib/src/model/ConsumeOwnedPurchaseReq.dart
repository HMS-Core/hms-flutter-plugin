/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

part of huawei_iap;

/// Request information of the consumeOwnedPurchase API.
class ConsumeOwnedPurchaseReq extends BaseReq {
  String purchaseToken;
  String? developerChallenge;
  String? signatureAlgorithm;

  ConsumeOwnedPurchaseReq({
    required this.purchaseToken,
    this.developerChallenge,
    this.signatureAlgorithm,
    String? reservedInfor,
  }) : super(reservedInfor: reservedInfor);

  factory ConsumeOwnedPurchaseReq.fromJson(String str) =>
      ConsumeOwnedPurchaseReq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConsumeOwnedPurchaseReq.fromMap(Map<String, dynamic> json) =>
      ConsumeOwnedPurchaseReq(
        purchaseToken: json['purchaseToken'],
        developerChallenge: json['developerChallange'] == null
            ? null
            : json['developerChallange'],
        signatureAlgorithm: json['signatureAlgorithm'] == null
            ? null
            : json['signatureAlgorithm'],
        reservedInfor:
            json['reservedInfor'] == null ? null : json['reservedInfor'],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'purchaseToken': purchaseToken,
      'developerChallenge': developerChallenge,
      'signatureAlgorithm': signatureAlgorithm,
      'reservedInfor': reservedInfor,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is ConsumeOwnedPurchaseReq &&
        this.purchaseToken == other.purchaseToken &&
        this.developerChallenge == other.developerChallenge &&
        this.signatureAlgorithm == other.signatureAlgorithm &&
        this.reservedInfor == other.reservedInfor;
  }

  @override
  int get hashCode => Object.hash(
        purchaseToken,
        developerChallenge,
        signatureAlgorithm,
        reservedInfor,
      );
}
