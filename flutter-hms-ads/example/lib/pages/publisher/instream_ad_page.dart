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

class InstreamAdPage extends StatelessWidget {
  const InstreamAdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Huawei Ads - Instream',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: const InstreamAdPageBody(),
    );
  }
}

class InstreamAdPageBody extends StatefulWidget {
  const InstreamAdPageBody({Key? key}) : super(key: key);

  @override
  State<InstreamAdPageBody> createState() => _InstreamAdPageBodyState();
}

class _InstreamAdPageBodyState extends State<InstreamAdPageBody>
    with WidgetsBindingObserver {
  late BuildContext context;
  InstreamAdView? adView;
  InstreamAdViewController? adViewController;
  late InstreamAdLoader adLoader;
  List<InstreamAd> instreamAds = <InstreamAd>[];
  bool paused = false;
  bool muted = false;
  bool loaded = false;
  int countdownInSeconds = 0;
  int? currentTotalTime = 0;
  String? callToActionText;
  InstreamAd? currentAd;
  String? transparencyTplUrl;
  bool? transparencyOpen;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    adLoader = InstreamAdLoader(
      adId: 'testy3cglm3pj0',
      totalDuration: const Duration(minutes: 1),
      maxCount: 8,
      onAdLoaded: (List<InstreamAd> ads) async {
        instreamAds = ads;
        loaded = true;
        setState(() {});
        showSnackbar('onAdLoaded: length: ${ads.length}');
      },
      onAdFailed: (int? errorCode) {
        showSnackbar('onAdFailed: errorCode:$errorCode');
      },
    );

    adViewController = InstreamAdViewController(
      onInstreamAdViewCreated: (int adId) {
        resume();
      },
      onClick: () {
        showSnackbar('onClick');
      },
      onSegmentMediaChange: (InstreamAd? instreamAd) {
        debugPrint('onSegmentMediaChange: ${instreamAd?.id}');
        currentAd = instreamAd;
        updateCallToAction(instreamAd);
        restartCountdown(instreamAd);
      },
      onMediaProgress: (int? per, int? playTime) {
        updateCountdown(playTime!, per: per);
      },
      onMediaStart: (int? playTime) {
        showSnackbar('onMediaStart: $playTime');
      },
      onMediaPause: (int? playTime) {
        showSnackbar('onMediaPause: $playTime');
      },
      onMediaStop: (int? playTime) {
        showSnackbar('onMediaStop: $playTime');
      },
      onMediaCompletion: (int? playTime) {
        showSnackbar('onMediaCompletion: $playTime');
        adView = null;
        setState(() {});
      },
      onMediaError: (int? playTime, int? errorCode, int? extra) {
        showSnackbar(
          'onMediaError: playTimte: $playTime errorCode: $errorCode extra: $extra',
        );
      },
      onMute: () {
        showSnackbar('onMute');
      },
      onUnMute: () {
        showSnackbar('onUnMute');
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      resume();
    } else if (state == AppLifecycleState.inactive) {
      pause();
    } else if (state == AppLifecycleState.paused) {
      pause();
    }
  }

  void pause() async {
    await adViewController?.pause();
    paused = true;
    setState(() {});
  }

  void resume() async {
    await adViewController?.play();
    paused = false;
    setState(() {});
  }

  void restartCountdown(InstreamAd? ad) async {
    currentTotalTime = await ad?.getDuration();
    updateCountdown(0);
  }

  void updateCallToAction(InstreamAd? ad) async {
    callToActionText = await ad?.getCallToAction();
    setState(() {});
  }

  void updateCountdown(int playTime, {int? per}) {
    int oldCountdownInSeconds = countdownInSeconds;
    countdownInSeconds = (currentTotalTime! - playTime) ~/ 1000;
    if (oldCountdownInSeconds != countdownInSeconds) {
      debugPrint('onMediaProgress: per: $per playTime $playTime');
      setState(() {});
    }
  }

  void showSnackbar(String text) {
    final SnackBar snackBar = SnackBar(
      content: Text(text),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showTransparencyDialog() async {
    await adViewController?.showTransparencyDialog(location: [1, 2]);
    setState(() {});
  }

  void hideTransparencyDialog() async {
    await adViewController?.hideTransparencyDialog();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Column(
      children: <Widget>[
        Container(
          color: Colors.black,
          // InstreamAdView needs to be bounded by specific height
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: adView == null
                ? const Center(
                    child: Text(
                      'Your video content',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Stack(
                    children: <Widget>[
                      adView!,
                      InstreamAdViewElements(
                        countdown: '${countdownInSeconds}s',
                        callToActionText: callToActionText ?? '',
                        onSkip: () async {
                          await adViewController?.stop();
                          adView = null;
                          setState(() {});
                        },
                        onInfo: () async {
                          pause();
                          currentAd?.gotoWhyThisAdPage();
                        },
                      ),
                    ],
                  ),
          ),
        ),
        Column(
          children: <Widget>[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  child: Text(loaded ? 'LOADED' : 'LOAD AD'),
                  onPressed: () async {
                    bool? loadAd = await adLoader.loadAd();
                    debugPrint('loadAd: $loadAd');
                  },
                ),
                ElevatedButton(
                  child: const Text('REGISTER'),
                  onPressed: () async {
                    if (instreamAds.isEmpty) {
                      debugPrint('empty loaded ads');
                      return;
                    }
                    adView = InstreamAdView(
                      instreamAds: instreamAds,
                      controller: adViewController,
                    );
                    loaded = false;
                    setState(() {});
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  child: Text(muted ? 'UNMUTE' : 'MUTE'),
                  onPressed: () async {
                    if (muted) {
                      await adViewController?.unmute();
                      muted = false;
                    } else {
                      await adViewController?.mute();
                      muted = true;
                    }
                    setState(() {});
                  },
                ),
                ElevatedButton(
                  child: Text(paused ? 'PLAY' : 'PAUSE'),
                  onPressed: () async {
                    if (paused) {
                      resume();
                    } else {
                      pause();
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('Show Transparency'),
                  onPressed: () async {
                    showTransparencyDialog();
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  child: Text('Hide Transparency'),
                  onPressed: () async {
                    hideTransparencyDialog();
                  },
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
