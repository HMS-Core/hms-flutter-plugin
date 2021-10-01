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
import 'dart:ui' show hashList;

import 'package:flutter/foundation.dart' show listEquals;

/// Request information of the obtainProductInfo API.
class ProductInfoReq {
  int priceType;
  List<String> skuIds;

  ProductInfoReq({
    required this.priceType,
    required this.skuIds,
  });

  factory ProductInfoReq.fromJson(String str) =>
      ProductInfoReq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductInfoReq.fromMap(Map<String, dynamic> json) => ProductInfoReq(
        priceType: json['priceType'],
        skuIds: json['skuIds'].cast<String>(),
      );

  Map<String, dynamic> toMap() {
    return {"priceType": priceType, "skuIds": skuIds};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is ProductInfoReq &&
        this.priceType == other.priceType &&
        listEquals(this.skuIds, other.skuIds);
  }

  @override
  int get hashCode => priceType.hashCode ^ hashList(skuIds);
}
