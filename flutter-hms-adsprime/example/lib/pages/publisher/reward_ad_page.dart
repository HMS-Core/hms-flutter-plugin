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

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:huawei_adsprime/huawei_adsprime.dart';
import 'package:huawei_adsprime_example/utils/constants.dart';

class RewardAdPage extends StatefulWidget {
  const RewardAdPage({Key? key}) : super(key: key);

  @override
  State<RewardAdPage> createState() => _RewardAdPageState();
}

class _RewardAdPageState extends State<RewardAdPage> {
  final String _testAdSlotId = 'testx9dtjwj8hp';
  final AdParam _adParam = AdParam();
  RewardAd? _rewardAd;
  int _score = 0;
  String logs = 'Double tap to clear the logs.\n\n';

  /* *
  * Alternatively, load status can be set when a RewardAdEvent.loaded
  * event is caught.
  * *
  * NOTE: A reward is not issued every time
  * */
  RewardAd createAd() {
    return RewardAd(
      listener: (RewardAdEvent? event, {Reward? reward, int? errorCode}) {
        debugPrint('RewardAd event : $event');
        setState(() {
          logs = '${logs}Reward Ad event : ${describeEnum(event!)}\n';
        });
        if (event == RewardAdEvent.rewarded) {
          debugPrint('Received reward : ${jsonEncode(reward!.toJson())}');
          setState(() {
            logs = '${logs}Received reward amount : ${reward.amount}\n';
            _score += reward.amount != 0 ? reward.amount! : 10;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Huawei Ads - Reward',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 50,
                      ),
                      child: Text('Your score : $_score'),
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text(
                    'Load Ad',
                    style: Styles.adControlButtonStyle,
                  ),
                  onPressed: () async {
                    await _rewardAd?.destroy();
                    _rewardAd = createAd();
                    await _rewardAd!.loadAd(
                      adSlotId: _testAdSlotId,
                      adParam: _adParam,
                    );
                    await _rewardAd!.show();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(top: 10),
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
    super.dispose();
    _rewardAd?.destroy();
    _rewardAd = null;
  }
}
