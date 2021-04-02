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

class ProductInfo {
  String productId;
  int priceType;
  String price;
  int microsPrice;
  String originalLocalPrice;
  int originalMicroPrice;
  String currency;
  String productName;
  String productDesc;
  int subSpecialPriceMicros;
  int subSpecialPeriodCycles;
  int subProductLevel;
  int status;
  String subFreeTrialPeriod;
  String subGroupId;
  String subGroupTitle;
  String subSpecialPeriod;
  String subPeriod;
  String subSpecialPrice;

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
        productId: map["productId"] == null ? null : map["productId"],
        priceType: map["priceType"] == null ? null : map["priceType"],
        price: map["price"] == null ? null : map["price"],
        microsPrice: map["microsPrice"] == null ? null : map["microsPrice"],
        originalLocalPrice: map["originalLocalPrice"] == null
            ? null
            : map["originalLocalPrice"],
        originalMicroPrice: map["originalMicroPrice"] == null
            ? null
            : map["originalMicroPrice"],
        currency: map["currency"] == null ? null : map["currency"],
        productName: map["productName"] == null ? null : map["productName"],
        productDesc: map["productDesc"] == null ? null : map["productDesc"],
        subSpecialPriceMicros: map["subSpecialPriceMicros"] == null
            ? null
            : map["subSpecialPriceMicros"],
        subSpecialPeriodCycles: map["subSpecialPeriodCycles"] == null
            ? null
            : map["subSpecialPeriodCycles"],
        subProductLevel:
            map["subProductLevel"] == null ? null : map["subProductLevel"],
        status: map["status"] == null ? null : map["status"],
        subFreeTrialPeriod: map["subFreeTrialPeriod"] == null
            ? null
            : map["subFreeTrialPeriod"],
        subGroupId: map["subGroupId"] == null ? null : map["subGroupId"],
        subGroupTitle:
            map["subGroupTitle"] == null ? null : map["subGroupTitle"],
        subSpecialPeriod:
            map["subSpecialPeriod"] == null ? null : map["subSpecialPeriod"],
        subPeriod: map["subPeriod"] == null ? null : map["subPeriod"],
        subSpecialPrice:
            map["subSpecialPrice"] == null ? null : map["subSpecialPrice"],
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
    final ProductInfo check = o;
    return o is ProductInfo &&
        check.productId == productId &&
        check.priceType == priceType &&
        check.price == price &&
        check.microsPrice == microsPrice &&
        check.originalLocalPrice == originalLocalPrice &&
        check.originalMicroPrice == originalMicroPrice &&
        check.currency == currency &&
        check.productName == productName &&
        check.productDesc == productDesc &&
        check.subSpecialPriceMicros == subSpecialPriceMicros &&
        check.subSpecialPeriodCycles == subSpecialPeriodCycles &&
        check.subProductLevel == subProductLevel &&
        check.status == status &&
        check.subFreeTrialPeriod == subFreeTrialPeriod &&
        check.subGroupId == subGroupId &&
        check.subGroupTitle == subGroupTitle &&
        check.subSpecialPeriod == subSpecialPeriod &&
        check.subPeriod == subPeriod &&
        check.subSpecialPrice == subSpecialPrice;
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
