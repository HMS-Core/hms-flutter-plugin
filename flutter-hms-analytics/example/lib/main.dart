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

import 'package:flutter/material.dart';
import 'package:huawei_analytics/huawei_analytics.dart';

import 'keys.dart';

void main() => runApp(MaterialApp(home: MyHomePage()));

class MyBtn extends StatelessWidget {
  final String title;
  final Function _onPress;

  MyBtn(this.title, this._onPress, Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 3, 3, 3),
        color: Colors.white,
        child: RaisedButton(
            color: Colors.grey,
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            onPressed: () async {
              _onPress(context);
            }));
  }
}

class MyHomePage extends StatelessWidget {
  final String _appTitle = 'HUAWEI HMS Analytics Flutter  Demo';
  final HMSAnalytics hmsAnalytics = new HMSAnalytics();

  void _showDialog(BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            key: Key(Keys.DIALOG),
            title: Text("Result"),
            content: Text(content, key: Key(Keys.DIALOG_CONTENT)),
            actions: <Widget>[
              FlatButton(
                child: new Text("Close", key: Key(Keys.DIALOG_CLOSE)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<void> _onEnableLog(BuildContext context) async {
    await hmsAnalytics.enableLog();
    _showDialog(context, "enableLog success");
  }

  Future<void> _onEnableLogWithLevel(BuildContext context) async {
    //Possible options DEBUG, INFO, WARN, ERROR
    await hmsAnalytics.enableLogWithLevel("DEBUG");
    _showDialog(context, "enableLogWithLevel success");
  }

  Future<void> _setUserId(BuildContext context) async {
    await hmsAnalytics.setUserId("userId");
    _showDialog(context, "setUserId success");
  }

  Future<void> _setUserProfile(BuildContext context) async {
    await hmsAnalytics.setUserProfile("key", "value");
    _showDialog(context, "setUserProfile success");
  }

  Future<void> _setPushToken(BuildContext context) async {
    await hmsAnalytics.setPushToken("token");
    _showDialog(context, "setPushToken success");
  }

  Future<void> _setMinActivitySessions(BuildContext context) async {
    await hmsAnalytics.setMinActivitySessions(1000);
    _showDialog(context, "setMinActivitySessions success");
  }

  Future<void> _setSessionDuration(BuildContext context) async {
    await hmsAnalytics.setSessionDuration(1000);
    _showDialog(context, "setSessionDuration success");
  }

  Future<void> _onCustomEvent(BuildContext context) async {
    String name = "event_name";
    dynamic value = {'my_event_key': 'my_event_value'};

    await hmsAnalytics.onEvent(name, value);
    _showDialog(context, "onEvent success");
  }

  Future<void> _onPredefinedEvent(BuildContext context) async {
    String name = HAEventType.SUBMITSCORE;
    dynamic value = {HAParamType.SCORE: 12};

    await hmsAnalytics.onEvent(name, value);
    _showDialog(context, "onEvent success");
  }

  Future<void> _clearCachedData(BuildContext context) async {
    await hmsAnalytics.clearCachedData();
    _showDialog(context, "clearCachedData success");
  }

  Future<void> _getAAID(BuildContext context) async {
    String aaid = await hmsAnalytics.getAAID();
    _showDialog(context, "AAID : " + aaid);
  }

  Future<void> _getUserProfiles(BuildContext context) async {
    Map<String, String> profiles = await hmsAnalytics.getUserProfiles(true);
    _showDialog(context, "User Profiles : " + profiles.toString());
  }

  Future<void> _pageStart(BuildContext context) async {
    await hmsAnalytics.pageStart("pageName", "pageClassOverride");
    _showDialog(context, "pageStart success");
  }

  Future<void> _pageEnd(BuildContext context) async {
    await hmsAnalytics.pageEnd("pageName");
    _showDialog(context, "pageEnd success");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appTitle),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MyBtn("Enable Log", _onEnableLog, Key(Keys.ENABLE_LOG)),
            MyBtn("Enable Log With Level", _onEnableLogWithLevel,
                Key(Keys.ENABLE_LOG_WITH_LEVEL)),
            MyBtn("Set User Id", _setUserId, Key(Keys.SET_USER_ID)),
            MyBtn("Set User Profile", _setUserProfile,
                Key(Keys.SET_USER_PROFILE)),
            MyBtn("Set Push Token", _setPushToken, Key(Keys.SET_PUSH_TOKEN)),
            MyBtn("Set Min Activity Sessions", _setMinActivitySessions,
                Key(Keys.SET_MIN_ACTIVITY_SESSIONS)),
            MyBtn("Set Sessions Duration", _setSessionDuration,
                Key(Keys.SET_SESSIONS_DURATION)),
            MyBtn("Send Custom Event", _onCustomEvent, Key(Keys.CUSTOM_EVENT)),
            MyBtn("Send Predefined Event", _onPredefinedEvent,
                Key(Keys.PREDEFINED_EVENT)),
            MyBtn("Clear Cached Data", _clearCachedData,
                Key(Keys.CLEAR_CACHED_DATA)),
            MyBtn("Get AAID", _getAAID, Key(Keys.GET_AAID)),
            MyBtn("Get User Profiles", _getUserProfiles,
                Key(Keys.GET_USER_PROFILES)),
            MyBtn("Page Start", _pageStart, Key(Keys.PAGE_START)),
            MyBtn("Page End", _pageEnd, Key(Keys.PAGE_END)),
          ],
        ),
      ),
    );
  }
}
