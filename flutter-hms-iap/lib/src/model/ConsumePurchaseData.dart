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

part of huawei_iap;

/// Store user's purchase information about consumables, non-consumables, and subscriptions.
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

  ConsumePurchaseData({
    this.autoRenewing,
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
    this.payType,
  });

  factory ConsumePurchaseData.fromJson(String str) =>
      ConsumePurchaseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConsumePurchaseData.fromMap(Map<dynamic, dynamic> json) =>
      ConsumePurchaseData(
        applicationId:
            json['applicationId'] == null ? null : json['applicationId'],
        autoRenewing:
            json['autoRenewing'] == null ? null : json['autoRenewing'],
        orderId: json['orderId'] == null ? null : json['orderId'],
        packageName: json['packageName'] == null ? null : json['packageName'],
        productId: json['productId'] == null ? null : json['productId'],
        purchaseTime:
            json['purchaseTime'] == null ? null : json['purchaseTime'],
        purchaseState:
            json['purchaseState'] == null ? null : json['purchaseState'],
        developerPayload:
            json['developerPayload'] == null ? null : json['developerPayload'],
        purchaseToken:
            json['purchaseToken'] == null ? null : json['purchaseToken'],
        developerChallenge: json['developerChallenge'] == null
            ? null
            : json['developerChallenge'],
        consumptionState:
            json['consumptionState'] == null ? null : json['consumptionState'],
        acknowledged:
            json['acknowledged'] == null ? null : json['acknowledged'],
        currency: json['currency'] == null ? null : json['currency'],
        price: json['price'] == null ? null : json['price'],
        country: json['country'] == null ? null : json['country'],
        responseCode:
            json['responseCode'] == null ? null : json['responseCode'],
        responseMessage:
            json['responseMessage'] == null ? null : json['responseMessage'],
        kind: json['kind'] == null ? null : json['kind'],
        productName: json['productName'] == null ? null : json['productName'],
        purchaseTimeMillis: json['purchaseTimeMillis'] == null
            ? null
            : json['purchaseTimeMillis'],
        confirmed: json['confirmed'] == null ? null : json['confirmed'],
        purchaseType:
            json['purchaseType'] == null ? null : json['purchaseType'],
        payOrderId: json['payOrderId'] == null ? null : json['payOrderId'],
        payType: json['payType'] == null ? null : json['payType'],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is ConsumePurchaseData &&
        this.autoRenewing == other.autoRenewing &&
        this.orderId == other.orderId &&
        this.packageName == other.packageName &&
        this.applicationId == other.applicationId &&
        this.productId == other.productId &&
        this.purchaseTime == other.purchaseTime &&
        this.purchaseState == other.purchaseState &&
        this.developerPayload == other.developerPayload &&
        this.purchaseToken == other.purchaseToken &&
        this.consumptionState == other.consumptionState &&
        this.currency == other.currency &&
        this.price == other.price &&
        this.country == other.country &&
        this.developerChallenge == other.developerChallenge &&
        this.acknowledged == other.acknowledged &&
        this.responseCode == other.responseCode &&
        this.responseMessage == other.responseMessage &&
        this.kind == other.kind &&
        this.productName == other.productName &&
        this.purchaseTimeMillis == other.purchaseTimeMillis &&
        this.confirmed == other.confirmed &&
        this.purchaseType == other.purchaseType &&
        this.payOrderId == other.payOrderId &&
        this.payType == other.payType;
  }

  @override
  int get hashCode => Object.hash(
        autoRenewing,
        orderId,
        packageName,
        applicationId,
        productId,
        purchaseTime,
        purchaseState,
        developerPayload,
        purchaseToken,
        consumptionState,
        currency,
        price,
        country,
        developerChallenge,
        acknowledged,
        responseCode,
        responseMessage,
        kind,
        productName,
        Object.hashAll(
          <Object?>[
            purchaseTimeMillis,
            confirmed,
            purchaseType,
            payOrderId,
            payType,
          ],
        ),
      );
}
