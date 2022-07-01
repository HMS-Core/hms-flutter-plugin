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
import 'package:huawei_adsprime/huawei_adsprime.dart';
import 'package:huawei_adsprime_example/utils/constants.dart';

class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({Key? key}) : super(key: key);

  @override
  _PrivacySettingsPage createState() => _PrivacySettingsPage();
}

class _PrivacySettingsPage extends State<PrivacySettingsPage> {
  void setConsent(NonPersonalizedAd privacyValue) async {
    debugPrint('User agreed');
    bool? isUpdated = await (Consent.updateSharedPreferences(
        ConsentConstant.spConsentKey, privacyValue.value));
    if (isUpdated ?? false) {
      debugPrint('SharedPreferences updated');
    } else {
      debugPrint('ERROR: Update shared preferences failed.');
    }
    Navigator.pop(context);
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
                    child: const Text(
                      privacyExample,
                      style: Styles.textContentStyle,
                    ),
                    padding: const EdgeInsets.all(20),
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
                          child: Center(
                            child: Text(
                              'CANCEL',
                              style: Styles.adControlButtonStyle,
                            ),
                          ),
                          width: 90,
                          height: 40,
                        ),
                        onPressed: () {
                          debugPrint('User did not agree.');
                          Navigator.pop(context);
                        }),
                    ElevatedButton(
                        child: const SizedBox(
                          child: Center(
                            child: Text(
                              'AGREE',
                              style: Styles.adControlButtonStyle,
                            ),
                          ),
                          width: 90,
                          height: 40,
                        ),
                        onPressed: () {
                          setConsent(NonPersonalizedAd.ALLOW_NON_PERSONALIZED);
                        }),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
