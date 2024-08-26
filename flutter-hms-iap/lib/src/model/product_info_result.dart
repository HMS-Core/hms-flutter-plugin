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

/// Information returned when the obtainProductInfo API is successfully called.
class ProductInfoResult {
  /// Result code description
  String? errMsg;

  /// List of found products.
  List<ProductInfo>? productInfoList;

  /// Result code.
  ///
  /// - `0`: The query is successful.
  String? returnCode;

  /// [Status] object that contains the task processing result.
  Status? status;

  /// Creates a [ProductInfoResult] object.
  ProductInfoResult({
    this.errMsg,
    this.productInfoList,
    this.returnCode,
    this.status,
  });

  /// Creates a [ProductInfoResult] object from a JSON string.
  factory ProductInfoResult.fromJson(String str) =>
      ProductInfoResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductInfoResult.fromMap(Map<dynamic, dynamic> json) =>
      ProductInfoResult(
        errMsg: json['errMsg'] == null ? null : json['errMsg'],
        productInfoList: json['productInfoList'] == null
            ? null
            : List<ProductInfo>.from(
                json['productInfoList']
                    .map((dynamic x) => ProductInfo.fromMap(x)),
              ).toList(),
        returnCode:
            json['returnCode'] == null ? null : json['returnCode'].toString(),
        status: json['status'] == null ? null : Status.fromMap(json['status']),
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errMsg': errMsg,
      'productInfoList': productInfoList == null
          ? null
          : List<dynamic>.from(
              productInfoList!.map((ProductInfo x) => x.toMap()),
            ),
      'returnCode': returnCode,
      'status': status == null ? null : status!.toMap(),
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
  int get hashCode => Object.hash(
        errMsg,
        Object.hashAll(productInfoList ?? <Iterable<Object>>[]),
        returnCode,
        status,
      );
}
