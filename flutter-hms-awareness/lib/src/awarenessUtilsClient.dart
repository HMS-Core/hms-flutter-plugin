/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_awareness;

class AwarenessUtilsClient {
  static const MethodChannel _utilsChannel =
      MethodChannel(_Channel.awarenessUtilsChannel);

  static const MethodChannel _permissionChannel =
      MethodChannel(_Channel.awarenessPermissionCahnnel);

  static Future<void> enableLogger() async {
    await _utilsChannel.invokeMethod(_Method.enableLogger);
  }

  static Future<void> disableLogger() async {
    await _utilsChannel.invokeMethod(_Method.disableLogger);
  }

  static Future<bool> hasLocationPermission() async {
    return (await _permissionChannel
        .invokeMethod(_Method.hasLocationPermission))!;
  }

  static Future<bool> hasBackgroundLocationPermission() async {
    return (await _permissionChannel
        .invokeMethod(_Method.hasBackgroundLocationPermission))!;
  }

  static Future<bool> hasActivityRecognitionPermission() async {
    return (await _permissionChannel
        .invokeMethod(_Method.hasActivityRecognitionPermission))!;
  }

  static Future<bool> requestLocationPermission() async {
    return (await _permissionChannel
        .invokeMethod(_Method.requestLocationPermission))!;
  }

  static Future<bool> requestBackgroundLocationPermission() async {
    return (await _permissionChannel
        .invokeMethod(_Method.requestBackgroundLocationPermission))!;
  }

  static Future<bool> requestActivityRecognitionPermission() async {
    return (await _permissionChannel
        .invokeMethod(_Method.requestActivityRecognitionPermission));
  }
}
