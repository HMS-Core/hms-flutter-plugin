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

class InAppPurchaseData {
  int applicationId;
  bool autoRenewing;
  String orderId;
  String packageName;
  String productId;
  String productName;
  int purchaseTime;
  int purchaseState;
  String developerPayload;
  String purchaseToken;
  int purchaseType;
  String currency;
  int price;
  String country;
  String lastOrderId;
  String productGroup;
  int oriPurchaseTime;
  String subscriptionId;
  int quantity;
  int daysLasted;
  int numOfPeriods;
  int numOfDiscounts;
  int expirationDate;
  int expirationIntent;
  int retryFlag;
  int introductoryFlag;
  int trialFlag;
  int cancelTime;
  int cancelReason;
  String appInfo;
  int notifyClosed;
  int renewStatus;
  int priceConsentStatus;
  int renewPrice;
  bool subIsvalid;
  int cancelledSubKeepDays;
  int kind;
  String developerChallenge;
  int consumptionState;
  String payOrderId;
  String payType;
  int deferFlag;
  String oriSubscriptionId;
  int cancelWay;
  int cancellationTime;
  int resumeTime;
  int accountFlag;
  int purchaseTimeMillis;
  int confirmed;

  InAppPurchaseData({
    this.autoRenewing,
    this.orderId,
    this.packageName,
    this.applicationId,
    this.kind,
    this.productId,
    this.productName,
    this.purchaseTime,
    this.purchaseTimeMillis,
    this.purchaseState,
    this.developerPayload,
    this.purchaseToken,
    this.consumptionState,
    this.confirmed,
    this.currency,
    this.price,
    this.country,
    this.payOrderId,
    this.payType,
    this.purchaseType,
    this.lastOrderId,
    this.productGroup,
    this.oriPurchaseTime,
    this.subscriptionId,
    this.quantity,
    this.daysLasted,
    this.numOfPeriods,
    this.numOfDiscounts,
    this.expirationDate,
    this.expirationIntent,
    this.retryFlag,
    this.introductoryFlag,
    this.trialFlag,
    this.cancelTime,
    this.cancelReason,
    this.appInfo,
    this.notifyClosed,
    this.renewStatus,
    this.subIsvalid,
    this.cancelledSubKeepDays,
    this.developerChallenge,
    this.deferFlag,
    this.oriSubscriptionId,
    this.cancelWay,
    this.cancellationTime,
    this.resumeTime,
    this.accountFlag,
    this.priceConsentStatus,
    this.renewPrice,
  });

