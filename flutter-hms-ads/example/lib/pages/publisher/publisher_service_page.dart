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
import 'package:huawei_ads_example/utils/constants.dart';

class PublisherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
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
            RaisedButton(
              child: Text(
                'Consent',
                style: Styles.menuButtonStyle,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.consent);
              },
            ),
            RaisedButton(
              child: Text(
                'Banner Ads',
                style: Styles.menuButtonStyle,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.bannerAd);
              },
            ),
            RaisedButton(
              child: Text(
                'Banner Ads - Platform View',
                style: Styles.menuButtonStyle,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.bannerAdPlatformView);
              },
            ),
            RaisedButton(
              child: Text(
                'Interstitial Ads',
                style: Styles.menuButtonStyle,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.interstitialAd);
              },
            ),
            RaisedButton(
              child: Text(
                'Reward Ads',
                style: Styles.menuButtonStyle,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.rewardAd);
              },
            ),
            RaisedButton(
              child: Text(
                'Native Ads',
                style: Styles.menuButtonStyle,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.nativeAd);
              },
            ),
            RaisedButton(
              child: Text(
                'Splash Ads',
                style: Styles.menuButtonStyle,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.splashAd);
              },
            ),
            RaisedButton(
              child: Text(
                'Instream Ads',
                style: Styles.menuButtonStyle,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.instreamAd);
              },
            ),
          ],
        ),
      ),
    );
  }
}
