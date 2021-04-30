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

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:huawei_gameservice/constants/constants.dart';
import 'package:huawei_gameservice/model/apk_upgrade_info.dart';
import 'package:huawei_gameservice/model/model_export.dart';

/// Provides APIs for JOS management, for example app initialization, managing
/// app updates and managing missing orders.
class JosAppsClient {
  static String _clientName = "JosAppsClient.";

  /// Initializes an app.
  /// This method must be called when an app is launched.
  static Future<void> init() async {
    await josAppChannel.invokeMethod(_clientName + "init");
  }

  /// Obtains the app ID.
  static Future<String> getAppId() async {
    return await josAppChannel.invokeMethod(_clientName + "getAppId");
  }

  /// Triggers te app update pop-up manually.
  /// When detecting that a new version is available for update, an app can call this method.
  static Future<void> showUpdateDialog(
      bool forceUpdate, ApkUpgradeInfo apkUpgradeInfo) async {
    return await josAppChannel.invokeMethod(_clientName + "showUpdateDialog",
        {"forceUpdate": forceUpdate, "apkUpgradeInfo": apkUpgradeInfo.toMap()});
  }

  /// Releases callback to prevent memory leaks.
  static Future<void> releaseCallback() async {
    return await josAppChannel.invokeMethod(_clientName + "releaseCallback");
  }

  /// Queries the missed orders for the current Huawei ID.
  static Future<List<ProductOrderInfo>> getMissProductOrder() async {
    final response =
        await josAppChannel.invokeMethod(_clientName + "getMissProductOrder");

    return List<ProductOrderInfo>.from(response
            .map((x) => ProductOrderInfo.fromMap(Map<String, dynamic>.from(x))))
        .toList();
  }

  /// Checks for app updates and listens the callbacks.
  static Future<void> checkAppUpdate(
      CheckUpdateCallback checkUpdateCallback) async {
    josAppChannel.setMethodCallHandler(
        (call) => checkAppUpdateHandler(checkUpdateCallback, call));
    return await josAppChannel.invokeMethod(_clientName + "checkAppUpdate");
  }

  /// Method handler for CheckUpdateCallback callback.
  static Future<void> checkAppUpdateHandler(
      CheckUpdateCallback checkUpdateCallback, MethodCall call) async {
    if (call.method == "onUpdateInfo") {
      return checkUpdateCallback.onUpdateInfo(
          UpdateInfo.fromMap((Map<String, dynamic>.from(call.arguments))));
    } else if (call.method == "onMarketStoreError") {
      return checkUpdateCallback.onMarketStoreError(call.arguments);
    } else if (call.method == "onUpdateStoreError") {
      return checkUpdateCallback.onUpdateStoreError(call.arguments);
    }
  }
}
