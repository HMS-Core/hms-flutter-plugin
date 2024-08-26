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

/// Request information of the obtainOwnedPurchases or obtainOwnedPurchaseRecord API.
class OwnedPurchasesReq extends BaseReq {
  /// Data location flag for query in pagination mode.
  ///
  /// This parameter is optional for the first query. After the API is called, the returned information contains this parameter. If query in pagination mode is required for the next API call, this parameter can be set for the second query.
  String? continuationToken;

  /// Type of a product to be queried.
  /// - `0`: Consumable
  /// - `1`: Non-consumable
  /// - `2`: Auto-renewable subscription
  int priceType;

  /// Signature algorithm, which is optional.
  ///
  /// If a signature algorithm is passed, IAP will use it to sign consumption result data.
  ///
  /// Currently, the value can only be `SIGNATURE_ALGORITHM_SHA256WITHRSA_PSS`, which indicates the SHA256WithRSA/PSS algorithm.
  String? signatureAlgorithm;

  /// Creates an [OwnedPurchasesReq] object.
  OwnedPurchasesReq({
    required this.priceType,
    this.continuationToken,
    this.signatureAlgorithm,
    String? reservedInfor,
  }) : super(reservedInfor: reservedInfor);

  /// Creates an [OwnedPurchasesReq] object from a JSON string.
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
        reservedInfor: json['reservedInfor'],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'continuationToken': continuationToken,
      'priceType': priceType,
      'signatureAlgorithm': signatureAlgorithm,
      'reservedInfor': reservedInfor,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is OwnedPurchasesReq &&
        this.continuationToken == other.continuationToken &&
        this.priceType == other.priceType &&
        this.signatureAlgorithm == other.signatureAlgorithm &&
        this.reservedInfor == other.reservedInfor;
  }

  @override
  int get hashCode => Object.hash(
        continuationToken,
        priceType,
        signatureAlgorithm,
        reservedInfor,
      );
}
