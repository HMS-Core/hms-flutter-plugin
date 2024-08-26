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

part of '../../huawei_iap.dart';

/// Request information of the createPurchaseIntent API.
class PurchaseIntentReq extends BaseReq {
  ///   /// Product type.
  ///
  /// - `0`: Consumable
  /// - `1`: Non-consumable
  /// - `2`: Auto-renewable subscription
  int priceType;

  /// ID of a product to be paid.
  ///
  /// The product ID is the same as that you set when configuring product information in AppGallery Connect.
  String productId;

  /// Information stored on the merchant side.
  ///
  /// If this parameter is set to a value, the value will be returned in the callback result to the app after successful payment.
  ///
  /// The value length of this parameter is within (0, 128).
  String? developerPayload;

  /// Signature algorithm, which is optional.
  ///
  /// If a signature algorithm is passed, IAP will use it to sign consumption result data.
  ///
  /// Currently, the value can only be `SIGNATURE_ALGORITHM_SHA256WITHRSA_PSS`, which indicates the SHA256WithRSA/PSS algorithm.
  String? signatureAlgorithm;

  /// Creates a [PurchaseIntentReq] object.
  PurchaseIntentReq({
    required this.priceType,
    required this.productId,
    this.developerPayload,
    this.signatureAlgorithm,
    String? reservedInfor,
  }) : super(reservedInfor: reservedInfor);

  /// Creates a [PurchaseIntentReq] object from a JSON string.
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
