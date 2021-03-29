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

class InAppPurchaseData {
  static const int NOT_PRESENT = -2147483648;

  //Purchase State
  static const int INITIALIZED = -2147483648;
  static const int PURCHASED = 0;
  static const int CANCELED = 1;
  static const int REFUNDED = 2;

  int? applicationId;
  bool? autoRenewing;
  String? orderId;
  String? packageName;
  String? productId;
  String? productName;
  int? purchaseTime;
  int? purchaseState;
  String? developerPayload;
  String? purchaseToken;
  int? purchaseType;
  String? currency;
  int? price;
  String? country;
  String? lastOrderId;
  String? productGroup;
  int? oriPurchaseTime;
  String? subscriptionId;
  int? quantity;
  int? daysLasted;
  int? numOfPeriods;
  int? numOfDiscounts;
  int? expirationDate;
  int? expirationIntent;
  int? retryFlag;
  int? introductoryFlag;
  int? trialFlag;
  int? cancelTime;
  int? cancelReason;
  String? appInfo;
  int? notifyClosed;
  int? renewStatus;
  int? priceConsentStatus;
  int? renewPrice;
  bool? subIsvalid;
  int? cancelledSubKeepDays;
  int? kind;
  String? developerChallenge;
  int? consumptionState;
  String? payOrderId;
  String? payType;
  int? deferFlag;
  String? oriSubscriptionId;
  int? cancelWay;
  int? cancellationTime;
  int? resumeTime;
  int? accountFlag;
  int? purchaseTimeMillis;
  int? confirmed;
  int? graceExpirationTime;

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
    this.graceExpirationTime,
  });

  factory InAppPurchaseData.fromJson(String str) =>
      InAppPurchaseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InAppPurchaseData.fromMap(Map<dynamic, dynamic> json) =>
      InAppPurchaseData(
        autoRenewing: json["autoRenewing"],
        orderId: json["orderId"],
        packageName: json["packageName"],
        applicationId: json["applicationId"],
        kind: json["kind"],
        productId: json["productId"],
        productName: json["productName"],
        purchaseTime: json["purchaseTime"],
        purchaseTimeMillis: json["purchaseTimeMillis"],
        purchaseState: json["purchaseState"],
        developerPayload: json["developerPayload"],
        purchaseToken: json["purchaseToken"],
        consumptionState: json["consumptionState"],
        confirmed: json["confirmed"],
        currency: json["currency"],
        price: json["price"],
        country: json["country"],
        payOrderId: json["payOrderId"],
        payType: json["payType"],
        purchaseType: json["purchaseType"],
        lastOrderId: json["lastOrderId"],
        productGroup: json["productGroup"],
        oriPurchaseTime: json["oriPurchaseTime"],
        subscriptionId: json["subscriptionId"],
        quantity: json["quantity"],
        daysLasted: json["daysLasted"],
        numOfPeriods: json["numOfPeriods"],
        numOfDiscounts: json["numOfDiscounts"],
        expirationDate: json["expirationDate"],
        expirationIntent: json["ExpirationIntent"],
        retryFlag: json["retryFlag"],
        introductoryFlag: json["introductoryFlag"],
        trialFlag: json["trialFlag"],
        cancelTime: json["cancelTime"],
        cancelReason: json["cancelReason"],
        appInfo: json["appInfo"],
        notifyClosed: json["notifyClosed"],
        renewStatus: json["renewStatus"],
        subIsvalid: json["subIsvalid"],
        cancelledSubKeepDays: json["cancelledSubKeepDays"],
        developerChallenge: json["developerChallenge"],
        deferFlag: json["deferFlag"],
        oriSubscriptionId: json["oriSubscriptionId"],
        cancelWay: json["cancelWay"],
        cancellationTime: json["cancellationTime"],
        resumeTime: json["resumeTime"],
        accountFlag: json["accountFlag"],
        renewPrice: json["renewPrice"],
        priceConsentStatus: json["priceConsentStatus"],
        graceExpirationTime: json["graceExpirationTime"],
      );

  Map<String, dynamic> toMap() {
    return {
      'autoRenewing': autoRenewing,
      'orderId': orderId,
      'packageName': packageName,
      'applicationId': applicationId,
      'kind': kind,
      'productId': productId,
      'productName': productName,
      'purchaseTime': purchaseTime,
      'purchaseTimeMillis': purchaseTimeMillis,
      'purchaseState': purchaseState,
      'developerPayload': developerPayload,
      'purchaseToken': purchaseToken,
      'consumptionState': consumptionState,
      'confirmed': confirmed,
      'currency': currency,
      'price': price,
      'country': country,
      'payOrderId': payOrderId,
      'payType': payType,
      'purchaseType': purchaseType,
      'lastOrderId': lastOrderId,
      'productGroup': productGroup,
      'oriPurchaseTime': oriPurchaseTime,
      'subscriptionId': subscriptionId,
      'quantity': quantity,
      'daysLasted': daysLasted,
      'numOfPeriods': numOfPeriods,
      'numOfDiscounts': numOfDiscounts,
      'expirationDate': expirationDate,
      'expirationIntent': expirationIntent,
      'retryFlag': retryFlag,
      'introductoryFlag': introductoryFlag,
      'trialFlag': trialFlag,
      'cancelTime': cancelTime,
      'cancelReason': cancelReason,
      'appInfo': appInfo,
      'notifyClosed': notifyClosed,
      'renewStatus': renewStatus,
      'subIsvalid': subIsvalid,
      'cancelledSubKeepDays': cancelledSubKeepDays,
      'developerChallenge': developerChallenge,
      'deferFlag': deferFlag,
      'oriSubscriptionId': oriSubscriptionId,
      'cancelWay': cancelWay,
      'cancellationTime': cancellationTime,
      'resumeTime': resumeTime,
      'accountFlag': accountFlag,
      'renewPrice': renewPrice,
      'priceConsentStatus': priceConsentStatus,
      'graceExpirationTime': graceExpirationTime,
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    return o is InAppPurchaseData &&
        o.autoRenewing == autoRenewing &&
        o.orderId == orderId &&
        o.packageName == packageName &&
        o.applicationId == applicationId &&
        o.kind == kind &&
        o.productId == productId &&
        o.productName == productName &&
        o.purchaseTime == purchaseTime &&
        o.purchaseTimeMillis == purchaseTimeMillis &&
        o.purchaseState == purchaseState &&
        o.developerPayload == developerPayload &&
        o.purchaseToken == purchaseToken &&
        o.consumptionState == consumptionState &&
        o.confirmed == confirmed &&
        o.currency == currency &&
        o.price == price &&
        o.country == country &&
        o.payOrderId == payOrderId &&
        o.payType == payType &&
        o.purchaseType == purchaseType &&
        o.lastOrderId == lastOrderId &&
        o.productGroup == productGroup &&
        o.oriPurchaseTime == oriPurchaseTime &&
        o.subscriptionId == subscriptionId &&
        o.quantity == quantity &&
        o.daysLasted == daysLasted &&
        o.numOfPeriods == numOfPeriods &&
        o.numOfDiscounts == numOfDiscounts &&
        o.expirationDate == expirationDate &&
        o.expirationIntent == expirationIntent &&
        o.retryFlag == retryFlag &&
        o.introductoryFlag == introductoryFlag &&
        o.trialFlag == trialFlag &&
        o.cancelTime == cancelTime &&
        o.cancelReason == cancelReason &&
        o.appInfo == appInfo &&
        o.notifyClosed == notifyClosed &&
        o.renewStatus == renewStatus &&
        o.subIsvalid == subIsvalid &&
        o.cancelledSubKeepDays == cancelledSubKeepDays &&
        o.developerChallenge == developerChallenge &&
        o.deferFlag == deferFlag &&
        o.oriSubscriptionId == oriSubscriptionId &&
        o.cancelWay == cancelWay &&
        o.cancellationTime == cancellationTime &&
        o.resumeTime == resumeTime &&
        o.accountFlag == accountFlag &&
        o.renewPrice == renewPrice &&
        o.priceConsentStatus == priceConsentStatus &&
        o.graceExpirationTime == graceExpirationTime;
  }

  @override
  int get hashCode =>
      autoRenewing.hashCode ^
      orderId.hashCode ^
      packageName.hashCode ^
      applicationId.hashCode ^
      kind.hashCode ^
      productId.hashCode ^
      productName.hashCode ^
      purchaseTime.hashCode ^
      purchaseTimeMillis.hashCode ^
      purchaseState.hashCode ^
      developerPayload.hashCode ^
      purchaseToken.hashCode ^
      consumptionState.hashCode ^
      confirmed.hashCode ^
      currency.hashCode ^
      price.hashCode ^
      country.hashCode ^
      payOrderId.hashCode ^
      payType.hashCode ^
      purchaseType.hashCode ^
      lastOrderId.hashCode ^
      productGroup.hashCode ^
      oriPurchaseTime.hashCode ^
      subscriptionId.hashCode ^
      quantity.hashCode ^
      daysLasted.hashCode ^
      numOfPeriods.hashCode ^
      numOfDiscounts.hashCode ^
      expirationDate.hashCode ^
      expirationIntent.hashCode ^
      retryFlag.hashCode ^
      introductoryFlag.hashCode ^
      trialFlag.hashCode ^
      cancelTime.hashCode ^
      cancelReason.hashCode ^
      appInfo.hashCode ^
      notifyClosed.hashCode ^
      renewStatus.hashCode ^
      subIsvalid.hashCode ^
      cancelledSubKeepDays.hashCode ^
      developerChallenge.hashCode ^
      deferFlag.hashCode ^
      oriSubscriptionId.hashCode ^
      cancelWay.hashCode ^
      cancellationTime.hashCode ^
      resumeTime.hashCode ^
      accountFlag.hashCode ^
      renewPrice.hashCode ^
      priceConsentStatus.hashCode ^
      graceExpirationTime.hashCode;
}
