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
import 'package:huawei_adsprime_example/pages/identifier/oaid_page.dart';
import 'package:huawei_adsprime_example/pages/installreferrer/install_referrer_page.dart';
import 'package:huawei_adsprime_example/pages/publisher/publisher_service_page.dart';
import 'package:huawei_adsprime_example/pages/vast_ad_page.dart';
import 'package:huawei_adsprime_example/utils/constants.dart';

class AdsMenuPage extends StatelessWidget {
  const AdsMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Huawei Ads Prime Plugin Demo',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ElevatedButton(
            child: const Text(
              'Publisher Service',
              style: Styles.menuButtonStyle,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) {
                    return const PublisherPage();
                  },
                ),
              );
            },
          ),
          ElevatedButton(
            child: const Text(
              'Identifier Service',
              style: Styles.menuButtonStyle,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) {
                    return const OaidPage();
                  },
                ),
              );
            },
          ),
          ElevatedButton(
            child: const Text(
              'Install Referrer Service',
              style: Styles.menuButtonStyle,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) {
                    return const InstallReferrerPage();
                  },
                ),
              );
            },
          ),
          ElevatedButton(
            child: const Text(
              'VAST Ads',
              style: Styles.menuButtonStyle,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) {
                    return const VastAdPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
