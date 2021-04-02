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

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_safetydetect/huawei_safetydetect.dart';
import 'package:huawei_safetydetect_example/widgets/list_tile_button.dart';
import 'package:huawei_safetydetect_example/widgets/result_container.dart';

import 'style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  String selectedMethodName = '';
  String currentMethodResult = '';
  String appId;
  String urlToCheck = "http://example.com/hms/safetydetect/malware";
  TextEditingController urlTextController;
  bool antiFraudEnabled = true;

  @override
  void initState() {
    super.initState();
    urlTextController = TextEditingController(text: urlToCheck);
    animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();
    getAppId();
  }

  void animateResult() {
    animationController.reset();
    animationController.forward();
  }

  void getAppId() async {
    String res = await SafetyDetect.getAppID;
    if (!mounted) return;
    setState(() {
      appId = res;
    });
  }

  void checkSysIntegrity() async {
    selectedMethodName = "Sys Integrity Check";
    Random secureRandom = Random.secure();
    List randomIntegers = List<int>();
    for (var i = 0; i < 24; i++) {
      randomIntegers.add(secureRandom.nextInt(255));
    }
    Uint8List nonce = Uint8List.fromList(randomIntegers);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      String sysintegrityresult = await SafetyDetect.sysIntegrity(nonce, appId);
      List<String> jwsSplit = sysintegrityresult.split(".");
      String decodedText = utf8.decode(base64Url.decode(jwsSplit[1]));
      Map<String, dynamic> jsonMap = json.decode(decodedText);
      currentMethodResult =
          "Basic Integrity: " + jsonMap['basicIntegrity'].toString();
      print("SysIntegrityCheck result is: $decodedText");
    } on PlatformException catch (e) {
      currentMethodResult = "Error occurred while getting result, Error is: $e";
      print("Error occurred while getting SysIntegrityResult. Error is : $e");
    }
    animateResult();
  }

  void getMaliciousAppsList() async {
    selectedMethodName = "Malicious Apps List";
    List<MaliciousAppData> maliciousApps = [];
    maliciousApps = await SafetyDetect.getMaliciousAppsList();
    animateResult();
    setState(() {
      currentMethodResult = maliciousApps.length == 0
          ? "No malicious apps detected."
          : maliciousApps.toString();
    });
  }

  void urlCheck() async {
    selectedMethodName = "URL Check";
    String urlCheckRes = "";
    List<UrlThreatType> threatTypes = [
      UrlThreatType.malware,
      UrlThreatType.phishing
    ];

    List<UrlCheckThreat> urlCheckResults =
        await SafetyDetect.urlCheck(urlTextController.text, appId, threatTypes);

    if (urlCheckResults.length == 0) {
      urlCheckRes =
          "No threat is detected for the URL: ${urlTextController.text}";
    } else {
      urlCheckResults.forEach((element) {
        urlCheckRes +=
            "${element.getUrlThreatType} is detected on the URL: ${urlTextController.text}";
      });
    }
    currentMethodResult = urlCheckRes;
    animateResult();
  }

  void userDetection() async {
    selectedMethodName = "User Detection";
    try {
      String token = await SafetyDetect.userDetection(appId);
      currentMethodResult = "User verification succeeded, user token: $token";
    } on PlatformException catch (e) {
      currentMethodResult =
          "Error occurred: " + e.code + ":" + SafetyDetectStatusCodes[e.code];
    }
    animateResult();
  }

  void getWifiDetectStatus() async {
    selectedMethodName = "Wifi Detect Status";
    try {
      WifiDetectResponse wifiDetectStatus =
          await SafetyDetect.getWifiDetectStatus();
      currentMethodResult = "Wifi detect status is: " +
          wifiDetectStatus.getWifiDetectType.toString();
    } on PlatformException catch (e) {
      String resultCodeDesc = SafetyDetectStatusCodes[e.code];
      currentMethodResult =
          "Error occurred with status code: ${e.code}, Description: $resultCodeDesc";
    }
    animateResult();
  }

  void getRiskToken() async {
    selectedMethodName = "Get Risk Token";
    String riskToken = await SafetyDetect.getRiskToken();
    currentMethodResult = "Risk Token: $riskToken";
    animateResult();
  }

  void initAntiFraud() async {
    SafetyDetect.initAntiFraud(appId);
    print("Anti Fraud enabled");
    setState(() {
      antiFraudEnabled = true;
    });
  }

  void releaseAntiFraud() async {
    SafetyDetect.releaseAntiFraud();
    print("Released Anti Fraud");
    setState(() {
      antiFraudEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      home: Builder(builder: (context) {
        return Material(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // App Header
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: double.infinity,
                    color: galleryGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 60,
                            margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/huawei_logo.png')))),
                        Text('Flutter Safety Detect',
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: textColor))
                      ],
                    ),
                  ),
                  // App Body
                  Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    color: bgColor,
                    child: Column(
                      children: [
                        FadeTransition(
                            opacity: animation,
                            child: ResultContainer(
                                methodName: selectedMethodName,
                                methodResult: currentMethodResult)),
                        // Button List
                        Container(
                            height: 160,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                padding: componentPadding.copyWith(
                                    left: 5.0, right: 5.0),
                                children: [
                                  ListTileButton(
                                      onTap: () => userDetection(),
                                      title: "User Detect",
                                      iconData: Icons.person,
                                      iconColor: darkGrey),
                                  ListTileButton(
                                    onTap: () => getMaliciousAppsList(),
                                    title: "Malicious App List",
                                    iconData: Icons.bug_report,
                                    iconColor: Colors.red,
                                  ),
                                  ListTileButton(
                                      onTap: () => checkSysIntegrity(),
                                      title: "Sys Integrity",
                                      iconData: Icons.security,
                                      iconColor: Colors.blue),
                                  ListTileButton(
                                      onTap: () => getWifiDetectStatus(),
                                      iconData: Icons.wifi,
                                      iconColor: Colors.deepOrange,
                                      title: "Wifi Detect"),
                                  ListTileButton(
                                      onTap: () => getRiskToken(),
                                      iconData: Icons.vpn_key,
                                      iconColor: Colors.amber,
                                      title: "Get Risk Token"),
                                  ListTileButton(
                                    onTap: () => antiFraudEnabled
                                        ? releaseAntiFraud()
                                        : initAntiFraud(),
                                    iconData: Icons.power_settings_new,
                                    iconColor: antiFraudEnabled
                                        ? Colors.red
                                        : Colors.green,
                                    title: antiFraudEnabled
                                        ? "Release AntiFraud"
                                        : "Init Anti Fraud",
                                  )
                                ])),
                        // Url Check Widget
                        Container(
                          height: 150,
                          width: double.infinity,
                          margin: componentPadding,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              gradient: LinearGradient(
                                  colors: [galleryGrey, mercuryGrey],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 8,
                                  color: alto,
                                  offset: Offset(4, 4),
                                ),
                                BoxShadow(
                                  blurRadius: 8,
                                  color: alabaster,
                                  offset: Offset(-4, -4),
                                )
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  child: TextField(
                                    textAlign: TextAlign.start,
                                    controller: urlTextController,
                                    style: TextStyle(
                                        fontSize: 12.0, color: mineShaft),
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                  )),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5.0),
                                child: FlatButton(
                                  color: darkGrey,
                                  onPressed: () => urlCheck(),
                                  child: Text(
                                    'Check Url Safety',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
