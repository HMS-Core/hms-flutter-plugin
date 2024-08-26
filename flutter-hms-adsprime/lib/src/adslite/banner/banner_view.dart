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

part of '../../../huawei_adsprime.dart';

class BannerView extends StatelessWidget {
  /// Ad slot ID.
  final String adSlotId;

  /// Size of a banner ad. (The default value is [s320x50] in BannerAdSize.)
  final BannerAdSize size;

  /// Background color of a banner ad.
  final Color? backgroundColor;

  /// Refresh duration of a banner ad.
  final Duration? refreshDuration;

  /// Indicates whether a banner should be loaded after Platform View creation.
  ///
  /// (The default value is `true`. If there is no [BannerViewController] specified, this value is ignored and overriden to `true`.)
  final bool loadOnStart;

  /// Ad parameters.
  final AdParam? adParam;

  /// Controller for listening ad events and operate functions over a banner ad.
  final BannerViewController? controller;

  const BannerView({
    Key? key,
    required this.adSlotId,
    this.size = BannerAdSize.s320x50,
    this.backgroundColor,
    this.loadOnStart = true,
    this.refreshDuration,
    this.controller,
    this.adParam,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget bannerWidget = SizedBox(
      width: adSizeDisplayWidth ?? MediaQuery.of(context).size.width,
      height: isSizeDynamic
          ? MediaQuery.of(context).size.height
          : adSizeDisplayHeight(MediaQuery.of(context).size.height),
      child: AndroidView(
        key: ObjectKey(size),
        viewType: _BANNER_VIEW,
        onPlatformViewCreated: controller?._init,
        creationParamsCodec: const StandardMessageCodec(),
        creationParams: <String, dynamic>{
          'adSlotId': adSlotId,
          'bannerSize': adSizeValue,
          'backgroundColor':
              backgroundColor != null ? colorHex(backgroundColor!) : null,
          'refreshTime': refreshDuration?.inSeconds,
          'loadOnStart': controller != null ? loadOnStart : true,
          'adParam': adParam?._toMap() ?? <String, dynamic>{},
        },
      ),
    );
    if (!isSizeDynamic) {
      return bannerWidget;
    }
    return SizedBox(
      height: adSizeDisplayHeight(MediaQuery.of(context).size.height),
      width: adSizeDisplayWidth ?? MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: bannerWidget,
      ),
    );
  }

  bool get isSizeDynamic {
    return size == BannerAdSize.sSmart ||
        size == BannerAdSize.sDynamic ||
        size == BannerAdSize.sAdvanced;
  }

  String colorHex(
    Color color, {
    bool leadingHashSign = true,
  }) {
    return '${leadingHashSign ? '#' : ''}'
        '${color.alpha.toRadixString(16).padLeft(2, '0')}'
        '${color.red.toRadixString(16).padLeft(2, '0')}'
        '${color.green.toRadixString(16).padLeft(2, '0')}'
        '${color.blue.toRadixString(16).padLeft(2, '0')}';
  }

  String get adSizeValue {
    switch (size) {
      case BannerAdSize.sDynamic:
        return 'size_dynamic';
      case BannerAdSize.sInvalid:
        return 'size_invalid';
      case BannerAdSize.sAdvanced:
        return 'size_advanced';
      case BannerAdSize.sSmart:
        return 'size_smart';
      default:
        return 'size_${size.width}_${size.height}';
    }
  }

  double? get adSizeDisplayWidth {
    switch (size) {
      case BannerAdSize.sDynamic:
      case BannerAdSize.sAdvanced:
      case BannerAdSize.sSmart:
        return null;
      case BannerAdSize.sInvalid:
        return 0;
      default:
        return size.width.toDouble();
    }
  }

  double adSizeDisplayHeight([double deviceHeight = 0]) {
    switch (size) {
      case BannerAdSize.sDynamic:
      case BannerAdSize.sAdvanced:
      case BannerAdSize.sSmart:
        return deviceHeight > 720
            ? 90
            : deviceHeight > 400
                ? 50
                : 32;
      case BannerAdSize.sInvalid:
        return 0;
      default:
        return size.height.toDouble();
    }
  }
}

class BannerViewController {
  late MethodChannel _channel;

  /// Listener for ad events.
  final AdListener? listener;

  /// Called when [BannerView] is created.
  final Function? onBannerViewCreated;

  BannerViewController({
    this.listener,
    this.onBannerViewCreated,
  });

  void _init(int id) {
    onBannerViewCreated?.call(id);
    _channel = MethodChannel('${_BANNER_VIEW}_$id');
    _channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'onAdLoaded':
          listener?.call(AdEvent.loaded);
          break;
        case 'onAdFailed':
          listener?.call(
            AdEvent.failed,
            errorCode: call.arguments['error_code'],
          );
          break;
        case 'onAdOpened':
          listener?.call(AdEvent.opened);
          break;
        case 'onAdClicked':
          listener?.call(AdEvent.clicked);
          break;
        case 'onAdLeave':
          listener?.call(AdEvent.leave);
          break;
        case 'onAdClosed':
          listener?.call(AdEvent.closed);
          break;
        default:
          throw UnimplementedError;
      }
      return;
    });
  }

  /// Returns real-time bidding data.
  Future<BiddingInfo?> getBiddingInfo() async {
    return BiddingInfo.fromJson(await Ads.instance.channelBanner.invokeMethod(
      'getBiddingInfo',
    ));
  }

  /// Pauses a banner ad.
  Future<bool?> pause() async {
    return await _channel.invokeMethod(
      'pause',
    );
  }

  /// Resumes a banner ad.
  Future<bool?> resume() async {
    return await _channel.invokeMethod(
      'resume',
    );
  }

  /// Loads a banner ad when [loadOnStart] is set to `false` on [BannerView].
  Future<bool?> loadAd() async {
    return await _channel.invokeMethod(
      'loadAd',
    );
  }

  /// Loading status of a banner ad.
  Future<bool?> isLoading() async {
    return await _channel.invokeMethod(
      'isLoading',
    );
  }
}
