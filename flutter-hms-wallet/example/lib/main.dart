/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.
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
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.black87,
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Huawei Wallet Kit Demo'),
      ),
      body: ListView(
        children: <Widget>[
          MaterialButton(
            color: Colors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute<dynamic>(
                  builder: (_) => const SdkPage(),
                ),
              );
            },
            child: const Text(
              'Obtaining vouchers through web pages, SMS messages, emails, and apps',
            ),
          ),
        ],
      ),
    );
  }
}
