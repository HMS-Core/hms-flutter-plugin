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
import 'package:huawei_adsprime/huawei_adsprime.dart';

class VastAdPage extends StatelessWidget {
  const VastAdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Huawei Ads - VAST',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: const VastAdPageBody(),
    );
  }
}

class VastAdPageBody extends StatefulWidget {
  const VastAdPageBody({Key? key}) : super(key: key);

  @override
  State<VastAdPageBody> createState() => _VastAdPageBodyState();
}

class _VastAdPageBodyState extends State<VastAdPageBody>
    with WidgetsBindingObserver {
  VastAdViewController? _playerController;
  String logs = 'Double tap to clear the logs.\n\n';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      _playerController?.resume();
    } else if (state == AppLifecycleState.inactive) {
      _playerController?.pause();
    } else if (state == AppLifecycleState.paused) {
      _playerController?.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.40,
              child: VastAdView(
                linearAdSlot: LinearAdSlot(
                  slotId: 'testy3cglm3pj0',
                  maxAdPods: 2,
                  totalDuration: 60,
                  requestOptions: VastRequestOptions(),
                ),
                onViewCreated: (VastAdViewController controller) async {
                  _playerController = controller;
                },
                eventListener: VastAdEventListener(
                  onPlayStateChanged: (int i) {
                    setState(() => logs += 'onPlayStateChanged: $i\n');
                  },
                  onVolumeChanged: (double v) {
                    setState(() => logs += 'onVolumeChanged: $v\n');
                  },
                  onScreenViewChanged: (int i) {
                    setState(() => logs += 'onScreenViewChanged: $i\n');
                  },
                  onProgressChanged: (int l, int l1, int l2) {
                    setState(() => logs += 'onProgressChanged: $l, $l1, $l2\n');
                  },
                  onSuccess: (int i) {
                    setState(() => logs += 'onSuccess: $i\n');
                  },
                  onFailed: (int i) {
                    setState(() => logs += 'onFailed: $i\n');
                  },
                  playAdReady: () {
                    setState(() => logs += 'playAdReady\n');
                  },
                  playAdFinish: () {
                    setState(() => logs += 'playAdFinish\n');
                  },
                  playAdError: (int errorCode) {
                    setState(() => logs += 'playAdError: $errorCode\n');
                  },
                  onBufferStart: () {
                    setState(() => logs += 'onBufferStart\n');
                  },
                  onBufferEnd: () {
                    setState(() => logs += 'onBufferEnd\n');
                  },
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('loadLinearAd'),
              onPressed: () async {
                bool? result = await _playerController?.loadLinearAd();
                setState(() => logs += 'loadLinearAd: $result\n');
              },
            ),
            ElevatedButton(
              child: const Text('playLinearAds'),
              onPressed: () async {
                await _playerController?.playLinearAds();
              },
            ),
            ElevatedButton(
              child: const Text('startLinearAd'),
              onPressed: () async {
                await _playerController?.startLinearAd();
              },
            ),
            ElevatedButton(
              child: const Text('startAdPods'),
              onPressed: () async {
                await _playerController?.startAdPods();
              },
            ),
            const Divider(),
            ElevatedButton(
              child: const Text('resume'),
              onPressed: () async {
                await _playerController?.resume();
              },
            ),
            ElevatedButton(
              child: const Text('pause'),
              onPressed: () async {
                await _playerController?.pause();
              },
            ),
            ElevatedButton(
              child: const Text('release'),
              onPressed: () async {
                await _playerController?.release();
              },
            ),
          ],
        ),
        const Divider(),
        Flexible(
          child: Center(
            child: GestureDetector(
              onDoubleTap: () {
                setState(() => logs = '');
              },
              child: SingleChildScrollView(
                child: Text(logs),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
