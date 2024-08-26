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

part of '../huawei_iap.dart';

/// Provides all APIs of Flutter IAP Plugin.
class IapClient {
  static const MethodChannel _channel = const MethodChannel('IapClient');

  /// Consumable.
  ///
  /// Original value: `0`.
  static const int IN_APP_CONSUMABLE = 0;

  /// Non-consumable.
  ///
  /// Original value: `1`.
  static const int IN_APP_NONCONSUMABLE = 1;

  /// Subscription.
  ///
  /// Original value: `2`.
  static const int IN_APP_SUBSCRIPTION = 2;

  /// Checks whether the currently signed-in HUAWEI ID is located in a country or region where HUAWEI IAP is available.
  static Future<IsEnvReadyResult> isEnvReady({bool? isSupportAppTouch}) async {
    dynamic result = await _channel.invokeMethod(
      'isEnvReady',
      <String, dynamic>{'isSupportAppTouch': isSupportAppTouch},
    );
    if (result == 'LOGGED_IN') {
      result = await _channel.invokeMethod(
        'isEnvReady',
        <String, dynamic>{'isSupportAppTouch': isSupportAppTouch},
      );
    }
    return IsEnvReadyResult.fromJson(result);
  }

  /// Checks whether the signed-in HUAWEI ID and the app version meet the requirements of the sandbox testing.
  static Future<IsSandboxActivatedResult> isSandboxActivated() async {
    return IsSandboxActivatedResult.fromJson(
      await _channel.invokeMethod('isSandboxActivated'),
    );
  }

  /// Obtains product details configured in AppGallery Connect.
  static Future<ProductInfoResult> obtainProductInfo(
    ProductInfoReq request,
  ) async {
    return ProductInfoResult.fromJson(
      await _channel.invokeMethod('obtainProductInfo', request.toMap()),
    );
  }

  /// Displays the subscription editing screen or subscription management screen of HUAWEI IAP.
  static Future<void> startIapActivity(StartIapActivityReq request) async {
    return await _channel.invokeMethod('startIapActivity', request.toMap());
  }

  /// Creates orders for products managed by the product management system (PMS), including consumables, non-consumables, and subscriptions.
  static Future<PurchaseResultInfo> createPurchaseIntent(
    PurchaseIntentReq request,
  ) async {
    return PurchaseResultInfo.fromJson(
      await _channel.invokeMethod('createPurchaseIntent', request.toMap()),
    );
  }

  /// Queries order information of purchased products.
  static Future<OwnedPurchasesResult> obtainOwnedPurchases(
    OwnedPurchasesReq request,
  ) async {
    return OwnedPurchasesResult.fromJson(
      await _channel.invokeMethod('obtainOwnedPurchases', request.toMap()),
    );
  }

  /// Consumes a consumable after it is successfully delivered.
  static Future<ConsumeOwnedPurchaseResult> consumeOwnedPurchase(
    ConsumeOwnedPurchaseReq request,
  ) async {
    return ConsumeOwnedPurchaseResult.fromJson(
      await _channel.invokeMethod('consumeOwnedPurchase', request.toMap()),
    );
  }

  /// Obtains the purchase information of all consumed products or the receipts of all subscriptions.
  static Future<OwnedPurchasesResult> obtainOwnedPurchaseRecord(
    OwnedPurchasesReq request,
  ) async {
    return OwnedPurchasesResult.fromJson(
      await _channel.invokeMethod(
        'obtainOwnedPurchaseRecord',
        request.toMap(),
      ),
    );
  }

  /// Disables HMS Plugin Method Analytics which is used for sending usage analytics of HUAWEI IAP SDK's methods to improve the service quality.
  static Future<void> disableLogger() async {
    await _channel.invokeMethod('disableLogger');
  }

  /// Enables HMS Plugin Method Analytics which is used for sending usage analytics of HUAWEI IAP SDK's methods to improve the service quality.
  static Future<void> enableLogger() async {
    await _channel.invokeMethod('enableLogger');
  }

  /// Enables pending purchase.
  static Future<String> enablePendingPurchase() async {
    String? result = await _channel.invokeMethod('enablePendingPurchase');
    return result!;
  }
}
