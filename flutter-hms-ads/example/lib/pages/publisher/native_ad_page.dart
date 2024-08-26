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

class NativeAdPage extends StatefulWidget {
  const NativeAdPage({Key? key}) : super(key: key);

  @override
  State<NativeAdPage> createState() => _NativeAdPageState();
}

class _NativeAdPageState extends State<NativeAdPage> {
  static const String _imageTestAdSlotId = 'testu7m3hc4gvm'; // Image
  static const String _videoTestAdSlotId = 'testy63txaom86'; // Video ad
  static const String _appDownloadTestAdSlotId = 'testy63txaom86';
  String logs = 'Double tap to clear the logs.\n\n';

  NativeAdController createVideoAdController() {
    NativeAdController controller = NativeAdController(
      adParam: AdParam(tMax: 500).addBiddingParamMap(
        _videoTestAdSlotId,
        BiddingParam(),
      ),
      adConfiguration: NativeAdConfiguration(
        configuration: VideoConfiguration(
          startMuted: true,
          autoPlayNetwork: AutoPlayNetwork.bothWifiAndData,
        ),
      ),
    );

    controller.listener = (AdEvent event, {int? errorCode}) {
      if (event == AdEvent.loaded) {
        testNative(controller);
      }
    };
    return controller;
  }

  Future<void> getBiddingInfo(NativeAdController controller) async {
    BiddingInfo? biddingInfo = await controller.getBiddingInfo();
    debugPrint('getBiddingInfo : ${biddingInfo.toString()}');
  }

  void testNative(NativeAdController controller) async {
    VideoOperator? operator = await (controller.getVideoOperator());
    operator?.setVideoLifecycleListener =
        (VideoLifecycleEvent event, {bool? isMuted}) {
      debugPrint('VideoLifeCycle event : $event');
      setState(() {
        logs = '${logs}VideoLifeCycle event : ${describeEnum(event)}\n';
      });
    };
    bool? hasVideo = await operator?.hasVideo();
    debugPrint('Operator has video : $hasVideo');

    String? title = await controller.getTitle();
    debugPrint('Ad Title : $title');

    String? callToAction = await controller.getCallToAction();
    debugPrint('Ad action : $callToAction');

    String? source = await controller.getAdSource();
    debugPrint('Ad source : $source');

    String? getAdSign = await controller.getAdSign();
    debugPrint('Ad sign : $getAdSign');

    String? whyThisAd = await controller.getWhyThisAd();
    debugPrint('Why this ad : $whyThisAd');

    String? uniqueId = await controller.getUniqueId();
    debugPrint('uniqueId : $uniqueId');

    String? transparencyTplUrl = await controller.transparencyTplUrl();
    debugPrint('transparencyTplUrl : $transparencyTplUrl');

    bool? isTransparencyOpen = await controller.isTransparencyOpen();
    debugPrint('isTransparencyOpen : $isTransparencyOpen');

    PromoteInfo? promoteInfo = await controller.getPromoteInfo();
    debugPrint('getPromoteInfo : ${promoteInfo.toString()}');

    AppInfo? appInfo = await controller.getAppInfo();
    debugPrint('getAppInfo: ${appInfo.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Huawei Ads - Native',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Container(
                    //   padding: const EdgeInsets.symmetric(vertical: 20),
                    //   color: Colors.pinkAccent,
                    //   child: const Center(
                    //     child: Text(
                    //       'My Ad',
                    //       style: Styles.headerTextStyle,
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   color: Colors.blueAccent,
                    //   height: 300,
                    //   margin: const EdgeInsets.only(bottom: 20.0),
                    //   child: NativeAd(
                    //     adSlotId: _imageTestAdSlotId,
                    //     controller: defaultController(),
                    //     type: NativeAdType.video,
                    //     styles: NativeStyles()
                    //       ..setTitle(fontWeight: NativeFontWeight.boldItalic)
                    //       ..setCallToAction(fontSize: 8)
                    //       ..setFlag(fontSize: 10)
                    //       ..setSource(fontSize: 11),
                    //   ),
                    // ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: Colors.black12,
                      child: const Center(
                        child: Text(
                          'Native Banner Ad',
                          style: Styles.headerTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      height: 450,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.only(bottom: 40.0),
                      child: NativeAd(
                        adSlotId: _imageTestAdSlotId,
                        controller: NativeAdController(
                          adConfiguration: NativeAdConfiguration(
                            choicesPosition:
                                NativeAdChoicesPosition.BOTTOM_RIGHT,
                          ),
                          listener: (AdEvent event, {int? errorCode}) {
                            debugPrint('Native Ad event : $event');
                            setState(() {
                              logs =
                                  '${logs}Native Ad event : ${describeEnum(event)}\n';
                            });
                          },
                        ),
                        type: NativeAdType.banner,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: Colors.black12,
                      child: const Center(
                        child: Text(
                          'Native Small Ad',
                          style: Styles.headerTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: NativeAd(
                        adSlotId: _imageTestAdSlotId,
                        controller: NativeAdController(),
                        type: NativeAdType.full,
                        styles: NativeStyles()
                          ..setTitle(fontWeight: NativeFontWeight.boldItalic)
                          ..setCallToAction(fontSize: 8)
                          ..setFlag(fontSize: 10)
                          ..setSource(fontSize: 11),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: Colors.black12,
                      child: const Center(
                        child: Text(
                          'Native Full Ad',
                          style: Styles.headerTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      height: 400,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: NativeAd(
                        adSlotId: _imageTestAdSlotId,
                        controller: NativeAdController(),
                        type: NativeAdType.full,
                        styles: NativeStyles()
                          ..setSource(color: Colors.redAccent)
                          ..setCallToAction(
                            color: Colors.white,
                            bgColor: Colors.redAccent,
                          ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: Colors.black12,
                      child: const Center(
                        child: Text(
                          'Native Video Ad',
                          style: Styles.headerTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      height: 270,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: NativeAd(
                        adSlotId: _videoTestAdSlotId,
                        controller: createVideoAdController(),
                        type: NativeAdType.video,
                        styles: NativeStyles()
                          ..setCallToAction(fontSize: 10)
                          ..setFlag(fontSize: 10),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: Colors.black12,
                      child: const Center(
                        child: Text(
                          'Native Ad with App Download Button',
                          style: Styles.headerTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      height: 500,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: NativeAd(
                        adSlotId: _appDownloadTestAdSlotId,
                        controller: createVideoAdController(),
                        type: NativeAdType.app_download,
                        styles: NativeStyles()
                          ..setAppDownloadButtonNormal(fontSize: 10)
                          ..setAppDownloadButtonProcessing(fontSize: 12)
                          ..setAppDownloadButtonInstalling(fontSize: 14)
                          ..setCallToAction(fontSize: 10)
                          ..setFlag(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 250,
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    logs = '';
                  });
                },
                child: SingleChildScrollView(
                  child: Text(logs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
