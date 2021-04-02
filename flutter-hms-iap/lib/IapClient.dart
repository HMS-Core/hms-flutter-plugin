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
import 'dart:async';
import 'package:flutter/services.dart' show MethodChannel;

import 'model/ConsumeOwnedPurchaseReq.dart';
import 'model/ConsumeOwnedPurchaseResult.dart';
import 'model/IsEnvReadyResult.dart';
import 'model/IsSandboxActivatedResult.dart';
import 'model/OwnedPurchasesReq.dart';
import 'model/OwnedPurchasesResult.dart';
import 'model/ProductInfoReq.dart';
import 'model/ProductInfoResult.dart';
import 'model/PurchaseIntentReq.dart';
import 'model/PurchaseResultInfo.dart';
import 'model/StartIapActivityReq.dart';

class IapClient {
  static const MethodChannel _channel = const MethodChannel('IapClient');

  //Price Type
  static const int IN_APP_CONSUMABLE = 0;
  static const int IN_APP_NONCONSUMABLE = 1;
  static const int IN_APP_SUBSCRIPTION = 2;

  static Future<IsEnvReadyResult> isEnvReady() async {
    return IsEnvReadyResult.fromJson(await _channel.invokeMethod('isEnvReady'));
  }

  static Future<IsSandboxActivatedResult> isSandboxActivated() async {
    return IsSandboxActivatedResult.fromJson(
        await _channel.invokeMethod("isSandboxActivated"));
  }

  static Future<ProductInfoResult> obtainProductInfo(
      ProductInfoReq request) async {
    return ProductInfoResult.fromJson(
        await _channel.invokeMethod("obtainProductInfo", request.toMap()));
  }

  static Future<void> startIapActivity(StartIapActivityReq request) async {
    return await _channel.invokeMethod("startIapActivity", request.toMap());
  }

  static Future<PurchaseResultInfo> createPurchaseIntent(
      PurchaseIntentReq request) async {
    return PurchaseResultInfo.fromJson(
        await _channel.invokeMethod("createPurchaseIntent", request.toMap()));
  }

  static Future<OwnedPurchasesResult> obtainOwnedPurchases(
      OwnedPurchasesReq request) async {
    return OwnedPurchasesResult.fromJson(
        await _channel.invokeMethod("obtainOwnedPurchases", request.toMap()));
  }

  static Future<ConsumeOwnedPurchaseResult> consumeOwnedPurchase(
      ConsumeOwnedPurchaseReq request) async {
    return ConsumeOwnedPurchaseResult.fromJson(
        await _channel.invokeMethod("consumeOwnedPurchase", request.toMap()));
  }

  static Future<OwnedPurchasesResult> obtainOwnedPurchaseRecord(
      OwnedPurchasesReq request) async {
    return OwnedPurchasesResult.fromJson(await _channel.invokeMethod(
        "obtainOwnedPurchaseRecord", request.toMap()));
  }

  //HMS Logger
  static Future<void> disableLogger() async {
    await _channel.invokeMethod("disableLogger");
  }

  static Future<void> enableLogger() async {
    await _channel.invokeMethod("enableLogger");
  }
}
