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
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:huawei_ads/hms_ads_lib.dart';
import 'package:huawei_ads_example/pages/publisher/banner_ad_platform_view_page.dart';

import 'pages/ads_menu_page.dart';
import 'pages/publisher/publisher_service_page.dart';
import 'pages/publisher/consent_page.dart';
import 'pages/publisher/banner_ad_page.dart';
import 'pages/publisher/interstitial_ad_page.dart';
import 'pages/publisher/native_ad_page.dart';
import 'pages/publisher/reward_ad_page.dart';
import 'pages/publisher/splash_ad_page.dart';
import 'pages/publisher/instream_ad_page.dart';
import 'pages/identifier/oaid_page.dart';
import 'pages/installreferrer/install_referrer_page.dart';
import 'utils/constants.dart';

void main() => runApp(HmsAdsDemo());

class HmsAdsDemo extends StatelessWidget {
  Future<void> initHwAds() async {
    try {
      await HwAds.init();
    } catch (e) {
      print('EXCEPTION | $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    initHwAds();
    return MaterialApp(
      initialRoute: Routes.splashAd,
      routes: {
        '/': (context) => AdsMenuPage(),
        // publisher
        Routes.publisherService: (context) => PublisherPage(),
        Routes.consent: (context) => ConsentPage(),
        Routes.bannerAd: (context) => BannerAdPage(),
        Routes.bannerAdPlatformView: (context) => BannerAdPlatformViewPage(),
        Routes.interstitialAd: (context) => InterstitialAdPage(),
        Routes.rewardAd: (context) => RewardAdPage(),
        Routes.nativeAd: (context) => NativeAdPage(),
        Routes.splashAd: (context) => SplashAdPage(),
        Routes.instreamAd: (context) => InstreamAdPage(),
        // identifier
        Routes.identifierOaid: (context) => OaidPage(),
        // install referrer
        Routes.installReferrerService: (context) => InstallReferrerPage(),
      },
    );
  }
}
