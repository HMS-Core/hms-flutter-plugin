/*
    Copyright 2020-2025. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_account/huawei_account.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
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

  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    final AccountAuthParamsHelper authParamsHelper = AccountAuthParamsHelper()
      ..setProfile()
      ..setAccessToken();
    final AccountAuthParams authParams = authParamsHelper.createParams();
    _authService = AccountAuthManager.getService(authParams);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                  SizedBox(
                    height: 310,
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: controller,
                      child: ListView(
                        controller: controller,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: HuaweiIdAuthButton(
                              onPressed: _signIn,
                              elevation: 0,
                              borderRadius: AuthButtonRadius.SMALL,
                              buttonColor: AuthButtonBackground.RED,
                            ),
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
                          _buildAuthButton(
                            "build network cookie",
                            _buildNetworkCookie,
                          ),
                          _buildAuthButton(
                            "enable logger",
                            _enableLogger,
                          ),
                          _buildAuthButton(
                            "disable logger",
                            _disableLogger,
                          ),
                          _buildAuthButton(
                            "get auth result",
                            _getAuthResult,
                          ),
                          _buildAuthButton(
                            "Independent sign in",
                            _independentSignIn,
                          ),
                          _buildAuthButton(
                            "Request access token",
                            _requestAccessToken,
                          ),
                          _buildAuthButton(
                            "get extended auth result",
                            _getExtendedAuthResult,
                          ),
                          _buildAuthButton(
                            "delete auth info",
                            _deleteAuthInfo,
                          ),
                          _buildAuthButton(
                            "build network url",
                            _buildNetworkUrl,
                          ),
                          _buildAuthButton(
                            "Add Auth with extended results",
                            _addAuthWithExtendedResult,
                          ),
                          _buildAuthButton(
                            "Request Union Id",
                            _requestUnionId,
                          ),
                          _buildAuthButton(
                            "contain scopes with extended params",
                            containScopesWithExtendedParams,
                          ),
                        ],
                      ),
                    ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: SelectableText(
                        '> ${_logs[index]}',
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

  Future<void> containScopesWithExtendedParams() async {
    AuthAccount acc = AuthAccount();
    try {
      bool contain = await AccountAuthManager.containScopesWithExtendedParams(
          null, Impl());
      _addToLogs("contain scopes with extended params: $contain");
    } catch (e) {
      _addToLogs("contain scopes with extended params: ${e.toString()}");
    }
  }

  Future<void> _requestUnionId() async {
    // replace this with your account object
    Account account = Account();
    try {
      String unionId = await HuaweiIdAuthTool.requestUnionId(account);
      _addToLogs("request union id: $unionId");
    } catch (e) {
      _addToLogs("request union id: ${e.toString()}");
    }
  }

  // no return type for this function, check the HMS logs
  void _addAuthWithExtendedResult() {
    AccountAuthManager.addAuthScopesWithExtendedParams(200, Impl());
  }

  Future<void> _buildNetworkUrl() async {
    try {
      String url = await NetworkTool.buildNetworkUrl("<domain>", true);
      _addToLogs("build network url : $url");
    } catch (e) {
      _addToLogs(e.toString());
    }
  }

  Future<void> _deleteAuthInfo() async {
    // input your access token
    bool isDeleted =
        await HuaweiIdAuthTool.deleteAuthInfo("<YOUR_ACCESS_TOKEN>");
    _addToLogs("delete auth info: $isDeleted");
  }

  Future<void> _requestAccessToken() async {
    try {
      Account acc = Account(name: "", type: "");
      String str = await HuaweiIdAuthTool.requestAccessToken(acc, [
        Scope.email,
        Scope.profile,
        Scope.accountMobileNumber,
        Scope.openId,
        Scope.game
      ]);
      log("token : $str");
      _addToLogs("request access token: $str");
    } catch (e) {
      _addToLogs("request access token: ${e.toString()}");
    }
  }

  Future<void> _getExtendedAuthResult() async {
    AuthAccount account =
        await AccountAuthManager.getExtendedAuthResult(Impl());
    _addToLogs("extended auth result ${account.toMap()}");
    log("account : ${account.toMap()}");
  }

  Future<void> _independentSignIn() async {
    var acc = await AccountAuthService({}).independentSignIn("<access_token>");
    _addToLogs("From independentSignIn: ${acc.toMap()}");
  }

  Future<void> _getAuthResult() async {
    var acc = await AccountAuthManager.getAuthResult();

    _addToLogs("Auth result: ${acc.toMap()}");
  }

  void _enableLogger() {
    AccountAuthManager.enableLogger();
    _addToLogs("HMS Logger enabled");
  }

  void _disableLogger() {
    AccountAuthManager.disableLogger();
    _addToLogs("HMS Logger disabled");
  }

  Future<void> _buildNetworkCookie() async {
    var cookie = await NetworkTool.buildNetworkCookie(
        "name", "value", "value", "value", true, true, 40.0);
    _addToLogs("buildNetworkCookie: $cookie");
  }

  Future<void> _signIn() async {
    try {
      final AuthAccount account = await _authService.signIn();

      _addToLogs('FROM SIGN IN: ${account.toMap()}');
      log("${account.toMap()}");
    } on Exception catch (e) {
      _addToLogs(e.toString());
    }
  }

  Future<void> _signOut() async {
    try {
      final bool res = await _authService.signOut();
      _addToLogs('FROM SIGN OUT: $res');
    } on Exception catch (e) {
      _addToLogs(e.toString());
    }
  }

  Future<void> _silentSignIn() async {
    try {
      final AuthAccount account = await _authService.silentSignIn();
      _addToLogs('FROM SILENT SIGN IN: ${account.displayName}');
    } on Exception catch (e) {
      _addToLogs(e.toString());
    }
  }

  Future<void> _revokeAuthorization() async {
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

class Impl extends AccountAuthExtendedParams {
  @override
  int getExtendedParamType() {
    return super.games;
  }

  @override
  List<Scope> getExtendedScopes() {
    return [Scope.email];
  }
}
