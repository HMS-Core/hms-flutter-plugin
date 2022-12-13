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

part of huawei_adsprime;

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
      'initInstreamLoader',
      <String, dynamic>{
        'id': hashCode,
        'adId': adId,
        'totalDuration': totalDuration.inSeconds,
        'maxCount': maxCount,
      },
    );
    _channel = MethodChannel('$_INSTREAM_METHOD_CHANNEL/LOADER/$hashCode');
    _channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'onAdLoaded':
          List<int> ads = List<int>.from(call.arguments['ads']);
          List<InstreamAd> instreamAds = <InstreamAd>[];
          for (int adId in ads) {
            instreamAds.add(InstreamAd(id: adId));
          }
          onAdLoaded?.call(instreamAds);
          break;
        case 'onAdFailed':
          onAdFailed?.call(call.arguments['error_code']);
          break;
        default:
          throw UnimplementedError;
      }
      return;
    });
  }

  Future<bool?> loadAd({AdParam? adParam}) async {
    return await _channel.invokeMethod(
      'loadAd',
      <String, dynamic>{
        'adParam': adParam?._toMap(),
      },
    );
  }

  Future<bool?> isLoading() async {
    return await _channel.invokeMethod(
      'isLoading',
    );
  }
}
