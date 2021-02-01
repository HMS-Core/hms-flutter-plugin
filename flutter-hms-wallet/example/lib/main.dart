/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_wallet_example/pages/sdk_page.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData(
      appBarTheme: AppBarTheme(color: Colors.black87),
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Huawei Wallet Kit Demo'),
      ),
      body: ListView(
        children: [
          MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Obtaining vouchers through web pages, SMS messages, emails, and apps',
            ),
            color: Colors.grey,
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => SdkPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
