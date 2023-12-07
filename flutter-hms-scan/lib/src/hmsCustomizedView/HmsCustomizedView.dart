/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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
part of huawei_scan;

class HmsCustomizedView {
  static CustomizedViewRequest? customizedViewRequest;

  static Future<dynamic> customizedMethodCallHandler(MethodCall call) async {
    if (call.method == 'CustomizedViewResponse') {
      ScanResponse response = ScanResponse.fromMap(
        Map<String, dynamic>.from(
          call.arguments,
        ),
      );
      HmsCustomizedView.customizedViewRequest?.customizedCameraListener
          ?.call(response);
    }
  }

  static Future<dynamic> listenCustomizedLifecycle(MethodCall call) async {
    switch (call.method) {
      case 'onStart':
        customizedViewRequest?.customizedLifeCycleListener
            ?.call(CustomizedViewEvent.onStart);
        break;
      case 'onResume':
        customizedViewRequest?.customizedLifeCycleListener
            ?.call(CustomizedViewEvent.onResume);
        break;
      case 'onPause':
        customizedViewRequest?.customizedLifeCycleListener
            ?.call(CustomizedViewEvent.onPause);
        break;
      case 'onDestroy':
        customizedViewRequest?.customizedLifeCycleListener
            ?.call(CustomizedViewEvent.onDestroy);
        customizedViewRequest = null;
        break;
      case 'onStop':
        customizedViewRequest?.customizedLifeCycleListener
            ?.call(CustomizedViewEvent.onStop);
        break;
    }
  }

  static Future<bool?> startCustomizedView(
    CustomizedViewRequest request,
  ) async {
    customizedViewRequest = request;
    bool? result = await HmsScan.instance.customizedViewChannel.invokeMethod(
      'customizedView',
      request.toMap(),
    );
    return result;
  }

  static Future<void> pauseScan() async {
    await HmsScan.instance.remoteViewChannel.invokeMethod('pause');
  }

  static Future<void> resumeScan() async {
    await HmsScan.instance.remoteViewChannel.invokeMethod('resume');
  }

  static Future<void> switchLight() async {
    await HmsScan.instance.remoteViewChannel.invokeMethod('switchLight');
  }

  static Future<bool?> getLightStatus() async {
    return await HmsScan.instance.remoteViewChannel
        .invokeMethod('getLightStatus');
  }
}
