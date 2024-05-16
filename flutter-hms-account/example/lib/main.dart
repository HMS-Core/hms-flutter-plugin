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
import 'package:huawei_account/huawei_account.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> _logs = <String>[];

  late AccountAuthService _authService;

  @override
  void initState() {
    super.initState();

    final AccountAuthParamsHelper authParamsHelper = AccountAuthParamsHelper()
      ..setProfile()
      ..setAccessToken();
    final AccountAuthParams authParams = authParamsHelper.createParams();
    _authService = AccountAuthManager.getService(authParams);
  }

  Widget _buildAuthButton(String text, VoidCallback callback) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 25,
          ),
        ),
        child: Text(text.toUpperCase()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Huawei Account Demo',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10),
              child: Column(
                children: <Widget>[
                  HuaweiIdAuthButton(
                    onPressed: _signIn,
                    elevation: 0,
                    borderRadius: AuthButtonRadius.SMALL,
                    buttonColor: AuthButtonBackground.RED,
                  ),
                  _buildAuthButton(
                    'SILENT SIGN IN',
                    _silentSignIn,
                  ),
                  _buildAuthButton(
                    'SIGN OUT',
                    _signOut,
                  ),
                  _buildAuthButton(
                    'CANCEL AUTHORIZATION',
                    _revokeAuthorization,
                  ),
                ],
              ),
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
              color: Colors.blueGrey,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text('---- DOUBLE TAP TO CLEAR LOGS ----'),
            ),
            Expanded(
              child: GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    _logs.clear();
                  });
                },
                child: ListView.builder(
                  itemCount: _logs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        _logs[index],
                        style: const TextStyle(color: Colors.black54),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    try {
      final AuthAccount account = await _authService.signIn();
      _addToLogs('FROM SIGN IN: ${account.toMap()}');
    } on Exception catch (e) {
      _addToLogs(e.toString());
    }
  }

  void _signOut() async {
    try {
      final bool res = await _authService.signOut();
      _addToLogs('FROM SIGN OUT: $res');
    } on Exception catch (e) {
      _addToLogs(e.toString());
    }
  }

  void _silentSignIn() async {
    try {
      final AuthAccount account = await _authService.silentSignIn();
      _addToLogs('FROM SILENT SIGN IN: ${account.displayName}');
    } on Exception catch (e) {
      _addToLogs(e.toString());
    }
  }

  void _revokeAuthorization() async {
    try {
      final bool res = await _authService.cancelAuthorization();
      _addToLogs('FROM CANCEL AUTHORIZATION: $res');
    } on Exception catch (e) {
      _addToLogs(e.toString());
    }
  }

  void _addToLogs(String s) {
    setState(() {
      _logs.add(s);
    });
  }
}
