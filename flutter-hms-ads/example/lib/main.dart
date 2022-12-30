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

import 'package:flutter/material.dart';
import 'package:huawei_ads/huawei_ads.dart';
import 'package:huawei_ads_example/pages/ads_menu_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await HwAds.init();
    await VastSdkFactory.init(
      VastSdkConfiguration(isTest: true),
    );
    await VastSdkFactory.userAcceptAdLicense(true);
  } catch (e) {
    debugPrint('EXCEPTION | $e');
  }
  runApp(const HmsAdsDemo());
}

class HmsAdsDemo extends StatelessWidget {
  const HmsAdsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AdsMenuPage(),
    );
  }
}
