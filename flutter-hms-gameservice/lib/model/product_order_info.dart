/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

/// A class that includes the details about a missed order.
class ProductOrderInfo {
  /// The transaction ID.
  /// IDs are maintained by Huawei Server.
  String tradeId;

  /// Th ID of the product that has not been delivered.
  String productNo;

  /// The ID of a missed order.
  String orderId;

  /// The signature og the order.
  ///
  /// The app's server needs to verify the validity of the order information
  /// on Huawei Server.
  String sign;

  ProductOrderInfo({
    this.tradeId,
    this.productNo,
    this.orderId,
    this.sign,
  });

  Map<String, dynamic> toMap() {
    return {
      "tradeId": tradeId,
      "productNo": productNo,
      "orderId": orderId,
      "sign": sign,
    };
  }

  factory ProductOrderInfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return ProductOrderInfo(
      tradeId: map['tradeId'],
      productNo: map['productNo'],
      orderId: map['orderId'],
      sign: map['sign'],
    );
  }

  @override
  String toString() {
    return 'ProductOrderInfo(tradeId: $tradeId, productNo: $productNo, orderId: $orderId, sign: $sign)';
  }
}
