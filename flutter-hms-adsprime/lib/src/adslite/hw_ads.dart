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

class HwAds {
  /// Initializes the HUAWEI Ads SDK.
  static Future<void> init() async {
    Ads.instance.channel.invokeMethod(
      'HwAds-init',
    );
  }

  /// Initializes the HUAWEI Ads SDK with app code.
  static Future<void> initWithAppCode(String appCode) async {
    Ads.instance.channel.invokeMethod(
      'HwAds-initWithAppCode',
    );
  }

  /// Obtains the HUAWEI Ads SDK version.
  static Future<String?> getSdkVersion() async {
    final String? sdkVersion = await Ads.instance.channel.invokeMethod(
      'HwAds-getSdkVersion',
    );
    return sdkVersion;
  }

  /// Obtains the global request configuration.
  static Future<RequestOptions?> getRequestOptions() async {
    final dynamic args = await Ads.instance.channel.invokeMethod(
      'HwAds-getRequestOptions',
    );
    return args != null ? RequestOptions._fromMap(args) : null;
  }

  /// Sets the global ad request configuration.
  static Future<bool?> setRequestOptions(RequestOptions options) async {
    final bool? result = await Ads.instance.channel.invokeMethod(
      'HwAds-setRequestOptions',
      options._toMap(),
    );
    return result;
  }

  /// Sets the user consent string that complies with TCF v2.0.
  static Future<bool?> setConsent(String consent) async {
    final bool? result = await Ads.instance.channel.invokeMethod(
      'HwAds-setConsent',
      <String, dynamic>{
        'consent': consent,
      },
    );
    return result;
  }

  /// Checks whether an app activation reminder pop-up is enabled.
  static Future<bool> isAppInstalledNotify() async {
    final bool? result = await Ads.instance.channel.invokeMethod(
      'HwAds-isAppInstalledNotify',
    );
    return result!;
  }

  /// Sets whether to enable an app activation reminder pop-up.
  static Future<void> setAppInstalledNotify(bool status) async {
    await Ads.instance.channel.invokeMethod(
      'HwAds-setAppInstalledNotify',
      <String, dynamic>{
        'status': status,
      },
    );
  }

  /// Obtains the style of an app activation reminder pop-up.
  static Future<ActivateStyle?> getAppActivateStyle() async {
    final int? result = await Ads.instance.channel.invokeMethod(
      'HwAds-getAppActivateStyle',
    );
    return result != null ? ActivateStyle._(result) : null;
  }

  /// Sets the style for an app activation reminder pop-up after the app installation.
  static Future<void> setAppActivateStyle(ActivateStyle style) async {
    await Ads.instance.channel.invokeMethod(
      'HwAds-setAppActivateStyle',
      <String, dynamic>{
        'style': style.value,
      },
    );
  }

  /// Enables the HMSLogger capability which is used for sending usage analytics of Ads SDK's methods to improve the service quality.
  static Future<bool?> enableLogger() async {
    return await Ads.instance.channel.invokeMethod(
      'enableLogger',
    );
  }

  /// Disables the HMSLogger capability which is used for sending usage analytics of Ads SDK's methods to improve the service quality.
  static Future<bool?> disableLogger() async {
    return await Ads.instance.channel.invokeMethod(
      'disableLogger',
    );
  }
}
