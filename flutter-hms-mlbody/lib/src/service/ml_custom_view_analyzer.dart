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

part of '../../huawei_ml_body.dart';

class MLCustomInteractiveLivenessDetectionAnalyzer {
  late MethodChannel _customizedViewChannel;
  late MethodChannel _remoteViewChannel;
  static MLCustomInteractiveLivenessDetectionSetting?
      mLCustomInteractiveLivenessDetectionSetting;

  MLCustomInteractiveLivenessDetectionAnalyzer() {
    _customizedViewChannel = const MethodChannel('$baseChannel.customizedView');
    _remoteViewChannel = const MethodChannel('$baseChannel.remoteview');
    _remoteViewChannel.setMethodCallHandler(listenCustomizedLifecycle);
  }

  static Future<dynamic> listenCustomizedLifecycle(MethodCall call) async {
    switch (call.method) {
      case 'onStart':
        mLCustomInteractiveLivenessDetectionSetting?.customizedLifeCycleListener
            ?.call(CustomizedViewEvent.onStart);
        break;
      case 'onResume':
        mLCustomInteractiveLivenessDetectionSetting?.customizedLifeCycleListener
            ?.call(CustomizedViewEvent.onResume);
        break;
      case 'onPause':
        mLCustomInteractiveLivenessDetectionSetting?.customizedLifeCycleListener
            ?.call(CustomizedViewEvent.onPause);
        break;
      case 'onDestroy':
        mLCustomInteractiveLivenessDetectionSetting?.customizedLifeCycleListener
            ?.call(CustomizedViewEvent.onDestroy);
        mLCustomInteractiveLivenessDetectionSetting = null;
        break;
      case 'onStop':
        mLCustomInteractiveLivenessDetectionSetting?.customizedLifeCycleListener
            ?.call(CustomizedViewEvent.onStop);
        break;
    }
  }

  Future<MLInteractiveLivenessCaptureResult> startCustomizedView(
      {required MLCustomInteractiveLivenessDetectionSetting setting}) async {
    return MLInteractiveLivenessCaptureResult._fromJson(
      await _customizedViewChannel.invokeMethod(
        'startCustomizedView',
        setting.toMap(),
      ),
    );
  }
}
