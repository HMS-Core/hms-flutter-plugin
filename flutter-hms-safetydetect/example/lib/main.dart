/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'dart:developer' as developer;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_safetydetect/huawei_safetydetect.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> logs = <String>[];
  late final String appId;

  @override
  void initState() {
    super.initState();
    SafetyDetect.getAppID.then((String appId) {
      this.appId = appId;
      log('getAppID', 'App Id: $appId');
    }).catchError((dynamic e) {
      log('getAppID', e, false);
    });
  }

  Future<dynamic> isVerifyAppsCheck() async {
    return await SafetyDetect.isVerifyAppsCheck();
  }

  Future<dynamic> enableAppsCheck() async {
    return await SafetyDetect.enableAppsCheck();
  }

  Future<dynamic> initUrlCheck() async {
    return await SafetyDetect.initUrlCheck();
  }

  Future<dynamic> shutdownUrlCheck() async {
    return await SafetyDetect.shutdownUrlCheck();
  }

  Future<dynamic> urlCheck() async {
    const String url = 'http://example.com/hms/safetydetect/malware';
    final List<UrlCheckThreat> result = await SafetyDetect.urlCheck(
      url,
      appId,
      <UrlThreatType>[
        UrlThreatType.malware,
        UrlThreatType.phishing,
      ],
    );
    return '${result.length} threat is detected for the URL: $url';
  }

  Future<dynamic> initUserDetect() async {
    return await SafetyDetect.initUserDetect();
  }

  Future<dynamic> shutdownUserDetect() async {
    return await SafetyDetect.shutdownUserDetect();
  }

  Future<dynamic> userDetection() async {
    final String? token = await SafetyDetect.userDetection(appId);
    return 'User verified, user token: $token';
  }

  Future<dynamic> initAntiFraud() async {
    return await SafetyDetect.initAntiFraud(appId);
  }

  Future<dynamic> releaseAntiFraud() async {
    return await SafetyDetect.releaseAntiFraud();
  }

  Future<dynamic> getRiskToken() async {
    final String? riskToken = await SafetyDetect.getRiskToken();
    return 'Risk Token: $riskToken';
  }

  Future<dynamic> sysIntegrity() async {
    final List<int> randomIntegers = <int>[];
    for (int i = 0; i < 24; i++) {
      randomIntegers.add(math.Random.secure().nextInt(255));
    }
    final Uint8List nonce = Uint8List.fromList(randomIntegers);
    final String result = await SafetyDetect.sysIntegrity(
      nonce,
      appId,
      alg: 'RS256',
    );
    final List<String> jwsSplit = result.split('.');
    final String decodedText = utf8.decode(base64Url.decode(jwsSplit[1]));
    return json.decode(decodedText);
  }

  Future<dynamic> getWifiDetectStatus() async {
    final WifiDetectResponse status = await SafetyDetect.getWifiDetectStatus();
    return 'Wifi detect status is: ${status.getWifiDetectType}';
  }

  Future<dynamic> getMaliciousAppsList() async {
    final List<MaliciousAppData> result =
        await SafetyDetect.getMaliciousAppsList();
    return '${result.length} malicious apps detected.';
  }

  void log(String method, dynamic message, [bool isSuccess = true]) {
    final String status = isSuccess ? 'SUCCESS' : 'FAILURE';
    final String logMessage = '$status\n${message ?? ''}'.trim();
    developer.log(logMessage, name: method);
    setState(() => logs.insert(0, '[$method]: $logMessage'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Tooltip(
          message: 'Flutter Version: 6.4.0+302',
          child: Text('HMS Safety Detect Demo'),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                child: Wrap(
                  spacing: 16,
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    buildButton(
                      text: 'isVerifyAppsCheck',
                      onPressed: isVerifyAppsCheck,
                    ),
                    buildButton(
                      text: 'enableAppsCheck',
                      onPressed: enableAppsCheck,
                    ),
                    const Divider(),
                    buildButton(
                      text: 'initUrlCheck',
                      onPressed: initUrlCheck,
                    ),
                    buildButton(
                      text: 'shutdownUrlCheck',
                      onPressed: shutdownUrlCheck,
                    ),
                    buildButton(
                      text: 'urlCheck',
                      onPressed: urlCheck,
                    ),
                    const Divider(),
                    buildButton(
                      text: 'initUserDetect',
                      onPressed: initUserDetect,
                    ),
                    buildButton(
                      text: 'shutdownUserDetect',
                      onPressed: shutdownUserDetect,
                    ),
                    buildButton(
                      text: 'userDetection',
                      onPressed: userDetection,
                    ),
                    const Divider(),
                    buildButton(
                      text: 'initAntiFraud',
                      onPressed: initAntiFraud,
                    ),
                    buildButton(
                      text: 'releaseAntiFraud',
                      onPressed: releaseAntiFraud,
                    ),
                    buildButton(
                      text: 'getRiskToken',
                      onPressed: getRiskToken,
                    ),
                    const Divider(),
                    buildButton(
                      text: 'sysIntegrity',
                      onPressed: sysIntegrity,
                    ),
                    buildButton(
                      text: 'getWifiDetectStatus',
                      onPressed: getWifiDetectStatus,
                    ),
                    buildButton(
                      text: 'getMaliciousAppsList',
                      onPressed: getMaliciousAppsList,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(),
          buildLogcat(),
        ],
      ),
    );
  }

  Widget buildButton({
    required String text,
    required Future<dynamic> Function() onPressed,
  }) {
    return ElevatedButton(
      onPressed: () async {
        try {
          final dynamic result = await onPressed.call();
          log(text, result);
        } catch (e) {
          log(text, e, false);
        }
      },
      child: Text(text),
    );
  }

  Widget buildLogcat() {
    return GestureDetector(
      onDoubleTap: () => setState(() => logs.clear()),
      child: AspectRatio(
        aspectRatio: 2,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.10),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: logs.isEmpty
              ? const Text('Double tap to clear logs')
              : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: logs.length,
                  itemBuilder: (_, int index) => Text(logs[index]),
                  separatorBuilder: (_, __) => const Divider(),
                ),
        ),
      ),
    );
  }
}
