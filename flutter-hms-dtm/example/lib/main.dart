/*
 * Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:huawei_dtm/huawei_dtm.dart';

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
  late final StreamSubscription<Map<String, dynamic>> onCustomTagEvent;
  bool showFourthButton = false;

  @override
  void initState() {
    super.initState();
    onCustomTagEvent = HMSDTM.customTagStream.listen(
      (Map<String, dynamic> event) async {
        log('onCustomTagEvent', event);

        if (event['price'] != null) {
          try {
            final double price = double.parse(event['price']);
            final double discount = double.parse(event['discount']);
            final double newPrice = price - (price * discount / 100);
            await HMSDTM.setCustomVariable('PantsPrice', newPrice);
            log('setCustomVariable', null);
          } catch (e) {
            log('setCustomVariable', e, false);
          }
        }
      },
    );
  }

  @override
  void dispose() {
    onCustomTagEvent.cancel();
    super.dispose();
  }

  Future<dynamic> sendCustomEvent() async {
    return await HMSDTM.onEvent(
      'Platform',
      <String, dynamic>{
        'platformName': 'Flutter',
      },
    );
  }

  Future<dynamic> customTag() async {
    return await HMSDTM.onEvent(
      'PurchaseShoes',
      <String, dynamic>{
        'price': '70',
      },
    );
  }

  Future<dynamic> setCustomVariableValue() async {
    await HMSDTM.onEvent(
      'SetPantsPrice',
      <String, dynamic>{"discount": 10, "price": 70},
    );
    setState(() => showFourthButton = true);
  }

  Future<dynamic> reportEventWithCustomVariable() async {
    return await HMSDTM.onEvent(
      'PurchasePants',
      <String, dynamic>{},
    );
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
          message: 'Flutter Version: 6.6.0+303',
          child: Text('HMS DTM Demo'),
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
                      text: 'Send Custom Event',
                      onPressed: sendCustomEvent,
                    ),
                    const Divider(),
                    buildButton(
                      text: 'Custom Tag',
                      onPressed: customTag,
                    ),
                    const Divider(),
                    buildButton(
                      text: 'Set Custom Variable Value',
                      onPressed: setCustomVariableValue,
                    ),
                    const Divider(),
                    if (showFourthButton)
                      buildButton(
                        text: 'Report Event with Custom Variable',
                        onPressed: reportEventWithCustomVariable,
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
