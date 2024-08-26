/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
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

part of '../../huawei_ml_text.dart';

class MLCustomViewAnalyzer {
  late MethodChannel _customizedViewChannel;
  late MethodChannel _remoteViewChannel;
  static MLCustomizedViewSetting? mlCustomizedViewSetting;

  MLCustomViewAnalyzer() {
    _customizedViewChannel =
        const MethodChannel('$baseChannel.customized_view');
    _remoteViewChannel = const MethodChannel('$baseChannel.remote_view');
    _remoteViewChannel.setMethodCallHandler(listenCustomizedLifecycle);
  }

  static Future<dynamic> listenCustomizedLifecycle(MethodCall call) async {
    switch (call.method) {
      case 'onStart':
        mlCustomizedViewSetting?.customizedLifeCycleListener
            ?.call(CustomizedViewEvent.onStart);
        break;
      case 'onResume':
        mlCustomizedViewSetting?.customizedLifeCycleListener
            ?.call(CustomizedViewEvent.onResume);
        break;
      case 'onPause':
        mlCustomizedViewSetting?.customizedLifeCycleListener
            ?.call(CustomizedViewEvent.onPause);
        break;
      case 'onDestroy':
        mlCustomizedViewSetting?.customizedLifeCycleListener
            ?.call(CustomizedViewEvent.onDestroy);
        mlCustomizedViewSetting = null;
        break;
      case 'onStop':
        mlCustomizedViewSetting?.customizedLifeCycleListener
            ?.call(CustomizedViewEvent.onStop);
        break;
    }
  }

  Future<MLBankcard> startCustomizedView(
      MLCustomizedViewSetting setting) async {
    return MLBankcard.fromMap(
      await _customizedViewChannel.invokeMethod(
        'customizedView',
        setting.toMap(),
      ),
    );
  }

  Future<void> switchLight() async {
    await _remoteViewChannel.invokeMethod('switchLight');
  }

  Future<bool?> getLightStatus() async {
    return await _remoteViewChannel.invokeMethod('getLightStatus');
  }
}
