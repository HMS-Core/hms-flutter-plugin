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

import 'package:huawei_account/huawei_account.dart';
import 'package:flutter/material.dart';
import '../ui/auth_button.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<String> _logs = [];

  AuthAccount _account;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Huawei Account Demo",
              style: TextStyle(color: Colors.black)),
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
                  children: [
                    HuaweiIdAuthButton(
                        onPressed: _signIn,
                        elevation: 0,
                        borderRadius: AuthButtonRadius.SMALL,
                        buttonColor: AuthButtonBackground.RED),
                    authButton("SILENT SIGN IN", _silentSignIn),
                    authButton("SIGN OUT", _signOut),
                    authButton("REVOKE AUTHORIZATION", _revokeAuthorization),
                  ],
                ),
              ),
              Divider(indent: 15, endIndent: 15, color: Colors.blueGrey),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text("---- DOUBLE TAP TO CLEAR LOGS ----"),
              ),
              Expanded(
                  child: GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    _logs.clear();
                  });
                },
                child: Container(
                  child: ListView.builder(
                    itemCount: _logs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(_logs[index],
                            style: TextStyle(color: Colors.black54)),
                      );
                    },
                  ),
                ),
              )),
            ],
          ),
        ));
  }

  _signIn() async {
    final helper = AccountAuthParamsHelper();
    helper
      ..setAccessToken()
      ..setEmail()
      ..setIdToken()
      ..setAuthorizationCode()
      ..setProfile();

    try {
      _account = await AccountAuthService.signIn(helper);
      _addToLogs("FROM SIGN IN: " + _account.displayName);
    } on Exception catch (e) {
      _addToLogs(e.toString());
    }
  }

  _signOut() async {
    try {
      final bool res = await AccountAuthService.signOut();
      _addToLogs("FROM SIGN OUT: $res");
    } on Exception catch (e) {
      _addToLogs(e.toString());
    }
  }

  _silentSignIn() async {
    try {
      final AuthAccount account = await AccountAuthService.silentSignIn();
      _addToLogs("FROM SILENT SIGN IN: " + account.displayName);
    } on Exception catch (e) {
      _addToLogs(e.toString());
    }
  }

  _revokeAuthorization() async {
    try {
      final bool res = await AccountAuthService.cancelAuthorization();
      _addToLogs("FROM CANCEL AUTHORIZATION: $res");
    } on Exception catch (e) {
      _addToLogs(e.toString());
    }
  }

  _addToLogs(String s) {
    setState(() {
      _logs.add(s);
    });
  }
}
