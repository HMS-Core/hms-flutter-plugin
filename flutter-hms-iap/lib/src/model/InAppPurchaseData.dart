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

/// Provides a tool that parses the InAppPurchaseData string.
class InAppPurchaseData {
  /// Indicates that the field does not exist in the source JSON string.
  static const int NOT_PRESENT = -2147483648;

  /// Purchase State
  static const int INITIALIZED = -2147483648;
  static const int PURCHASED = 0;
  static const int CANCELED = 1;
  static const int REFUNDED = 2;
  static const int PENDING = 3;

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
        autoRenewing:
            json['autoRenewing'] == null ? null : json['autoRenewing'],
        orderId: json['orderId'] == null ? null : json['orderId'],
        packageName: json['packageName'] == null ? null : json['packageName'],
        applicationId:
            json['applicationId'] == null ? null : json['applicationId'],
        kind: json['kind'] == null ? null : json['kind'],
        productId: json['productId'] == null ? null : json['productId'],
        productName: json['productName'] == null ? null : json['productName'],
        purchaseTime:
            json['purchaseTime'] == null ? null : json['purchaseTime'],
        purchaseTimeMillis: json['purchaseTimeMillis'] == null
            ? null
            : json['purchaseTimeMillis'],
        purchaseState:
            json['purchaseState'] == null ? null : json['purchaseState'],
        developerPayload:
            json['developerPayload'] == null ? null : json['developerPayload'],
        purchaseToken:
            json['purchaseToken'] == null ? null : json['purchaseToken'],
        consumptionState:
            json['consumptionState'] == null ? null : json['consumptionState'],
        confirmed: json['confirmed'] == null ? null : json['confirmed'],
        currency: json['currency'] == null ? null : json['currency'],
        price: json['price'] == null ? null : json['price'],
        country: json['country'] == null ? null : json['country'],
        payOrderId: json['payOrderId'] == null ? null : json['payOrderId'],
        payType: json['payType'] == null ? null : json['payType'],
        purchaseType:
            json['purchaseType'] == null ? null : json['purchaseType'],
        lastOrderId: json['lastOrderId'] == null ? null : json['lastOrderId'],
        productGroup:
            json['productGroup'] == null ? null : json['productGroup'],
        oriPurchaseTime:
            json['oriPurchaseTime'] == null ? null : json['oriPurchaseTime'],
        subscriptionId:
            json['subscriptionId'] == null ? null : json['subscriptionId'],
        quantity: json['quantity'] == null ? null : json['quantity'],
        daysLasted: json['daysLasted'] == null ? null : json['daysLasted'],
        numOfPeriods:
            json['numOfPeriods'] == null ? null : json['numOfPeriods'],
        numOfDiscounts:
            json['numOfDiscounts'] == null ? null : json['numOfDiscounts'],
        expirationDate:
            json['expirationDate'] == null ? null : json['expirationDate'],
        expirationIntent:
            json['expirationIntent'] == null ? null : json['ExpirationIntent'],
        retryFlag: json['retryFlag'] == null ? null : json['retryFlag'],
        introductoryFlag:
            json['introductoryFlag'] == null ? null : json['introductoryFlag'],
        trialFlag: json['trialFlag'] == null ? null : json['trialFlag'],
        cancelTime: json['cancelTime'] == null ? null : json['cancelTime'],
        cancelReason:
            json['cancelReason'] == null ? null : json['cancelReason'],
        appInfo: json['appInfo'] == null ? null : json['appInfo'],
        notifyClosed:
            json['notifyClosed'] == null ? null : json['notifyClosed'],
        renewStatus: json['renewStatus'] == null ? null : json['renewStatus'],
        subIsvalid: json['subIsvalid'] == null ? null : json['subIsvalid'],
        cancelledSubKeepDays: json['cancelledSubKeepDays'] == null
            ? null
            : json['cancelledSubKeepDays'],
        developerChallenge: json['developerChallenge'] == null
            ? null
            : json['developerChallenge'],
        deferFlag: json['deferFlag'] == null ? null : json['deferFlag'],
        oriSubscriptionId: json['oriSubscriptionId'] == null
            ? null
            : json['oriSubscriptionId'],
        cancelWay: json['cancelWay'] == null ? null : json['cancelWay'],
        cancellationTime:
            json['cancellationTime'] == null ? null : json['cancellationTime'],
        resumeTime: json['resumeTime'] == null ? null : json['resumeTime'],
        accountFlag: json['accountFlag'] == null ? null : json['accountFlag'],
        renewPrice: json['renewPrice'] == null ? null : json['renewPrice'],
        priceConsentStatus: json['priceConsentStatus'] == null
            ? null
            : json['priceConsentStatus'],
        graceExpirationTime: json['graceExpirationTime'] == null
            ? null
            : json['graceExpirationTime'],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is InAppPurchaseData &&
        this.autoRenewing == other.autoRenewing &&
        this.orderId == other.orderId &&
        this.packageName == other.packageName &&
        this.applicationId == other.applicationId &&
        this.kind == other.kind &&
        this.productId == other.productId &&
        this.productName == other.productName &&
        this.purchaseTime == other.purchaseTime &&
        this.purchaseTimeMillis == other.purchaseTimeMillis &&
        this.purchaseState == other.purchaseState &&
        this.developerPayload == other.developerPayload &&
        this.purchaseToken == other.purchaseToken &&
        this.consumptionState == other.consumptionState &&
        this.confirmed == other.confirmed &&
        this.currency == other.currency &&
        this.price == other.price &&
        this.country == other.country &&
        this.payOrderId == other.payOrderId &&
        this.payType == other.payType &&
        this.purchaseType == other.purchaseType &&
        this.lastOrderId == other.lastOrderId &&
        this.productGroup == other.productGroup &&
        this.oriPurchaseTime == other.oriPurchaseTime &&
        this.subscriptionId == other.subscriptionId &&
        this.quantity == other.quantity &&
        this.daysLasted == other.daysLasted &&
        this.numOfPeriods == other.numOfPeriods &&
        this.numOfDiscounts == other.numOfDiscounts &&
        this.expirationDate == other.expirationDate &&
        this.expirationIntent == other.expirationIntent &&
        this.retryFlag == other.retryFlag &&
        this.introductoryFlag == other.introductoryFlag &&
        this.trialFlag == other.trialFlag &&
        this.cancelTime == other.cancelTime &&
        this.cancelReason == other.cancelReason &&
        this.appInfo == other.appInfo &&
        this.notifyClosed == other.notifyClosed &&
        this.renewStatus == other.renewStatus &&
        this.subIsvalid == other.subIsvalid &&
        this.cancelledSubKeepDays == other.cancelledSubKeepDays &&
        this.developerChallenge == other.developerChallenge &&
        this.deferFlag == other.deferFlag &&
        this.oriSubscriptionId == other.oriSubscriptionId &&
        this.cancelWay == other.cancelWay &&
        this.cancellationTime == other.cancellationTime &&
        this.resumeTime == other.resumeTime &&
        this.accountFlag == other.accountFlag &&
        this.renewPrice == other.renewPrice &&
        this.priceConsentStatus == other.priceConsentStatus &&
        this.graceExpirationTime == other.graceExpirationTime;
  }

  @override
  int get hashCode => Object.hashAll(
        <dynamic>[
          autoRenewing,
          orderId,
          packageName,
          applicationId,
          kind,
          productId,
          productName,
          purchaseTime,
          purchaseTimeMillis,
          purchaseState,
          developerPayload,
          purchaseToken,
          consumptionState,
          confirmed,
          currency,
          price,
          country,
          payOrderId,
          payType,
          purchaseType,
          lastOrderId,
          productGroup,
          oriPurchaseTime,
          subscriptionId,
          quantity,
          daysLasted,
          numOfPeriods,
          numOfDiscounts,
          expirationDate,
          expirationIntent,
          retryFlag,
          introductoryFlag,
          trialFlag,
          cancelTime,
          cancelReason,
          appInfo,
          notifyClosed,
          renewStatus,
          subIsvalid,
          cancelledSubKeepDays,
          developerChallenge,
          deferFlag,
          oriSubscriptionId,
          cancelWay,
          cancellationTime,
          resumeTime,
          accountFlag,
          renewPrice,
          priceConsentStatus,
          graceExpirationTime,
        ],
      );
}
