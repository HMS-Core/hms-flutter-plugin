/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

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

  List<String> logs = [];

  HmsAuthHuaweiId _id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("HMS Account Example"),
          backgroundColor: Colors.blueAccent,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: 20),
              Column(
                children: [
                  HmsAuthButton(
                      onPressed: _signIn,
                      buttonColor: AuthButtonBackground.RED),
                  authButton("SILENT SIGN IN", _silentSignIn),
                  authButton("SIGN OUT", _signOut),
                  authButton("REVOKE AUTHORIZATION", _revokeAuthorization),
                  authButton("SMS VERIFICATION", _smsVerification)
                ],
              ),
              Divider(indent: 15, endIndent: 15, color: Colors.blueGrey),
              Expanded(
                  child: GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    logs.clear();
                  });
                },
                child: Container(
                  child: ListView.builder(
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(logs[index],
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
    // This parameter is optional. You can run the method with default options.
    final helper = new HmsAuthParamHelper();
    helper
      ..setIdToken()
      ..setAccessToken()
      ..setAuthorizationCode()
      ..setEmail()
      ..setProfile();
    try {
      _id = await HmsAuthService.signIn(authParamHelper: helper);
      _addToLogs("FROM SIGN IN: ${_id.displayName}");
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _signOut() async {
    try {
      final bool result = await HmsAuthService.signOut();
      _addToLogs("FROM SIGN OUT: $result");
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _silentSignIn() async {
    try {
      final HmsAuthHuaweiId id = await HmsAuthService.silentSignIn();
      _addToLogs("FROM SILENT SIGN IN: ${id.displayName}");
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _revokeAuthorization() async {
    try {
      final bool result = await HmsAuthService.revokeAuthorization();
      _addToLogs("FROM REVOKE AUTHORIZATION: $result");
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _smsVerification() async {
    HmsSmsManager.smsVerification(({errorCode, message}) {
      if (message != null) {
        setState(() {
          _addToLogs(message);
        });
        print("Received message: $message");
      } else {
        print("Error: $errorCode");
      }
    });
  }

  _addToLogs(String s) {
    setState(() {
      logs.add(s);
    });
  }
}
