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

class ConsumePurchaseData {
  int applicationId;
  bool autoRenewing;
  String orderId;
  String packageName;
  String productId;
  int purchaseTime;
  int purchaseState;
  String developerPayload;
  String purchaseToken;
  String developerChallenge;
  int consumptionState;
  int acknowledged;
  String currency;
  int price;
  String country;
  String responseCode;
  String responseMessage;
  int kind;
  String productName;
  int purchaseTimeMillis;
  int confirmed;
  int purchaseType;
  String payOrderId;
  String payType;

  ConsumePurchaseData(
      {this.autoRenewing,
      this.orderId,
      this.packageName,
      this.applicationId,
      this.productId,
      this.purchaseTime,
      this.purchaseState,
      this.developerPayload,
      this.purchaseToken,
      this.consumptionState,
      this.currency,
      this.price,
      this.country,
      this.developerChallenge,
      this.acknowledged,
      this.responseCode,
      this.responseMessage,
      this.kind,
      this.productName,
      this.purchaseTimeMillis,
      this.confirmed,
      this.purchaseType,
      this.payOrderId,
      this.payType});

  factory ConsumePurchaseData.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;
    return ConsumePurchaseData(
      applicationId: map["applicationId"] == null ? null : map["applicationId"],
      autoRenewing: map["autoRenewing"] == null ? null : map["autoRenewing"],
      orderId: map["orderId"] == null ? null : map["orderId"],
      packageName: map["packageName"] == null ? null : map["packageName"],
      productId: map["productId"] == null ? null : map["productId"],
      purchaseTime: map["purchaseTime"] == null ? null : map["purchaseTime"],
      purchaseState: map["purchaseState"] == null ? null : map["purchaseState"],
      developerPayload:
          map["developerPayload"] == null ? null : map["developerPayload"],
      purchaseToken: map["purchaseToken"] == null ? null : map["purchaseToken"],
      developerChallenge:
          map["developerChallenge"] == null ? null : map["developerChallenge"],
      consumptionState:
          map["consumptionState"] == null ? null : map["consumptionState"],
      acknowledged: map["acknowledged"] == null ? null : map["acknowledged"],
      currency: map["currency"] == null ? null : map["currency"],
      price: map["price"] == null ? null : map["price"],
      country: map["country"] == null ? null : map["country"],
      responseCode: map["responseCode"] == null ? null : map["responseCode"],
      responseMessage:
          map["responseMessage"] == null ? null : map["responseMessage"],
      kind: map["kind"] == null ? null : map["kind"],
      productName: map["productName"] == null ? null : map["productName"],
      purchaseTimeMillis:
          map["purchaseTimeMillis"] == null ? null : map["purchaseTimeMillis"],
      confirmed: map["confirmed"] == null ? null : map["confirmed"],
      purchaseType: map["purchaseType"] == null ? null : map["purchaseType"],
      payOrderId: map["payOrderId"] == null ? null : map["payOrderId"],
      payType: map["payType"] == null ? null : map["payType"],
    );
  }

  factory ConsumePurchaseData.fromJson(String source) {
    if (source == null) return null;
    return ConsumePurchaseData.fromMap(json.decode(source));
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['autoRenewing'] = this.autoRenewing;
    data['orderId'] = this.orderId;
    data['packageName'] = this.packageName;
    data['applicationId'] = this.applicationId;
    data['productId'] = this.productId;
    data['purchaseTime'] = this.purchaseTime;
    data['purchaseState'] = this.purchaseState;
    data['developerPayload'] = this.developerPayload;
    data['purchaseToken'] = this.purchaseToken;
    data['consumptionState'] = this.consumptionState;
    data['currency'] = this.currency;
    data['price'] = this.price;
    data['country'] = this.country;
    data['developerChallenge'] = this.developerChallenge;
    data['acknowledged'] = this.acknowledged;
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    data['kind'] = this.kind;
    data['productName'] = this.productName;
    data['purchaseTimeMillis'] = this.purchaseTimeMillis;
    data['confirmed'] = this.confirmed;
    data['purchaseType'] = this.purchaseType;
    data['payOrderId'] = this.payOrderId;
    data['payType'] = this.payType;
    return data;
  }

  String toJson() => json.encode(toMap());
}
