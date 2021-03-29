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

class ConsumePurchaseData {
  int? applicationId;
  bool? autoRenewing;
  String? orderId;
  String? packageName;
  String? productId;
  int? purchaseTime;
  int? purchaseState;
  String? developerPayload;
  String? purchaseToken;
  String? developerChallenge;
  int? consumptionState;
  int? acknowledged;
  String? currency;
  int? price;
  String? country;
  String? responseCode;
  String? responseMessage;
  int? kind;
  String? productName;
  int? purchaseTimeMillis;
  int? confirmed;
  int? purchaseType;
  String? payOrderId;
  String? payType;

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

  factory ConsumePurchaseData.fromJson(String str) =>
      ConsumePurchaseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConsumePurchaseData.fromMap(Map<dynamic, dynamic> json) =>
      ConsumePurchaseData(
        applicationId: json["applicationId"],
        autoRenewing: json["autoRenewing"],
        orderId: json["orderId"],
        packageName: json["packageName"],
        productId: json["productId"],
        purchaseTime: json["purchaseTime"],
        purchaseState: json["purchaseState"],
        developerPayload: json["developerPayload"],
        purchaseToken:  json["purchaseToken"],
        developerChallenge: json["developerChallenge"],
        consumptionState: json["consumptionState"],
        acknowledged: json["acknowledged"],
        currency: json["currency"],
        price: json["price"],
        country: json["country"],
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        kind: json["kind"],
        productName: json["productName"],
        purchaseTimeMillis: json["purchaseTimeMillis"],
        confirmed: json["confirmed"],
        purchaseType: json["purchaseType"],
        payOrderId: json["payOrderId"],
        payType: json["payType"],
      );

  Map<String, dynamic> toMap() {
    return {
      'autoRenewing': autoRenewing,
      'orderId': orderId,
      'packageName': packageName,
      'applicationId': applicationId,
      'productId': productId,
      'purchaseTime': purchaseTime,
      'purchaseState': purchaseState,
      'developerPayload': developerPayload,
      'purchaseToken': purchaseToken,
      'consumptionState': consumptionState,
      'currency': currency,
      'price': price,
      'country': country,
      'developerChallenge': developerChallenge,
      'acknowledged': acknowledged,
      'responseCode': responseCode,
      'responseMessage': responseMessage,
      'kind': kind,
      'productName': productName,
      'purchaseTimeMillis': purchaseTimeMillis,
      'confirmed': confirmed,
      'purchaseType': purchaseType,
      'payOrderId': payOrderId,
      'payType': payType,
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    return o is ConsumePurchaseData &&
        o.autoRenewing == autoRenewing &&
        o.orderId == orderId &&
        o.packageName == packageName &&
        o.applicationId == applicationId &&
        o.productId == productId &&
        o.purchaseTime == purchaseTime &&
        o.purchaseState == purchaseState &&
        o.developerPayload == developerPayload &&
        o.purchaseToken == purchaseToken &&
        o.consumptionState == consumptionState &&
        o.currency == currency &&
        o.price == price &&
        o.country == country &&
        o.developerChallenge == developerChallenge &&
        o.acknowledged == acknowledged &&
        o.responseCode == responseCode &&
        o.responseMessage == responseMessage &&
        o.kind == kind &&
        o.productName == productName &&
        o.purchaseTimeMillis == purchaseTimeMillis &&
        o.confirmed == confirmed &&
        o.purchaseType == purchaseType &&
        o.payOrderId == payOrderId &&
        o.payType == payType;
  }

  @override
  int get hashCode =>
      autoRenewing.hashCode ^
      orderId.hashCode ^
      packageName.hashCode ^
      applicationId.hashCode ^
      productId.hashCode ^
      purchaseTime.hashCode ^
      purchaseState.hashCode ^
      developerPayload.hashCode ^
      purchaseToken.hashCode ^
      consumptionState.hashCode ^
      currency.hashCode ^
      price.hashCode ^
      country.hashCode ^
      developerChallenge.hashCode ^
      acknowledged.hashCode ^
      responseCode.hashCode ^
      responseMessage.hashCode ^
      kind.hashCode ^
      productName.hashCode ^
      purchaseTimeMillis.hashCode ^
      confirmed.hashCode ^
      purchaseType.hashCode ^
      payOrderId.hashCode ^
      payType.hashCode;
}
