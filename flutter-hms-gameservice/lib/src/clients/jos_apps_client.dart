/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_gameservice;

/// Provides APIs for JOS management, for example app initialization, managing
/// app updates and managing missing orders.
abstract class JosAppsClient {
  /// Initializes an app.
  /// This method must be called when an app is launched.
  static Future<void> init() async {
    await _josAppChannel.invokeMethod(
      'JosAppsClient.init',
    );
  }

  /// Obtains the app ID.
  static Future<String> getAppId() async {
    return await _josAppChannel.invokeMethod(
      'JosAppsClient.getAppId',
    );
  }

  /// Triggers te app update pop-up manually.
  /// When detecting that a new version is available for update, an app can call this method.
  static Future<void> showUpdateDialog(
    bool forceUpdate,
    ApkUpgradeInfo apkUpgradeInfo,
  ) async {
    return await _josAppChannel.invokeMethod(
      'JosAppsClient.showUpdateDialog',
      <String, dynamic>{
        'forceUpdate': forceUpdate,
        'apkUpgradeInfo': apkUpgradeInfo.toMap(),
      },
    );
  }

  /// Releases callback to prevent memory leaks.
  static Future<void> releaseCallback() async {
    return await _josAppChannel.invokeMethod(
      'JosAppsClient.releaseCallback',
    );
  }

  /// Queries the missed orders for the current Huawei ID.
  static Future<List<ProductOrderInfo>> getMissProductOrder() async {
    final dynamic response = await _josAppChannel.invokeMethod(
      'JosAppsClient.getMissProductOrder',
    );
    return List<ProductOrderInfo>.from(
      response.map(
        (dynamic x) => ProductOrderInfo.fromMap(
          Map<dynamic, dynamic>.from(x),
        ),
      ),
    ).toList();
  }

  /// Checks for app updates and listens the callbacks.
  static Future<void> checkAppUpdate(
    CheckUpdateCallback checkUpdateCallback,
  ) async {
    _josAppChannel.setMethodCallHandler(
      (MethodCall call) => checkAppUpdateHandler(checkUpdateCallback, call),
    );
    return await _josAppChannel.invokeMethod(
      'JosAppsClient.checkAppUpdate',
    );
  }

  /// Method handler for CheckUpdateCallback callback.
  static Future<void> checkAppUpdateHandler(
    CheckUpdateCallback checkUpdateCallback,
    MethodCall call,
  ) async {
    if (call.method == 'onUpdateInfo') {
      return checkUpdateCallback.onUpdateInfo(
        UpdateInfo.fromMap(
          Map<dynamic, dynamic>.from(call.arguments),
        ),
      );
    } else if (call.method == 'onMarketStoreError') {
      return checkUpdateCallback.onMarketStoreError(call.arguments);
    } else if (call.method == 'onUpdateStoreError') {
      return checkUpdateCallback.onUpdateStoreError(call.arguments);
    }
  }
}
