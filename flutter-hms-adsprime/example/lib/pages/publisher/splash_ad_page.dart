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
import 'package:huawei_adsprime/huawei_adsprime.dart';
import 'package:huawei_adsprime_example/pages/ads_menu_page.dart';

class SplashAdPage extends StatefulWidget {
  final bool? fromIndexPage;

  const SplashAdPage({
    Key? key,
    this.fromIndexPage,
  }) : super(key: key);

  @override
  State<SplashAdPage> createState() => _SplashAdPageState();
}

class _SplashAdPageState extends State<SplashAdPage> {
  final String _testAdSlotId = 'testq6zq98hecj';
  final AdParam _adParam = AdParam();
  late bool _fromIndexPage;
  static SplashAd? _splashAd;

  SplashAd createAd() {
    return SplashAd(
      adType: SplashAdType.above,
      ownerText: 'CUSTOM OWNER',
      footerText: 'CUSTOM FOOTER',
      logoBgResId: 'ic_background_launcher',
      logoResId: 'ic_launcher',
      loadListener: (SplashAdLoadEvent event, {int? errorCode}) {
        debugPrint('Splash Ad Load event : $event');
        if (event == SplashAdLoadEvent.dismissed) {
          if (_fromIndexPage) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) {
                  return const AdsMenuPage();
                },
              ),
              (_) => false,
            );
          } else {
            Navigator.pop(context);
          }
        }
      },
      displayListener: (SplashAdDisplayEvent event) {
        debugPrint('Splash Ad Display Event : $event');
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _fromIndexPage = widget.fromIndexPage ?? false;
  }

  @override
  Widget build(BuildContext context) {
    _splashAd ??= createAd()
      ..loadAd(
        adSlotId: _testAdSlotId,
        orientation: SplashAdOrientation.portrait,
        adParam: _adParam,
      );

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
