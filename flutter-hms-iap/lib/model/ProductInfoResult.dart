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

import 'ProductInfo.dart';
import 'Status.dart';

class ProductInfoResult {
  String errMsg;
  List<ProductInfo> productInfoList;
  int returnCode;
  Status status;

  ProductInfoResult({
    this.errMsg,
    this.productInfoList,
    this.returnCode,
    this.status,
  });

  factory ProductInfoResult.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;
    return ProductInfoResult(
        errMsg: map["errMsg"] == null ? null : map["errMsg"],
        productInfoList: map["productInfoList"] == null
            ? null
            : List<ProductInfo>.from(
                map['productInfoList'].map((x) => ProductInfo.fromMap(x))),
        returnCode: map["returnCode"] == null ? null : map["returnCode"],
        status: Status.fromJson(map["status"]) == null
            ? null
            : Status.fromJson(map["status"]));
  }

  factory ProductInfoResult.fromJson(String source) =>
      ProductInfoResult.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errMsg'] = this.errMsg;
    if (this.productInfoList != null) {
      data['productInfoList'] =
          this.productInfoList.map((v) => v.toJson()).toList();
    }
    data['returnCode'] = this.returnCode;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    return data;
  }

  String toJson() => json.encode(toMap());
}
