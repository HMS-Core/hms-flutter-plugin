/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_adsprime.dart';

abstract class VastSdkFactory {
  /// Initializes the HUAWEI VAST SDK.
  static Future<void> init(VastSdkConfiguration configuration) async {
    return await Ads.instance.channelVast.invokeMethod(
      'SdkFactory-init',
      <String, dynamic>{
        'configuration': configuration._toMap(),
      },
    );
  }

  /// Obtains the configuration object for initializing the SDK.
  static Future<VastSdkConfiguration?> getConfiguration() async {
    final Map<dynamic, dynamic>? result =
        await Ads.instance.channelVast.invokeMethod(
      'SdkFactory-getConfiguration',
      <String, dynamic>{},
    );
    return result != null ? VastSdkConfiguration._fromMap(result) : null;
  }

  /// Immediately synchronizes the local cache configuration file to the cloud.
  /// Once synchronized, the validity period of the file will be recalculated.
  static Future<void> updateSdkServerConfig(String slotId) async {
    return await Ads.instance.channelVast.invokeMethod(
      'SdkFactory-updateSdkServerConfig',
      <String, dynamic>{
        'slotId': slotId,
      },
    );
  }

  /// Sets whether consent is obtained from users to use their device data and personal data specified in user agreements.
  static Future<void> userAcceptAdLicense(bool isAcceptOrNot) async {
    return await Ads.instance.channelVast.invokeMethod(
      'SdkFactory-userAcceptAdLicense',
      <String, dynamic>{
        'isAcceptOrNot': isAcceptOrNot,
      },
    );
  }
}
