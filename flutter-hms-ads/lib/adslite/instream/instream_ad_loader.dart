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
import 'package:flutter/services.dart';
import 'package:huawei_ads/adslite/ad_param.dart';
import 'package:huawei_ads/adslite/instream/instream_ad.dart';
import 'package:huawei_ads/hms_ads.dart';
import 'package:huawei_ads/utils/channels.dart';

class InstreamAdLoader {
  late MethodChannel _channel;
  String adId;
  final Duration totalDuration;
  final int? maxCount;
  final Function(List<InstreamAd>)? onAdLoaded;
  final Function(int? errorCode)? onAdFailed;
  InstreamAdLoader({
    required this.adId,
    required this.totalDuration,
    this.maxCount,
    this.onAdLoaded,
    this.onAdFailed,
  }) {
    Ads.instance.channelInstream.invokeMethod(
      "initInstreamLoader",
      {
        "id": hashCode,
        "adId": adId,
        "totalDuration": totalDuration.inSeconds,
        "maxCount": maxCount,
      },
    );
    _channel = MethodChannel("$INSTREAM_METHOD_CHANNEL/LOADER/$hashCode");
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "onAdLoaded":
          List<int> ads = List<int>.from(call.arguments["ads"]);
          List<InstreamAd> instreamAds = [];
          ads.forEach((adId) {
            instreamAds.add(InstreamAd(id: adId));
          });
          onAdLoaded?.call(instreamAds);
          break;
        case "onAdFailed":
          onAdFailed?.call(call.arguments["error_code"]);
          break;
        default:
          throw UnimplementedError;
      }
      return;
    });
  }

  Future<bool?> loadAd({AdParam? adParam}) async {
    return await _channel.invokeMethod('loadAd', {
      "adParam": adParam?.toJson(),
    });
  }

  Future<bool?> isLoading() async {
    return await _channel.invokeMethod('isLoading');
  }
}
