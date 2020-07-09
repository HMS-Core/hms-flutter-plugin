/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:huawei_account/helpers/scope.dart';
import 'package:huawei_account/hms_account.dart';
import 'package:huawei_account/auth/auth_huawei_id.dart';
import 'package:huawei_account/authbutton/huawei_id_auth_button.dart';
import 'package:huawei_account_example/ui/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:huawei_account/helpers/auth_param_helper.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<String> logs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: 20),
              Column(
                children: [
                  HuaweiIdAuthButton(onPressed: _signIn, buttonColor: AuthButtonBackground.RED),
                  authButton("SIGN IN WITH AUTHORIZATION CODE", _signInWithAuthorizationCode),
                  authButton("SILENT SIGN IN", _silentSignIn),
                  authButton("SIGN OUT", _signOut),
                  authButton("REVOKE AUTHORIZATION", _revokeAuthorization),
                  authButton("SMS VERIFICATION", _smsVerification),
                ],
              ),
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
                            child: Text(logs[index], style: TextStyle(color: Colors.black54)),
                          );
                        },
                      ),
                    ),
                  )
              ),
            ],
          ),
        ));
  }

  _signIn() async {
    // BUILD DESIRED PARAMS
    AuthParamHelper authParamHelper = new AuthParamHelper();
    authParamHelper..setIdToken()..setAuthorizationCode()..setAccessToken()..setProfile()..setEmail()..setId()..addToScopeList([Scope.openId])..setRequestCode(8888);
    // GET ACCOUNT INFO FROM PLUGIN
    try {
      final AuthHuaweiId accountInfo = await HmsAccount.signIn(authParamHelper);
      setState(() {
        logs.add(accountInfo.displayName);
      });
    } on Exception catch(exception) {
      print(exception.toString());
    }
    /// TO VERIFY ID TOKEN, AuthParamHelper()..setIdToken()
    //performServerVerification(accountInfo.idToken);
  }

  _signOut() async {
    final signOutResult = await HmsAccount.signOut();
    if (signOutResult) {
      setState(() {
        logs.add("Sign out success");
      });
    } else {
      setState(() {
        logs.add("Sign out failed");
      });
    }
  }

  _silentSignIn() async {
    AuthParamHelper authParamHelper = new AuthParamHelper();
    try {
      final AuthHuaweiId accountInfo = await HmsAccount.silentSignIn(authParamHelper);
      setState(() {
        logs.add(accountInfo.displayName);
      });
    } on Exception catch(exception) {
      print(exception.toString());
    }
  }

  _revokeAuthorization() async {
    final bool revokeResult = await HmsAccount.revokeAuthorization();
    if (revokeResult) {
      setState(() {
        logs.add("Revoked Auth Successfuly");
      });
    } else {
      setState(() {
        logs.add("Failed to Revoked Auth");
      });
    }
  }

  _signInWithAuthorizationCode() async {
    AuthParamHelper authParamHelper = new AuthParamHelper();
    authParamHelper..setAuthorizationCode()..setRequestCode(1002);
    try {
      final AuthHuaweiId accountInfo = await HmsAccount.signInWithAuthorizationCode(authParamHelper);
      setState(() {
        logs.add(accountInfo.authorizationCode);
      });
    } on Exception catch(exception) {
      print(exception.toString());
    }
  }

  _smsVerification() async{
    HmsAccount.smsVerification(({errorCode, message}){
      if (message != null) {
        setState(() {
          logs.add(message);
        });
        print("Received message: $message");
      } else {
        print("Error: $errorCode");
      }
    });
  }
}
