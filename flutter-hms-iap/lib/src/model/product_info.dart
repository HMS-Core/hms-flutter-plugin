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

/// Details of a product.
class ProductInfo {
  /// Product ID.
  String? productId;

  /// Product type.
  ///
  /// - `0`: Consumable
  /// - `1`: Non-consumable
  /// - `2`: Auto-renewable subscription
  int? priceType;

  /// Displayed price of a product, including the currency symbol and actual price of the product.
  ///
  /// The value is in the Currency symbolPrice format, for example, ¥0.15. The price includes the tax.
  String? price;

  /// Product price in micro unit, which equals the actual product price multiplied by 1,000,000.
  ///
  /// For example, if the actual price of a product is US$1.99, the product price in micro unit is 1,990,000 (1.99 x 1,000,000).
  int? microsPrice;

  /// Original price of a product, including the currency symbol and actual price of the product.
  ///
  /// The value is in the Currency symbolPrice format, for example, ¥0.15. The price includes the tax.
  String? originalLocalPrice;

  /// Original price of a product in micro unit, which equals the original product price multiplied by 1,000,000.
  ///
  /// For example, if the original price of a product is US$1.99, the product price in micro unit is 1,990,000 (1.99 x 1,000,000).
  int? originalMicroPrice;

  /// Currency used to pay for a product.
  ///
  /// The value must comply with the ISO 4217 standard.
  ///
  /// Examples: `'USD'`, `'CNY'`, and `'TRY'`.
  String? currency;

  /// Product name, which is set during product information configuration.
  ///
  /// The name is displayed on the checkout page.
  String? productName;

  /// Description of a product, which is set during product information configuration.
  String? productDesc;

  /// Promotional price of a subscription in micro unit, which equals the actual promotional subscription price multiplied by 1,000,000.
  ///
  /// For example, if the actual price of a product is US$1.99, the product price in micro unit is 1,990,000 (1.99 x 1,000,000).
  ///
  /// This parameter is returned only when subscriptions are queried.
  int? subSpecialPriceMicros;

  /// Number of promotion periods of a subscription. It is set when you set the promotional price of a subscription in AppGallery Connect.
  ///
  /// This parameter is returned only when subscriptions are queried.
  int? subSpecialPeriodCycles;

  /// Level of a subscription in its subscription group.
  int? subProductLevel;

  /// Product status.
  ///
  /// - `0`: Valid.
  /// - `1`: Deleted. Products in this state cannot be renewed or subscribed to.
  /// - `6`: Removed. New subscriptions are not allowed, but the subscriptions already purchased can still renew.
  int? status;

  /// Checks whether a user has enjoyed a promotion in a subscription group.
  ///
  /// Value `-1` is returned if your query is for a non-subscription.
  int? offerUsedStatus;

  /// Free trial period of a subscription.
  ///
  /// It is set when you set the promotional price of a subscription in AppGallery Connect.
  String? subFreeTrialPeriod;

  /// ID of the subscription group to which a subscription belongs.
  String? subGroupId;

  /// Description of the subscription group to which a subscription belongs.
  String? subGroupTitle;

  /// Promotion period unit of a subscription, which complies with the ISO 8601 standard.
  ///
  /// For example, P1W indicates 1 week, P1M indicates 1 month, P2M indicates 2 months, P6M indicates 6 months, and P1Y indicates 1 year.
  ///
  /// This parameter is returned only when subscriptions are queried.
  String? subSpecialPeriod;

  /// Unit of a subscription period, which complies with the ISO 8601 standard.
  ///
  /// For example, P1W indicates 1 week, P1M indicates 1 month, P2M indicates 2 months, P6M indicates 6 months, and P1Y indicates 1 year.
  ///
  /// This parameter is returned only when subscriptions are queried.
  String? subPeriod;

  /// Promotional price of a subscription, including the currency symbol and actual price.
  ///
  /// The value is in the Currency symbolPrice format, for example, ¥0.15. The price includes the tax.
  ///
  /// This parameter is returned only when subscriptions are queried.
  String? subSpecialPrice;

