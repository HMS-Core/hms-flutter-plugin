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

class InAppPurchaseData {
  static const int NOT_PRESENT = -2147483648;

  //Purchase State
  static const int INITIALIZED = -2147483648;
  static const int PURCHASED = 0;
  static const int CANCELED = 1;
  static const int REFUNDED = 2;

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
  int graceExpirationTime;

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
        autoRenewing:
            json["autoRenewing"] == null ? null : json["autoRenewing"],
        orderId: json["orderId"] == null ? null : json["orderId"],
        packageName: json["packageName"] == null ? null : json["packageName"],
        applicationId:
            json["applicationId"] == null ? null : json["applicationId"],
        kind: json["kind"] == null ? null : json["kind"],
        productId: json["productId"] == null ? null : json["productId"],
        productName: json["productName"] == null ? null : json["productName"],
        purchaseTime:
            json["purchaseTime"] == null ? null : json["purchaseTime"],
        purchaseTimeMillis: json["purchaseTimeMillis"] == null
            ? null
            : json["purchaseTimeMillis"],
        purchaseState:
            json["purchaseState"] == null ? null : json["purchaseState"],
        developerPayload:
            json["developerPayload"] == null ? null : json["developerPayload"],
        purchaseToken:
            json["purchaseToken"] == null ? null : json["purchaseToken"],
        consumptionState:
            json["consumptionState"] == null ? null : json["consumptionState"],
        confirmed: json["confirmed"] == null ? null : json["confirmed"],
        currency: json["currency"] == null ? null : json["currency"],
        price: json["price"] == null ? null : json["price"],
        country: json["country"] == null ? null : json["country"],
        payOrderId: json["payOrderId"] == null ? null : json["payOrderId"],
        payType: json["payType"] == null ? null : json["payType"],
        purchaseType:
            json["purchaseType"] == null ? null : json["purchaseType"],
        lastOrderId: json["lastOrderId"] == null ? null : json["lastOrderId"],
        productGroup:
            json["productGroup"] == null ? null : json["productGroup"],
        oriPurchaseTime:
            json["oriPurchaseTime"] == null ? null : json["oriPurchaseTime"],
        subscriptionId:
            json["subscriptionId"] == null ? null : json["subscriptionId"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        daysLasted: json["daysLasted"] == null ? null : json["daysLasted"],
        numOfPeriods:
            json["numOfPeriods"] == null ? null : json["numOfPeriods"],
        numOfDiscounts:
            json["numOfDiscounts"] == null ? null : json["numOfDiscounts"],
        expirationDate:
            json["expirationDate"] == null ? null : json["expirationDate"],
        expirationIntent:
            json["expirationIntent"] == null ? null : json["ExpirationIntent"],
        retryFlag: json["retryFlag"] == null ? null : json["retryFlag"],
        introductoryFlag:
            json["introductoryFlag"] == null ? null : json["introductoryFlag"],
        trialFlag: json["trialFlag"] == null ? null : json["trialFlag"],
        cancelTime: json["cancelTime"] == null ? null : json["cancelTime"],
        cancelReason:
            json["cancelReason"] == null ? null : json["cancelReason"],
        appInfo: json["appInfo"] == null ? null : json["appInfo"],
        notifyClosed:
            json["notifyClosed"] == null ? null : json["notifyClosed"],
        renewStatus: json["renewStatus"] == null ? null : json["renewStatus"],
        subIsvalid: json["subIsvalid"] == null ? null : json["subIsvalid"],
        cancelledSubKeepDays: json["cancelledSubKeepDays"] == null
            ? null
            : json["cancelledSubKeepDays"],
        developerChallenge: json["developerChallenge"] == null
            ? null
            : json["developerChallenge"],
        deferFlag: json["deferFlag"] == null ? null : json["deferFlag"],
        oriSubscriptionId: json["oriSubscriptionId"] == null
            ? null
            : json["oriSubscriptionId"],
        cancelWay: json["cancelWay"] == null ? null : json["cancelWay"],
        cancellationTime:
            json["cancellationTime"] == null ? null : json["cancellationTime"],
        resumeTime: json["resumeTime"] == null ? null : json["resumeTime"],
        accountFlag: json["accountFlag"] == null ? null : json["accountFlag"],
        renewPrice: json["renewPrice"] == null ? null : json["renewPrice"],
        priceConsentStatus: json["priceConsentStatus"] == null
            ? null
            : json["priceConsentStatus"],
        graceExpirationTime: json["graceExpirationTime"] == null
            ? null
            : json["graceExpirationTime"],
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
    final InAppPurchaseData check = o;
    return o is InAppPurchaseData &&
        check.autoRenewing == autoRenewing &&
        check.orderId == orderId &&
        check.packageName == packageName &&
        check.applicationId == applicationId &&
        check.kind == kind &&
        check.productId == productId &&
        check.productName == productName &&
        check.purchaseTime == purchaseTime &&
        check.purchaseTimeMillis == purchaseTimeMillis &&
        check.purchaseState == purchaseState &&
        check.developerPayload == developerPayload &&
        check.purchaseToken == purchaseToken &&
        check.consumptionState == consumptionState &&
        check.confirmed == confirmed &&
        check.currency == currency &&
        check.price == price &&
        check.country == country &&
        check.payOrderId == payOrderId &&
        check.payType == payType &&
        check.purchaseType == purchaseType &&
        check.lastOrderId == lastOrderId &&
        check.productGroup == productGroup &&
        check.oriPurchaseTime == oriPurchaseTime &&
        check.subscriptionId == subscriptionId &&
        check.quantity == quantity &&
        check.daysLasted == daysLasted &&
        check.numOfPeriods == numOfPeriods &&
        check.numOfDiscounts == numOfDiscounts &&
        check.expirationDate == expirationDate &&
        check.expirationIntent == expirationIntent &&
        check.retryFlag == retryFlag &&
        check.introductoryFlag == introductoryFlag &&
        check.trialFlag == trialFlag &&
        check.cancelTime == cancelTime &&
        check.cancelReason == cancelReason &&
        check.appInfo == appInfo &&
        check.notifyClosed == notifyClosed &&
        check.renewStatus == renewStatus &&
        check.subIsvalid == subIsvalid &&
        check.cancelledSubKeepDays == cancelledSubKeepDays &&
        check.developerChallenge == developerChallenge &&
        check.deferFlag == deferFlag &&
        check.oriSubscriptionId == oriSubscriptionId &&
        check.cancelWay == cancelWay &&
        check.cancellationTime == cancellationTime &&
        check.resumeTime == resumeTime &&
        check.accountFlag == accountFlag &&
        check.renewPrice == renewPrice &&
        check.priceConsentStatus == priceConsentStatus &&
        check.graceExpirationTime == graceExpirationTime;
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
