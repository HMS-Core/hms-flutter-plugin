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
import 'package:huawei_ads/huawei_ads.dart';
import 'package:huawei_ads_example/utils/constants.dart';

class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({Key? key}) : super(key: key);

  @override
  State<PrivacySettingsPage> createState() => _PrivacySettingsPage();
}

class _PrivacySettingsPage extends State<PrivacySettingsPage> {
  Future<void> setConsent(NonPersonalizedAd privacyValue) async {
    debugPrint('User agreed');
    final bool? isUpdated = await Consent.updateSharedPreferences(
      ConsentConstant.spConsentKey,
      privacyValue.value,
    );
    if (isUpdated ?? false) {
      debugPrint('SharedPreferences updated');
    } else {
      debugPrint('ERROR: Update shared preferences failed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Privacy Settings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    privacyExample,
                    style: Styles.textContentStyle,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: const SizedBox(
                      width: 90,
                      height: 40,
                      child: Center(
                        child: Text(
                          'CANCEL',
                          style: Styles.adControlButtonStyle,
                        ),
                      ),
                    ),
                    onPressed: () {
                      debugPrint('User did not agree.');
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    child: const SizedBox(
                      width: 90,
                      height: 40,
                      child: Center(
                        child: Text(
                          'AGREE',
                          style: Styles.adControlButtonStyle,
                        ),
                      ),
                    ),
                    onPressed: () {
                      setConsent(NonPersonalizedAd.ALLOW_NON_PERSONALIZED).then(
                        (_) => Navigator.pop(context),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
