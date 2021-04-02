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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_ads/adslite/ad_param.dart';
import 'package:huawei_ads/hms_ads.dart';
import 'package:huawei_ads/utils/view_types.dart';

import 'banner_ad_size.dart';

class BannerView extends StatelessWidget {
  final String adSlotId;
  final BannerAdSize size;
  final Color backgroundColor;
  final Duration refreshDuration;
  final bool loadOnStart;
  final AdParam adParam;

  final BannerViewController controller;

  const BannerView({
    Key key,
    @required this.adSlotId,
    this.size = BannerAdSize.s320x50,
    this.backgroundColor,
    this.loadOnStart = true,
    this.refreshDuration,
    this.controller,
    this.adParam,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget bannerWidget = SizedBox(
      width: adSizeDisplayWidth ?? MediaQuery.of(context).size.width,
      height: isSizeDynamic
          ? MediaQuery.of(context).size.height
          : adSizeDisplayHeight(MediaQuery.of(context).size.height),
      child: AndroidView(
        key: ObjectKey(size),
        viewType: BANNER_VIEW,
        onPlatformViewCreated: controller?._init,
        creationParamsCodec: StandardMessageCodec(),
        creationParams: {
          "adSlotId": adSlotId,
          "bannerSize": adSizeValue,
          "backgroundColor":
              backgroundColor != null ? colorHex(backgroundColor) : null,
          "refreshTime": refreshDuration?.inSeconds,
          "loadOnStart": controller != null ? loadOnStart : true,
          'adParam': adParam?.toJson() ?? {},
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

  bool get isSizeDynamic =>
      size == BannerAdSize.sSmart || size == BannerAdSize.sDynamic;

  String colorHex(Color color, {bool leadingHashSign = true}) =>
      '${leadingHashSign ? '#' : ''}'
      '${color.alpha.toRadixString(16).padLeft(2, '0')}'
      '${color.red.toRadixString(16).padLeft(2, '0')}'
      '${color.green.toRadixString(16).padLeft(2, '0')}'
      '${color.blue.toRadixString(16).padLeft(2, '0')}';

  String get adSizeValue {
    switch (size) {
      case BannerAdSize.sDynamic:
        return "size_dynamic";
        break;
      case BannerAdSize.sInvalid:
        return "size_invalid";
        break;
      case BannerAdSize.sSmart:
        return "size_smart";
        break;
      default:
        return "size_${size.width}_${size.height}";
    }
  }

  double get adSizeDisplayWidth {
    switch (size) {
      case BannerAdSize.sDynamic:
        return null;
        break;
      case BannerAdSize.sInvalid:
        return 0;
        break;
      case BannerAdSize.sSmart:
        return null;
        break;
      default:
        return size.width.toDouble();
    }
  }

  double adSizeDisplayHeight([double deviceHeight = 0]) {
    double dynamicHeight() =>
        deviceHeight > 720 ? 90 : deviceHeight > 400 ? 50 : 32;
    switch (size) {
      case BannerAdSize.sDynamic:
        return dynamicHeight();
        break;
      case BannerAdSize.sInvalid:
        return 0;
        break;
      case BannerAdSize.sSmart:
        return dynamicHeight();
        break;
      default:
        return size.height.toDouble();
    }
  }
}

class BannerViewController {
  MethodChannel _channel;
  final AdListener listener;

  final Function onBannerViewCreated;

  BannerViewController({
    this.listener,
    this.onBannerViewCreated,
  });

  void _init(int id) {
    onBannerViewCreated?.call(id);
    _channel = MethodChannel(
      "${BANNER_VIEW}_$id",
    );
    _channel.setMethodCallHandler((call) {
      switch (call.method) {
        case "onAdLoaded":
          listener?.call(AdEvent.loaded);
          break;
        case "onAdFailed":
          listener?.call(
            AdEvent.failed,
            errorCode: call.arguments["error_code"],
          );
          break;
        case "onAdOpened":
          listener?.call(AdEvent.opened);
          break;
        case "onAdClicked":
          listener?.call(AdEvent.clicked);
          break;
        case "onAdLeave":
          listener?.call(AdEvent.leave);
          break;
        case "onAdClosed":
          listener?.call(AdEvent.closed);
          break;
        default:
          throw UnimplementedError;
      }
      return;
    });
  }

  Future<bool> pause() async {
    return await _channel.invokeMethod('pause');
  }

  Future<bool> resume() async {
    return await _channel.invokeMethod('resume');
  }

  Future<bool> loadAd() async {
    return await _channel.invokeMethod('loadAd');
  }

  Future<bool> isLoading() async {
    return await _channel.invokeMethod('isLoading');
  }
}