  factory InAppPurchaseData.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;
    return InAppPurchaseData(
        autoRenewing: map["autoRenewing"] == null ? null : map["autoRenewing"],
        orderId: map["orderId"] == null ? null : map["orderId"],
        packageName: map["packageName"] == null ? null : map["packageName"],
        applicationId:
            map["applicationId"] == null ? null : map["applicationId"],
        kind: map["kind"] == null ? null : map["kind"],
        productId: map["productId"] == null ? null : map["productId"],
        productName: map["productName"] == null ? null : map["productName"],
        purchaseTime: map["purchaseTime"] == null ? null : map["purchaseTime"],
        purchaseTimeMillis: map["purchaseTimeMillis"] == null
            ? null
            : map["purchaseTimeMillis"],
        purchaseState:
            map["purchaseState"] == null ? null : map["purchaseState"],
        developerPayload:
            map["developerPayload"] == null ? null : map["developerPayload"],
        purchaseToken:
            map["purchaseToken"] == null ? null : map["purchaseToken"],
        consumptionState:
            map["consumptionState"] == null ? null : map["consumptionState"],
        confirmed: map["confirmed"] == null ? null : map["confirmed"],
        currency: map["currency"] == null ? null : map["currency"],
        price: map["price"] == null ? null : map["price"],
        country: map["country"] == null ? null : map["country"],
        payOrderId: map["payOrderId"] == null ? null : map["payOrderId"],
        payType: map["payType"] == null ? null : map["payType"],
        purchaseType: map["purchaseType"] == null ? null : map["purchaseType"],
        lastOrderId: map["lastOrderId"] == null ? null : map["lastOrderId"],
        productGroup: map["productGroup"] == null ? null : map["productGroup"],
        oriPurchaseTime:
            map["oriPurchaseTime"] == null ? null : map["oriPurchaseTime"],
        subscriptionId:
            map["subscriptionId"] == null ? null : map["subscriptionId"],
        quantity: map["quantity"] == null ? null : map["quantity"],
        daysLasted: map["daysLasted"] == null ? null : map["daysLasted"],
        numOfPeriods: map["numOfPeriods"] == null ? null : map["numOfPeriods"],
        numOfDiscounts:
            map["numOfDiscounts"] == null ? null : map["numOfDiscounts"],
        expirationDate:
            map["expirationDate"] == null ? null : map["expirationDate"],
        expirationIntent:
            map["expirationIntent"] == null ? null : map["ExpirationIntent"],
        retryFlag: map["retryFlag"] == null ? null : map["retryFlag"],
        introductoryFlag:
            map["introductoryFlag"] == null ? null : map["introductoryFlag"],
        trialFlag: map["trialFlag"] == null ? null : map["trialFlag"],
        cancelTime: map["cancelTime"] == null ? null : map["cancelTime"],
        cancelReason: map["cancelReason"] == null ? null : map["cancelReason"],
        appInfo: map["appInfo"] == null ? null : map["appInfo"],
        notifyClosed: map["notifyClosed"] == null ? null : map["notifyClosed"],
        renewStatus: map["renewStatus"] == null ? null : map["renewStatus"],
        subIsvalid: map["subIsvalid"] == null ? null : map["subIsvalid"],
        cancelledSubKeepDays: map["cancelledSubKeepDays"] == null
            ? null
            : map["cancelledSubKeepDays"],
        developerChallenge: map["developerChallenge"] == null
            ? null
            : map["developerChallenge"],
        deferFlag: map["deferFlag"] == null ? null : map["deferFlag"],
        oriSubscriptionId:
            map["oriSubscriptionId"] == null ? null : map["oriSubscriptionId"],
        cancelWay: map["cancelWay"] == null ? null : map["cancelWay"],
        cancellationTime:
            map["cancellationTime"] == null ? null : map["cancellationTime"],
        resumeTime: map["resumeTime"] == null ? null : map["resumeTime"],
        accountFlag: map["accountFlag"] == null ? null : map["accountFlag"],
        renewPrice: map["renewPrice"] == null ? null : map["renewPrice"],
        priceConsentStatus: map["priceConsentStatus"] == null
            ? null
            : map["priceConsentStatus"]);
  }

  factory InAppPurchaseData.fromJson(String source) {
    if (source == null) return null;
    return InAppPurchaseData.fromMap(json.decode(source));
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['autoRenewing'] = this.autoRenewing;
    data['orderId'] = this.orderId;
    data['packageName'] = this.packageName;
    data['applicationId'] = this.applicationId;
    data['kind'] = this.kind;
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['purchaseTime'] = this.purchaseTime;
    data['purchaseTimeMillis'] = this.purchaseTimeMillis;
    data['purchaseState'] = this.purchaseState;
    data['developerPayload'] = this.developerPayload;
    data['purchaseToken'] = this.purchaseToken;
    data['consumptionState'] = this.consumptionState;
    data['confirmed'] = this.confirmed;
    data['currency'] = this.currency;
    data['price'] = this.price;
    data['country'] = this.country;
    data['payOrderId'] = this.payOrderId;
    data['payType'] = this.payType;
    data['purchaseType'] = this.purchaseType;
    data['lastOrderId'] = this.lastOrderId;
    data['productGroup'] = this.productGroup;
    data['oriPurchaseTime'] = this.oriPurchaseTime;
    data['subscriptionId'] = this.subscriptionId;
    data['quantity'] = this.quantity;
    data['daysLasted'] = this.daysLasted;
    data['numOfPeriods'] = this.numOfPeriods;
    data['numOfDiscounts'] = this.numOfDiscounts;
    data['expirationDate'] = this.expirationDate;
    data['expirationIntent'] = this.expirationIntent;
    data['retryFlag'] = this.retryFlag;
    data['introductoryFlag'] = this.introductoryFlag;
    data['trialFlag'] = this.trialFlag;
    data['cancelTime'] = this.cancelTime;
    data['cancelReason'] = this.cancelReason;
    data['appInfo'] = this.appInfo;
    data['notifyClosed'] = this.notifyClosed;
    data['renewStatus'] = this.renewStatus;
    data['subIsvalid'] = this.subIsvalid;
    data['cancelledSubKeepDays'] = this.cancelledSubKeepDays;
    data['developerChallenge'] = this.developerChallenge;
    data['deferFlag'] = this.deferFlag;
    data['oriSubscriptionId'] = this.oriSubscriptionId;
    data['cancelWay'] = this.cancelWay;
    data['cancellationTime'] = this.cancellationTime;
    data['resumeTime'] = this.resumeTime;
    data['accountFlag'] = this.accountFlag;
    data['renewPrice'] = this.renewPrice;
    data['priceConsentStatus'] = this.priceConsentStatus;
    return data;
  }

  String toJson() => json.encode(toMap());
}
