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
import 'package:flutter/material.dart';
import 'package:huawei_ads/hms_ads_lib.dart';

class InstreamAdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Huawei Ads - Instream',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: InstreamAdPageBody(),
    );
  }
}

class InstreamAdPageBody extends StatefulWidget {
  @override
  _InstreamAdPageBodyState createState() => _InstreamAdPageBodyState();
}

class _InstreamAdPageBodyState extends State<InstreamAdPageBody>
    with WidgetsBindingObserver {
  BuildContext context;
  InstreamAdView adView;
  InstreamAdViewController adViewController;
  InstreamAdLoader adLoader;
  List<InstreamAd> instreamAds = [];
  bool paused = false;
  bool muted = false;
  bool loaded = false;
  int countdownInSeconds = 0;
  int currentTotalTime = 0;
  String callToActionText;
  InstreamAd currentAd;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    adLoader = InstreamAdLoader(
      adId: 'testy3cglm3pj0',
      totalDuration: Duration(minutes: 1),
      maxCount: 8,
      onAdLoaded: (ads) async {
        instreamAds = ads;
        loaded = true;
        setState(() {});
        showSnackbar('onAdLoaded: length: ${ads.length}');
      },
      onAdFailed: (int errorCode) {
        showSnackbar('onAdFailed: errorCode:$errorCode');
      },
    );
    adViewController = InstreamAdViewController(
      onClick: () {
        showSnackbar('onClick');
      },
      onSegmentMediaChange: (instreamAd) {
        print('onSegmentMediaChange: ${instreamAd?.id}');
        currentAd = instreamAd;
        updateCallToAction(instreamAd);
        restartCountdown(instreamAd);
      },
      onMediaProgress: (per, playTime) {
        updateCountdown(playTime, per: per);
      },
      onMediaStart: (playTime) {
        showSnackbar('onMediaStart: $playTime');
      },
      onMediaPause: (playTime) {
        showSnackbar('onMediaPause: $playTime');
      },
      onMediaStop: (playTime) {
        showSnackbar('onMediaStop: $playTime');
      },
      onMediaCompletion: (playTime) {
        showSnackbar('onMediaCompletion: $playTime');
        adView = null;
        setState(() {});
      },
      onMediaError: (playTime, errorCode, extra) {
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

  void restartCountdown(InstreamAd ad) async {
    currentTotalTime = await ad?.getDuration();
    updateCountdown(0);
  }

  void updateCallToAction(InstreamAd ad) async {
    callToActionText = await ad?.getCallToAction();
    setState(() {});
  }

  void updateCountdown(int playTime, {int per}) {
    int oldCountdownInSeconds = countdownInSeconds;
    this.countdownInSeconds = (currentTotalTime - playTime) ~/ 1000;
    if (oldCountdownInSeconds != countdownInSeconds) {
      print('onMediaProgress: per: $per playTime $playTime');
      setState(() {});
    }
  }

  void showSnackbar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Column(
      children: [
        Container(
          color: Colors.black,
          // InstreamAdView needs to be bounded by specific height
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: adView == null
                ? Center(
                    child: Text(
                      'Your video content',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Stack(
                    children: [
                      adView,
                      InstreamAdViewElements(
                        countdown: '${countdownInSeconds ?? ''}s',
                        callToActionText: '${callToActionText ?? ''}',
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
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  child: Text(loaded ? 'LOADED' : 'LOAD AD'),
                  onPressed: () async {
                    bool loadAd = await adLoader.loadAd();
                    print('loadAd: $loadAd');
                  },
                ),
                RaisedButton(
                  child: Text('REGISTER'),
                  onPressed: () async {
                    if (instreamAds.isEmpty) {
                      print('empty loaded ads');
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
              children: [
                RaisedButton(
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
                RaisedButton(
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
          ],
        )
      ],
    );
  }
}
