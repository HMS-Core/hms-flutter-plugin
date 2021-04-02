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
import 'package:huawei_ads/hms_ads.dart';
import 'package:huawei_ads/adslite/request_options.dart';

class HwAds {
  static Future<void> init() async {
    Ads.instance.channel.invokeMethod('HwAds-init');
  }

  static Future<void> initWithAppCode(String appCode) async {
    Ads.instance.channel.invokeMethod('HwAds-initWithAppCode');
  }

  static Future<String> get getSdkVersion async {
    String sdkVersion =
        await Ads.instance.channel.invokeMethod('HwAds-getSdkVersion');
    return sdkVersion;
  }

  static Future<RequestOptions> get getRequestOptions async {
    dynamic args =
        await Ads.instance.channel.invokeMethod('HwAds-getRequestOptions');
    return args != null ? RequestOptions.fromJson(args) : null;
  }

  static Future<bool> setRequestOptions(RequestOptions options) async {
    bool result = await Ads.instance.channel
        .invokeMethod('HwAds-setRequestOptions', options.toJson());
    return result;
  }

  static Future<bool> setConsent(String consent) async {
    bool result = await Ads.instance.channel.invokeMethod('HwAds-setConsent', {
      'consent': consent,
    });
    return result;
  }

  static Future<bool> enableLogger() async {
    return await Ads.instance.channel.invokeMethod('enableLogger');
  }

  static Future<bool> disableLogger() async {
    return await Ads.instance.channel.invokeMethod('disableLogger');
  }
}
