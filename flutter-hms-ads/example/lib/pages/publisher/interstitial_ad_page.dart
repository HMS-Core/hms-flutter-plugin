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
import 'package:huawei_ads_example/utils/constants.dart';

class InterstitialAdPage extends StatefulWidget {
  @override
  _InterstitialAdPageState createState() => _InterstitialAdPageState();
}

class _InterstitialAdPageState extends State<InterstitialAdPage> {
  static final String _imageTestAdSlotId = "teste9ih9j0rc3"; // Image ad
  static final String _videoTestAdSlotId = "testb4znbuh3n2"; // Video ad
  final AdParam _adParam = AdParam();
  String adSlotId = _imageTestAdSlotId;
  InterstitialAd _interstitialAd;
  String logs = "Double tap to clear the logs.\n\n";

  void changeSlotId(String slotId) {
    setState(() {
      _interstitialAd = null;
      adSlotId = slotId;
    });
  }

  InterstitialAd createAd() {
    return InterstitialAd(
      adSlotId: adSlotId,
      adParam: _adParam,
      listener: (AdEvent event, {int errorCode}) {
        print("Interstitial Ad event : $event");
        setState(() {
          logs = logs + "Interstitial Ad event : ${describeEnum(event)}\n";
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
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text('Interstitial Image'),
                          trailing: Radio(
                            groupValue: adSlotId,
                            value: _imageTestAdSlotId,
                            onChanged: changeSlotId,
                          ),
                        ),
                        ListTile(
                          title: Text('Interstitial Video'),
                          trailing: Radio(
                            groupValue: adSlotId,
                            value: _videoTestAdSlotId,
                            onChanged: changeSlotId,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text(
                      'Load Ad',
                      style: Styles.adControlButtonStyle,
                    ),
                    onPressed: () {
                      _interstitialAd?.destroy();
                      _interstitialAd = createAd()
                        ..loadAd()
                        ..show();
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                height: 250,
                child: GestureDetector(
                  onDoubleTap: () => setState(() {
                    logs = "";
                  }),
                  child: SingleChildScrollView(
                    child: Text(logs),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.destroy();
  }
}
