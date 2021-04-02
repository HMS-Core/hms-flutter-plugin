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
import 'package:huawei_ads/hms_ads_lib.dart';
import 'package:huawei_ads_example/utils/constants.dart';

class SplashAdPage extends StatefulWidget {
  final bool fromIndexPage;

  SplashAdPage({this.fromIndexPage});

  @override
  _SplashAdPageState createState() => _SplashAdPageState();
}

class _SplashAdPageState extends State<SplashAdPage> {
  final String _testAdSlotId = "testq6zq98hecj";
  final AdParam _adParam = AdParam();
  bool _fromIndexPage;
  static SplashAd _splashAd;

  SplashAd createAd() => SplashAd(
      adType: SplashAdType.above,
      ownerText: 'CUSTOM OWNER',
      footerText: 'CUSTOM FOOTER',
      logoBgResId: 'ic_background_launcher',
      logoResId: 'ic_launcher',
      loadListener: (SplashAdLoadEvent event, {int errorCode}) {
        print("Splash Ad Load event : $event");
        if (event == SplashAdLoadEvent.dismissed) {
          if (_fromIndexPage)
            // Empty the stack completely since the ad is displayed
            // when the app initially launched
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.menuPage, (_) => false);
          else
            // For when you navigate from the menu
            Navigator.pop(context);
        }
      },
      displayListener: (SplashAdDisplayEvent event) {
        print("Splash Ad Display Event : $event");
      });

  @override
  void initState() {
    super.initState();
    _fromIndexPage = widget.fromIndexPage ?? false;
  }

  @override
  Widget build(BuildContext context) {
    if (_splashAd == null) {
      _splashAd = createAd()
        ..loadAd(
            adSlotId: _testAdSlotId,
            orientation: SplashAdOrientation.portrait,
            adParam: _adParam);
    }
    return Container(
      color: Colors.white,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _splashAd?.destroy();
    _splashAd = null;
  }
}
