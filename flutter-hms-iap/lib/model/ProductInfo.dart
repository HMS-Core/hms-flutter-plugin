/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/
import 'dart:convert';

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

  factory ProductInfo.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;
    return ProductInfo(
      productId: map["a"] == null ? null : map["a"],
      priceType: map["b"] == null ? null : map["b"],
      price: map["c"] == null ? null : map["c"],
      microsPrice: map["d"] == null ? null : map["d"],
      originalLocalPrice: map["e"] == null ? null : map["e"],
      originalMicroPrice: map["f"] == null ? null : map["f"],
      currency: map["g"] == null ? null : map["g"],
      productName: map["h"] == null ? null : map["h"],
      productDesc: map["i"] == null ? null : map["i"],
      subSpecialPriceMicros: map["l"] == null ? null : map["l"],
      subSpecialPeriodCycles: map["n"] == null ? null : map["n"],
      subProductLevel: map["r"] == null ? null : map["r"],
      status: map["status"] == null ? null : map["status"],
      subFreeTrialPeriod: map["o"] == null ? null : map["o"],
      subGroupId: map["p"] == null ? null : map["p"],
      subGroupTitle: map["q"] == null ? null : map["q"],
      subSpecialPeriod: map["m"] == null ? null : map["m"],
      subPeriod: map["j"] == null ? null : map["j"],
      subSpecialPrice: map["k"] == null ? null : map["k"],
    );
  }

  factory ProductInfo.fromJson(String source) =>
      ProductInfo.fromMap(json.decode(source));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['a'] = this.productId;
    data['b'] = this.priceType;
    data['c'] = this.price;
    data['d'] = this.microsPrice;
    data['e'] = this.originalLocalPrice;
    data['f'] = this.originalMicroPrice;
    data['g'] = this.currency;
    data['h'] = this.productName;
    data['i'] = this.productDesc;
    data['l'] = this.subSpecialPriceMicros;
    data['n'] = this.subSpecialPeriodCycles;
    data['r'] = this.subProductLevel;
    data['status'] = this.status;
    data['j'] = this.subPeriod;
    data['k'] = this.subSpecialPrice;
    data['m'] = this.subSpecialPeriod;
    data['o'] = this.subFreeTrialPeriod;
    data['p'] = this.subGroupId;
    data['q'] = this.subGroupTitle;
    return data;
  }
}
