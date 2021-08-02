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
import 'ProductInfo.dart';
import 'Status.dart';

class ProductInfoResult {
  String? errMsg;
  List<ProductInfo>? productInfoList;
  String? returnCode;
  Status? status;

  ProductInfoResult({
    this.errMsg,
    this.productInfoList,
    this.returnCode,
    this.status,
  });

  factory ProductInfoResult.fromJson(String str) =>
      ProductInfoResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductInfoResult.fromMap(Map<dynamic, dynamic> json) =>
      ProductInfoResult(
        errMsg: json["errMsg"] == null ? null : json["errMsg"],
        productInfoList: json["productInfoList"] == null
            ? null
            : List<ProductInfo>.from(
                    json["productInfoList"].map((x) => ProductInfo.fromMap(x)))
                .toList(),
        returnCode:
            json["returnCode"] == null ? null : json["returnCode"].toString(),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() {
    return {
      "errMsg": errMsg,
      "productInfoList": productInfoList == null
          ? null
          : List<dynamic>.from(productInfoList!.map((x) => x.toMap())),
      "returnCode": returnCode,
      "status": status == null ? null : status!.toMap(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is ProductInfoResult &&
        this.errMsg == other.errMsg &&
        listEquals(this.productInfoList, other.productInfoList) &&
        this.returnCode == other.returnCode &&
        this.status == other.status;
  }

  @override
  int get hashCode =>
      errMsg.hashCode ^
      hashList(productInfoList) ^
      returnCode.hashCode ^
      status.hashCode;
}
