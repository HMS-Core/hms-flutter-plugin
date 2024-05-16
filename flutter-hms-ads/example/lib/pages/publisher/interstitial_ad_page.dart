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
import 'package:huawei_ads_example/utils/constants.dart';

class InterstitialAdPage extends StatefulWidget {
  const InterstitialAdPage({Key? key}) : super(key: key);

  @override
  State<InterstitialAdPage> createState() => _InterstitialAdPageState();
}

class _InterstitialAdPageState extends State<InterstitialAdPage> {
  static const String _imageTestAdSlotId = 'teste9ih9j0rc3'; // Image ad
  static const String _videoTestAdSlotId = 'testb4znbuh3n2'; // Video ad
  final AdParam _adParam = AdParam();
  String? adSlotId = _imageTestAdSlotId;
  InterstitialAd? _interstitialAd;
  String logs = 'Double tap to clear the logs.\n\n';

  void changeSlotId(String? slotId) {
    setState(() {
      _interstitialAd = null;
      adSlotId = slotId;
    });
  }

  InterstitialAd createAd() {
    return InterstitialAd(
      adSlotId: adSlotId!,
      adParam: _adParam,
      listener: (AdEvent event, {int? errorCode}) {
        debugPrint('Interstitial Ad event : $event');
        setState(() {
          logs = '${logs}Interstitial Ad event : ${describeEnum(event)}\n';
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
          'Huawei Ads - Interstitial',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: const Text('Interstitial Image'),
                          trailing: Radio<String>(
                            groupValue: adSlotId,
                            value: _imageTestAdSlotId,
                            onChanged: changeSlotId,
                          ),
                        ),
                        ListTile(
                          title: const Text('Interstitial Video'),
                          trailing: Radio<String>(
                            groupValue: adSlotId,
                            value: _videoTestAdSlotId,
                            onChanged: changeSlotId,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text(
                    'Load Ad',
                    style: Styles.adControlButtonStyle,
                  ),
                  onPressed: () async {
                    await _interstitialAd?.destroy();
                    _interstitialAd = createAd();
                    await _interstitialAd!.loadAd();
                    await _interstitialAd!.show();
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                height: 250,
                child: GestureDetector(
                  onDoubleTap: () => setState(() => logs = ''),
                  child: SingleChildScrollView(
                    child: Text(logs),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _interstitialAd?.destroy();
    super.dispose();
  }
}
