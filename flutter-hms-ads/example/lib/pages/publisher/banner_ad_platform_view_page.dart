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
import 'package:huawei_ads/hms_ads_lib.dart';

class BannerAdPlatformViewPage extends StatefulWidget {
  @override
  _BannerAdPlatformViewPageState createState() =>
      _BannerAdPlatformViewPageState();
}

class _BannerAdPlatformViewPageState extends State<BannerAdPlatformViewPage> {
  static final String _testAdSlotId = "testw6vs28auh3";
  final AdParam _adParam = AdParam();
  BannerViewController _bannerViewController;
  BannerAdSize bannerAdSize = BannerAdSize.s320x50;
  String logs = "\nDouble tap to clear the logs.\n\n";

  void changeSize(BannerAdSize size) {
    setState(() {
      bannerAdSize = size;
    });
  }

  void testBannerAdSizeMethods() async {
    print('isFullWidthSize : ${bannerAdSize.isFullWidthSize}');
    print('isDynamicSize : ${bannerAdSize.isDynamicSize}');
    print('isAutoHeightSize : ${bannerAdSize.isAutoHeightSize}');

    int widthPx = await bannerAdSize.getWidthPx;
    print('widthPx : $widthPx');

    int heightPx = await bannerAdSize.getHeightPx;
    print('heightPx : $heightPx');

    BannerAdSize currentDir =
        await BannerAdSize.getCurrentDirectionBannerSize(150);
    print(
        'getCurrentDirectionBannerSize - width ${currentDir.width} : height ${currentDir.height}');

    BannerAdSize landscape = await BannerAdSize.getLandscapeBannerSize(150);
    print(
        'getLandscapeBannerSize - width ${landscape.width} : height ${landscape.height}');

    BannerAdSize portrait = await BannerAdSize.getPortraitBannerSize(150);
    print(
        'getPortraitBannerSize - width ${portrait.width} : height ${portrait.height}');
  }

  @override
  void initState() {
    super.initState();
    testBannerAdSizeMethods();
    _bannerViewController = BannerViewController(
      listener: (AdEvent event, {int errorCode}) {
        print("Banner Ad event : $event");
        setState(() {
          logs = logs + "Banner Ad event : ${describeEnum(event)}\n";
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(
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
                margin: EdgeInsets.symmetric(horizontal: 60),
                child: SingleChildScrollView(
                  child: Container(
                    color: Color.fromRGBO(242, 242, 242, 1),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text('Size 320 x 50'),
                          trailing: Radio(
                            groupValue: bannerAdSize,
                            value: BannerAdSize.s320x50,
                            onChanged: changeSize,
                          ),
                        ),
                        ListTile(
                          title: Text('Size 320 x 100'),
                          trailing: Radio(
                            groupValue: bannerAdSize,
                            value: BannerAdSize.s320x100,
                            onChanged: changeSize,
                          ),
                        ),
                        ListTile(
                          title: Text('Size 300 x 250'),
                          trailing: Radio(
                            groupValue: bannerAdSize,
                            value: BannerAdSize.s300x250,
                            onChanged: changeSize,
                          ),
                        ),
                        ListTile(
                          title: Text('Size SMART'),
                          trailing: Radio(
                            groupValue: bannerAdSize,
                            value: BannerAdSize.sSmart,
                            onChanged: changeSize,
                          ),
                        ),
                        ListTile(
                          title: Text('Size 360 x 57'),
                          trailing: Radio(
                            groupValue: bannerAdSize,
                            value: BannerAdSize.s360x57,
                            onChanged: changeSize,
                          ),
                        ),
                        ListTile(
                          title: Text('Size 360 x 144'),
                          trailing: Radio(
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
              Container(
                height: 200,
                child: GestureDetector(
                  onDoubleTap: () => setState(() {
                    logs = "";
                  }),
                  child: SingleChildScrollView(
                    child: Text(logs),
                  ),
                ),
              ),
              BannerView(
                adSlotId: _testAdSlotId,
                size: bannerAdSize,
                adParam: _adParam,
                backgroundColor: Colors.blueGrey,
                refreshDuration: Duration(seconds: 30),
                controller: _bannerViewController,
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