  /// Creates a [ProductInfo] object.
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
    this.offerUsedStatus,
    this.subFreeTrialPeriod,
    this.subGroupId,
    this.subGroupTitle,
    this.subSpecialPeriod,
    this.subPeriod,
    this.subSpecialPrice,
  });

  /// Creates a [ProductInfo] object from a JSON string.
  factory ProductInfo.fromJson(String str) =>
      ProductInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductInfo.fromMap(Map<dynamic, dynamic> map) => ProductInfo(
        productId: map['productId'] == null ? null : map['productId'],
        priceType: map['priceType'] == null ? null : map['priceType'],
        price: map['price'] == null ? null : map['price'],
        microsPrice: map['microsPrice'] == null ? null : map['microsPrice'],
        originalLocalPrice: map['originalLocalPrice'] == null
            ? null
            : map['originalLocalPrice'],
        originalMicroPrice: map['originalMicroPrice'] == null
            ? null
            : map['originalMicroPrice'],
        currency: map['currency'] == null ? null : map['currency'],
        productName: map['productName'] == null ? null : map['productName'],
        productDesc: map['productDesc'] == null ? null : map['productDesc'],
        subSpecialPriceMicros: map['subSpecialPriceMicros'] == null
            ? null
            : map['subSpecialPriceMicros'],
        subSpecialPeriodCycles: map['subSpecialPeriodCycles'] == null
            ? null
            : map['subSpecialPeriodCycles'],
        subProductLevel:
            map['subProductLevel'] == null ? null : map['subProductLevel'],
        status: map['status'] == null ? null : map['status'],
        offerUsedStatus:
            map['offerUsedStatus'] == null ? null : map['offerUsedStatus'],
        subFreeTrialPeriod: map['subFreeTrialPeriod'] == null
            ? null
            : map['subFreeTrialPeriod'],
        subGroupId: map['subGroupId'] == null ? null : map['subGroupId'],
        subGroupTitle:
            map['subGroupTitle'] == null ? null : map['subGroupTitle'],
        subSpecialPeriod:
            map['subSpecialPeriod'] == null ? null : map['subSpecialPeriod'],
        subPeriod: map['subPeriod'] == null ? null : map['subPeriod'],
        subSpecialPrice:
            map['subSpecialPrice'] == null ? null : map['subSpecialPrice'],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
      'offerUsedStatus': offerUsedStatus,
      'subPeriod': subPeriod,
      'subSpecialPrice': subSpecialPrice,
      'subSpecialPeriod': subSpecialPeriod,
      'subFreeTrialPeriod': subFreeTrialPeriod,
      'subGroupId': subGroupId,
      'subGroupTitle': subGroupTitle,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is ProductInfo &&
        this.productId == other.productId &&
        this.priceType == other.priceType &&
        this.price == other.price &&
        this.microsPrice == other.microsPrice &&
        this.originalLocalPrice == other.originalLocalPrice &&
        this.originalMicroPrice == other.originalMicroPrice &&
        this.currency == other.currency &&
        this.productName == other.productName &&
        this.productDesc == other.productDesc &&
        this.subSpecialPriceMicros == other.subSpecialPriceMicros &&
        this.subSpecialPeriodCycles == other.subSpecialPeriodCycles &&
        this.subProductLevel == other.subProductLevel &&
        this.status == other.status &&
        this.offerUsedStatus == other.offerUsedStatus &&
        this.subFreeTrialPeriod == other.subFreeTrialPeriod &&
        this.subGroupId == other.subGroupId &&
        this.subGroupTitle == other.subGroupTitle &&
        this.subSpecialPeriod == other.subSpecialPeriod &&
        this.subPeriod == other.subPeriod &&
        this.subSpecialPrice == other.subSpecialPrice;
  }

  @override
  int get hashCode => Object.hash(
        productId,
        priceType,
        price,
        microsPrice,
        originalLocalPrice,
        originalMicroPrice,
        currency,
        productName,
        productDesc,
        subSpecialPriceMicros,
        subSpecialPeriodCycles,
        subProductLevel,
        status,
        offerUsedStatus,
        subFreeTrialPeriod,
        subGroupId,
        subGroupTitle,
        subSpecialPeriod,
        subPeriod,
        subSpecialPrice,
      );
}
