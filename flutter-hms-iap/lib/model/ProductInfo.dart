/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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

class ProductInfo {
  String? productId;
  int? priceType;
  String? price;
  int? microsPrice;
  String? originalLocalPrice;
  int? originalMicroPrice;
  String? currency;
  String? productName;
  String? productDesc;
  int? subSpecialPriceMicros;
  int? subSpecialPeriodCycles;
  int? subProductLevel;
  int? status;
  String? subFreeTrialPeriod;
  String? subGroupId;
  String? subGroupTitle;
  String? subSpecialPeriod;
  String? subPeriod;
  String? subSpecialPrice;

  ProductInfo({
    this.productId,
    this.priceType,
    this.price,
    this.microsPrice,
    this.originalLocalPrice,
    this.originalMicroPrice,
    this.currency,
    this.productName,
    this.productDesc,
    this.subSpecialPriceMicros,
    this.subSpecialPeriodCycles,
    this.subProductLevel,
    this.status,
    this.subFreeTrialPeriod,
    this.subGroupId,
    this.subGroupTitle,
    this.subSpecialPeriod,
    this.subPeriod,
    this.subSpecialPrice,
  });

  factory ProductInfo.fromJson(String str) =>
      ProductInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductInfo.fromMap(Map<dynamic, dynamic> map) => ProductInfo(
        productId: map["productId"],
        priceType: map["priceType"],
        price: map["price"],
        microsPrice: map["microsPrice"],
        originalLocalPrice: map["originalLocalPrice"],
        originalMicroPrice: map["originalMicroPrice"],
        currency: map["currency"],
        productName: map["productName"],
        productDesc: map["productDesc"],
        subSpecialPriceMicros: map["subSpecialPriceMicros"],
        subSpecialPeriodCycles: map["subSpecialPeriodCycles"],
        subProductLevel: map["subProductLevel"],
        status: map["status"],
        subFreeTrialPeriod: map["subFreeTrialPeriod"],
        subGroupId: map["subGroupId"],
        subGroupTitle: map["subGroupTitle"],
        subSpecialPeriod: map["subSpecialPeriod"],
        subPeriod: map["subPeriod"],
        subSpecialPrice: map["subSpecialPrice"],
      );

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'priceType': priceType,
      'price': price,
      'microsPrice': microsPrice,
      'originalLocalPrice': originalLocalPrice,
      'originalMicroPrice': originalMicroPrice,
      'currency': currency,
      'productName': productName,
      'productDesc': productDesc,
      'subSpecialPriceMicros': subSpecialPriceMicros,
      'subSpecialPeriodCycles': subSpecialPeriodCycles,
      'subProductLevel': subProductLevel,
      'status': status,
      'subPeriod': subPeriod,
      'subSpecialPrice': subSpecialPrice,
      'subSpecialPeriod': subSpecialPeriod,
      'subFreeTrialPeriod': subFreeTrialPeriod,
      'subGroupId': subGroupId,
      'subGroupTitle': subGroupTitle,
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    return o is ProductInfo &&
        o.productId == productId &&
        o.priceType == priceType &&
        o.price == price &&
        o.microsPrice == microsPrice &&
        o.originalLocalPrice == originalLocalPrice &&
        o.originalMicroPrice == originalMicroPrice &&
        o.currency == currency &&
        o.productName == productName &&
        o.productDesc == productDesc &&
        o.subSpecialPriceMicros == subSpecialPriceMicros &&
        o.subSpecialPeriodCycles == subSpecialPeriodCycles &&
        o.subProductLevel == subProductLevel &&
        o.status == status &&
        o.subFreeTrialPeriod == subFreeTrialPeriod &&
        o.subGroupId == subGroupId &&
        o.subGroupTitle == subGroupTitle &&
        o.subSpecialPeriod == subSpecialPeriod &&
        o.subPeriod == subPeriod &&
        o.subSpecialPrice == subSpecialPrice;
  }

  @override
  int get hashCode =>
      productId.hashCode ^
      priceType.hashCode ^
      price.hashCode ^
      microsPrice.hashCode ^
      originalLocalPrice.hashCode ^
      originalMicroPrice.hashCode ^
      currency.hashCode ^
      productName.hashCode ^
      productDesc.hashCode ^
      subSpecialPriceMicros.hashCode ^
      subSpecialPeriodCycles.hashCode ^
      subProductLevel.hashCode ^
      status.hashCode ^
      subFreeTrialPeriod.hashCode ^
      subGroupId.hashCode ^
      subGroupTitle.hashCode ^
      subSpecialPeriod.hashCode ^
      subPeriod.hashCode ^
      subSpecialPrice.hashCode;
}
