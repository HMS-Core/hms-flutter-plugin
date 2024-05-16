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

import 'package:flutter/material.dart';
import 'package:huawei_adsprime_example/pages/publisher/banner_ad_page.dart';
import 'package:huawei_adsprime_example/pages/publisher/banner_ad_platform_view_page.dart';
import 'package:huawei_adsprime_example/pages/publisher/consent_page.dart';
import 'package:huawei_adsprime_example/pages/publisher/instream_ad_page.dart';
import 'package:huawei_adsprime_example/pages/publisher/interstitial_ad_page.dart';
import 'package:huawei_adsprime_example/pages/publisher/native_ad_page.dart';
import 'package:huawei_adsprime_example/pages/publisher/reward_ad_page.dart';
import 'package:huawei_adsprime_example/pages/publisher/splash_ad_page.dart';
import 'package:huawei_adsprime_example/utils/constants.dart';

class PublisherPage extends StatelessWidget {
  const PublisherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Huawei Ads - Publisher',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              child: const Text(
                'Consent',
                style: Styles.menuButtonStyle,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) {
                      return const ConsentPage();
                    },
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text(
                'Banner Ads',
                style: Styles.menuButtonStyle,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) {
                      return const BannerAdPage();
                    },
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text(
                'Banner Ads - Platform View',
                style: Styles.menuButtonStyle,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) {
                      return const BannerAdPlatformViewPage();
                    },
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text(
                'Interstitial Ads',
                style: Styles.menuButtonStyle,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) {
                      return const InterstitialAdPage();
                    },
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text(
                'Reward Ads',
                style: Styles.menuButtonStyle,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) {
                      return const RewardAdPage();
                    },
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text(
                'Native Ads',
                style: Styles.menuButtonStyle,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) {
                      return const NativeAdPage();
                    },
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text(
                'Splash Ads',
                style: Styles.menuButtonStyle,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) {
                      return const SplashAdPage();
                    },
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text(
                'Instream Ads',
                style: Styles.menuButtonStyle,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) {
                      return const InstreamAdPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
