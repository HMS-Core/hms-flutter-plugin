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

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:huawei_adsprime/huawei_adsprime.dart';
import 'package:huawei_adsprime_example/utils/constants.dart';

class ConsentSettingsPage extends StatefulWidget {
  const ConsentSettingsPage({Key? key}) : super(key: key);

  @override
  State<ConsentSettingsPage> createState() => _ConsentSettingsPageState();
}

class _ConsentSettingsPageState extends State<ConsentSettingsPage> {
  static const String _testAdSlotId = 'testw6vs28auh3';
  final Consent consentInfo = Consent.instance;
  ConsentStatus _consentStatus = ConsentStatus.UNKNOWN;
  bool? _needConsent = false;
  bool _buttonEnabled = false;
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      await consentInfo.setConsentStatus(ConsentStatus.UNKNOWN);
      final String? testDeviceId = await consentInfo.getTestDeviceId();
      if (testDeviceId != null) {
        await consentInfo.addTestDeviceId(testDeviceId);
      }
      await consentInfo.setDebugNeedConsent(
        DebugNeedConsent.DEBUG_NEED_CONSENT,
      );
      consentInfo.requestConsentUpdate((
        ConsentUpdateEvent? event, {
        ConsentStatus? consentStatus,
        bool? isNeedConsent,
        List<AdProvider>? adProviders,
        String? description,
      }) {
        if (event == ConsentUpdateEvent.success) {
          _needConsent = isNeedConsent;
          final bool isUnknown = consentStatus == ConsentStatus.UNKNOWN;
          if (isNeedConsent!) {
            if (isUnknown) {
              List<Map<String, dynamic>> adMapList = <Map<String, dynamic>>[];
              for (AdProvider provider in adProviders ?? <AdProvider>[]) {
                adMapList.add(provider.toJson());
              }
              debugPrint('AdProviders: ${jsonEncode(adMapList)}');
              setState(() {
                _buttonEnabled = _needConsent! && isUnknown;
              });
            } else {
              loadBannerAd(consentStatus!);
            }
          } else {
            debugPrint('User consent is not neeeded');
            loadBannerAd(ConsentStatus.PERSONALIZED);
          }
          // Consent update failed
        } else {
          debugPrint('Consent status failed to update: ${description!}');
          loadBannerAd(ConsentStatus.NON_PERSONALIZED);
        }
      });
    } catch (e) {
      debugPrint('EXCEPTION | $e');
    }
    if (!mounted) {
      return;
    }
  }

  void loadBannerAd(ConsentStatus status) async {
    debugPrint('Consent Status: $status');
    RequestOptions? options = await HwAds.getRequestOptions();
    options ??= RequestOptions();

    options.tagForUnderAgeOfPromise = UnderAge.PROMISE_TRUE;
    options.nonPersonalizedAd = status.index;

    await HwAds.setRequestOptions(options);
    AdParam adParam = AdParam();
    BannerAd banner = BannerAd(
      adSlotId: _testAdSlotId,
      size: BannerAdSize.sSmart,
      adParam: adParam,
    );
    setState(() {
      _bannerAd = banner;
    });
    await _bannerAd!.loadAd();
    await _bannerAd!.show();
  }

  void setConsent(ConsentStatus status) async {
    bool? isUpdated = await (Consent.updateSharedPreferences(
      ConsentConstant.spConsentKey,
      status.index,
    ));
    if (isUpdated ?? false) {
      debugPrint('SharedPreferences updated');
      loadBannerAd(status);
      setState(() {
        _buttonEnabled = false;
        _consentStatus = status;
      });
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
          'Consent Settings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        _needConsent! && _consentStatus == ConsentStatus.UNKNOWN
                            ? consentExample
                            : !_needConsent!
                                ? 'User consent is not needed.'
                                : _consentStatus == ConsentStatus.PERSONALIZED
                                    ? 'User has agreed.'
                                    : 'User did not agree.',
                        style: Styles.textContentStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: _buttonEnabled
                              ? () => setConsent(ConsentStatus.NON_PERSONALIZED)
                              : null,
                          child: const SizedBox(
                            width: 90,
                            height: 40,
                            child: Center(
                              child: Text(
                                'SKIP',
                                style: Styles.adControlButtonStyle,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _buttonEnabled
                              ? () => setConsent(ConsentStatus.PERSONALIZED)
                              : null,
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                const Text(
                  'Consent Status',
                  style: Styles.headerTextStyle,
                ),
                const SizedBox(height: 10),
                Text(
                  _consentStatus == ConsentStatus.UNKNOWN
                      ? 'Consent unknown'
                      : _consentStatus == ConsentStatus.PERSONALIZED
                          ? 'Personalized ad'
                          : 'Non personalized ad',
                  style: Styles.textContentStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _bannerAd?.destroy();
    _bannerAd = null;
    super.dispose();
  }
}
