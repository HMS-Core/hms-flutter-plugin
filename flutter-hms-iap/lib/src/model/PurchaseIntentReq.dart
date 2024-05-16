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

/// Request information of the createPurchaseIntent API.
class PurchaseIntentReq extends BaseReq {
  int priceType;
  String productId;
  String? developerPayload;
  String? signatureAlgorithm;

  PurchaseIntentReq({
    required this.priceType,
    required this.productId,
    this.developerPayload,
    this.signatureAlgorithm,
    String? reservedInfor,
  }) : super(reservedInfor: reservedInfor);

  factory PurchaseIntentReq.fromJson(String str) =>
      PurchaseIntentReq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PurchaseIntentReq.fromMap(Map<String, dynamic> json) =>
      PurchaseIntentReq(
        priceType: json['priceType'],
        productId: json['productId'],
        developerPayload:
            json['developerPayload'] == null ? null : json['developerPayload'],
        reservedInfor:
            json['reservedInfor'] == null ? null : json['reservedInfor'],
        signatureAlgorithm: json['signatureAlgorithm'],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'priceType': priceType,
      'productId': productId,
      'developerPayload': developerPayload,
      'reservedInfor': reservedInfor,
      'signatureAlgorithm': signatureAlgorithm,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is PurchaseIntentReq &&
        this.priceType == other.priceType &&
        this.productId == other.productId &&
        this.developerPayload == other.developerPayload &&
        this.reservedInfor == other.reservedInfor &&
        this.signatureAlgorithm == other.signatureAlgorithm;
  }

  @override
  int get hashCode => Object.hash(
        priceType,
        productId,
        developerPayload,
        reservedInfor,
        signatureAlgorithm,
      );
}
