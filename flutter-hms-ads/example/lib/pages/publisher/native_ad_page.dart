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

class NativeAdPage extends StatefulWidget {
  @override
  _NativeAdPageState createState() => _NativeAdPageState();
}

class _NativeAdPageState extends State<NativeAdPage> {
  static final String _imageTestAdSlotId = "testu7m3hc4gvm"; // Image
  static final String _videoTestAdSlotId = "testy63txaom86"; // Video ad
  String logs = "Double tap to clear the logs.\n\n";

  NativeAdController createVideoAdController() {
    NativeAdController controller = NativeAdController();
    controller.listener = (AdEvent event, {int errorCode}) {
      if (event == AdEvent.loaded) {
        testNative(controller);
      }
    };
    return controller;
  }

  void testNative(NativeAdController controller) async {
    VideoOperator operator = await controller.getVideoOperator();
    operator.setVideoLifecycleListener =
        (VideoLifecycleEvent event, {bool isMuted}) {
      print("VideoLifeCycle event : $event");
      setState(() {
        logs = logs + "VideoLifeCycle event : ${describeEnum(event)}\n";
      });
    };
    bool hasVideo = await operator.hasVideo();
    print('Operator has video : $hasVideo');

    String title = await controller.getTitle();
    print('Ad Title : $title');

    String callToAction = await controller.getCallToAction();
    print('Ad action : $callToAction');

    String source = await controller.getAdSource();
    print('Ad source : $source');

    String getAdSign = await controller.getAdSign();
    print('Ad sign : $getAdSign');

    String whyThisAd = await controller.getWhyThisAd();
    print('Why this ad : $whyThisAd');

    String uniqueId = await controller.getUniqueId();
    print('uniqueId : $uniqueId');
  }

  @override
  Widget build(BuildContext context) {
    NativeStyles stylesSmall = NativeStyles();
    stylesSmall.setTitle(fontWeight: NativeFontWeight.boldItalic);
    stylesSmall.setCallToAction(fontSize: 8);
    stylesSmall.setFlag(fontSize: 10);
    stylesSmall.setSource(fontSize: 11);

    NativeStyles stylesVideo = NativeStyles();
    stylesVideo.setCallToAction(fontSize: 10);
    stylesVideo.setFlag(fontSize: 10);

    NativeStyles stylesFull = NativeStyles();
    stylesFull.setSource(color: Colors.redAccent);
    stylesFull.setCallToAction(color: Colors.white, bgColor: Colors.redAccent);

    NativeAdConfiguration configuration = NativeAdConfiguration();
    configuration.choicesPosition = NativeAdChoicesPosition.bottomRight;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(
            'Huawei Ads - Native',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        color: Colors.black12,
                        child: Center(
                          child: Text(
                            "Native Banner Ad",
                            style: Styles.headerTextStyle,
                          ),
                        ),
                      ),
                      Container(
                        height: 330,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: NativeAd(
                          adSlotId: _imageTestAdSlotId,
                          controller: NativeAdController(
                              adConfiguration: configuration,
                              listener: (AdEvent event, {int errorCode}) {
                                print("Native Ad event : $event");
                                setState(() {
                                  logs = logs +
                                      "Native Ad event : ${describeEnum(event)}\n";
                                });
                              }),
                          type: NativeAdType.banner,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        color: Colors.black12,
                        child: Center(
                          child: Text(
                            "Native Small Ad",
                            style: Styles.headerTextStyle,
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: NativeAd(
                          adSlotId: _imageTestAdSlotId,
                          controller: NativeAdController(),
                          type: NativeAdType.small,
                          styles: stylesSmall,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        color: Colors.black12,
                        child: Center(
                          child: Text(
                            "Native Full Ad",
                            style: Styles.headerTextStyle,
                          ),
                        ),
                      ),
                      Container(
                        height: 400,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: NativeAd(
                          adSlotId: _imageTestAdSlotId,
                          controller: NativeAdController(),
                          type: NativeAdType.full,
                          styles: stylesFull,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        color: Colors.black12,
                        child: Center(
                          child: Text(
                            "Native Video Ad",
                            style: Styles.headerTextStyle,
                          ),
                        ),
                      ),
                      Container(
                        height: 500,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: NativeAd(
                          adSlotId: _videoTestAdSlotId,
                          controller: createVideoAdController(),
                          type: NativeAdType.video,
                          styles: stylesVideo,
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
                padding: EdgeInsets.only(left: 10, top: 20),
                child: GestureDetector(
                  onDoubleTap: () => setState(() {
                    logs = "";
                  }),
                  child: SingleChildScrollView(
                    child: Text(logs),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
