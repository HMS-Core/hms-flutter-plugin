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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:huawei_ads/huawei_ads.dart';

class BannerAdPlatformViewPage extends StatefulWidget {
  const BannerAdPlatformViewPage({Key? key}) : super(key: key);

  @override
  State<BannerAdPlatformViewPage> createState() =>
      _BannerAdPlatformViewPageState();
}

class _BannerAdPlatformViewPageState extends State<BannerAdPlatformViewPage> {
  static const String _testAdSlotId = 'testw6vs28auh3';
  final AdParam _adParam = AdParam();
  BannerViewController? _bannerViewController;
  BannerAdSize? bannerAdSize = BannerAdSize.s320x50;
  String logs = '\nDouble tap to clear the logs.\n\n';

  void changeSize(BannerAdSize? size) {
    setState(() {
      bannerAdSize = size;
    });
  }

  void testBannerAdSizeMethods() async {
    debugPrint('isFullWidthSize : ${bannerAdSize!.isFullWidthSize}');
    debugPrint('isDynamicSize : ${bannerAdSize!.isDynamicSize}');
    debugPrint('isAutoHeightSize : ${bannerAdSize!.isAutoHeightSize}');

    int? widthPx = await bannerAdSize!.getWidthPx;
    debugPrint('widthPx : $widthPx');

    int? heightPx = await bannerAdSize!.getHeightPx;
    debugPrint('heightPx : $heightPx');

    BannerAdSize currentDir =
        await BannerAdSize.getCurrentDirectionBannerSize(150);
    debugPrint(
      'getCurrentDirectionBannerSize - width ${currentDir.width} : height ${currentDir.height}',
    );

    BannerAdSize landscape = await BannerAdSize.getLandscapeBannerSize(150);
    debugPrint(
      'getLandscapeBannerSize - width ${landscape.width} : height ${landscape.height}',
    );

    BannerAdSize portrait = await BannerAdSize.getPortraitBannerSize(150);
    debugPrint(
      'getPortraitBannerSize - width ${portrait.width} : height ${portrait.height}',
    );
  }

  @override
  void initState() {
    super.initState();
    testBannerAdSizeMethods();
    _bannerViewController = BannerViewController(
      listener: (AdEvent event, {int? errorCode}) {
        debugPrint('Banner Ad event : $event');
        setState(() {
          logs = '${logs}Banner Ad event : ${describeEnum(event)}\n';
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Huawei Ads - Banner',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 60),
              child: SingleChildScrollView(
                child: Container(
                  color: const Color.fromRGBO(242, 242, 242, 1),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text('Size 320 x 50'),
                        trailing: Radio<BannerAdSize>(
                          groupValue: bannerAdSize,
                          value: BannerAdSize.s320x50,
                          onChanged: changeSize,
                        ),
                      ),
                      ListTile(
                        title: const Text('Size 320 x 100'),
                        trailing: Radio<BannerAdSize>(
                          groupValue: bannerAdSize,
                          value: BannerAdSize.s320x100,
                          onChanged: changeSize,
                        ),
                      ),
                      ListTile(
                        title: const Text('Size 300 x 250'),
                        trailing: Radio<BannerAdSize>(
                          groupValue: bannerAdSize,
                          value: BannerAdSize.s300x250,
                          onChanged: changeSize,
                        ),
                      ),
                      ListTile(
                        title: const Text('Size SMART'),
                        trailing: Radio<BannerAdSize>(
                          groupValue: bannerAdSize,
                          value: BannerAdSize.sSmart,
                          onChanged: changeSize,
                        ),
                      ),
                      ListTile(
                        title: const Text('Size ADVANCED'),
                        trailing: Radio<BannerAdSize>(
                          groupValue: bannerAdSize,
                          value: BannerAdSize.sAdvanced,
                          onChanged: changeSize,
                        ),
                      ),
                      ListTile(
                        title: const Text('Size 360 x 57'),
                        trailing: Radio<BannerAdSize>(
                          groupValue: bannerAdSize,
                          value: BannerAdSize.s360x57,
                          onChanged: changeSize,
                        ),
                      ),
                      ListTile(
                        title: const Text('Size 360 x 144'),
                        trailing: Radio<BannerAdSize>(
                          groupValue: bannerAdSize,
                          value: BannerAdSize.s360x144,
                          onChanged: changeSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: GestureDetector(
                onDoubleTap: () => setState(() {
                  logs = '';
                }),
                child: SingleChildScrollView(
                  child: Text(logs),
                ),
              ),
            ),
            BannerView(
              adSlotId: _testAdSlotId,
              size: bannerAdSize!,
              adParam: _adParam,
              backgroundColor: Colors.blueGrey,
              refreshDuration: const Duration(seconds: 30),
              controller: _bannerViewController,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
