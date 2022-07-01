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

import 'package:flutter/material.dart';
import 'package:huawei_analytics/huawei_analytics.dart';

void main() => runApp(MaterialApp(home: MyHomePage()));

class MyBtn extends StatelessWidget {
  final String title;
  final Function _onPress;

  MyBtn(this.title, this._onPress);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
        color: Colors.white,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey,
            ),
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            onPressed: () async {
              _onPress(context);
            }));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _appTitle = 'HUAWEI HMS Analytics Flutter  Demo';

  late HMSAnalytics hmsAnalytics;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    hmsAnalytics = await HMSAnalytics.getInstance();
  }

  void _showDialog(BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Result"),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                child: new Text("Close"),
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
    await hmsAnalytics.enableLogWithLevel("INFO");
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
    String name = "my_custom_event";

    Map<String, dynamic> customEvent = {
      "string_value": "analytics",
      "integer_value": 42,
      "long_value": 4294967298,
      "double_value": 4.2,
      "boolean_value": true,
      // "list_of_integers": <int>[1, 2, 3, 4, 5, 6, 10], // You can only send one list at a time.
      "list_of_strings": <String>["HUAWEI", "Analytics"],
      "inner_bundle_example": {
        "string_val": "hms",
        "int_val": 23,
      },
    };

    await hmsAnalytics.onEvent(name, customEvent);
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

  Future<void> _setAnalyticsEnabled(BuildContext context) async {
    await hmsAnalytics.setAnalyticsEnabled(true);
    _showDialog(context, "setAnalyticsEnabled success");
  }

  Future<void> _getAAID(BuildContext context) async {
    String? aaid = await hmsAnalytics.getAAID();
    _showDialog(context, "AAID : $aaid");
  }

  Future<void> _getUserProfiles(BuildContext context) async {
    Map<String, dynamic> profiles = await hmsAnalytics.getUserProfiles(true);
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

  Future<void> _setReportPolicies(BuildContext context) async {
    await hmsAnalytics.setReportPolicies(scheduledTime: 90);
    _showDialog(context, "setReportPolicies success");
  }

  Future<void> _getReportPolicyThreshold(BuildContext context) async {
    int? type = await hmsAnalytics
        .getReportPolicyThreshold(ReportPolicyType.ON_SCHEDULED_TIME_POLICY);
    _showDialog(context, "getReportPolicyThreshold $type");
  }

  Future<void> _isRestrictionEnabled(BuildContext context) async {
    bool enabled = await hmsAnalytics.isRestrictionEnabled();
    _showDialog(context, "isRestrictionEnabled $enabled");
  }

  Future<void> _setRestrictionEnabled(BuildContext context) async {
    await hmsAnalytics.setRestrictionEnabled(true);
    _showDialog(context, "setRestrictionEnabled success");
  }

  Future<void> _deleteUserProfile(BuildContext context) async {
    await hmsAnalytics.deleteUserProfile("key");
    _showDialog(context, "deleteUserProfile success");
  }

  Future<void> _deleteUserId(BuildContext context) async {
    await hmsAnalytics.deleteUserId();
    _showDialog(context, "deleteUserId success");
  }

  Future<void> setCollectAdsIdEnabled(BuildContext context) async {
    await hmsAnalytics.setCollectAdsIdEnabled(true);
    _showDialog(context, "setCollectAdsIdEnabled success");
  }

  Future<void> addDefaultEventParams(BuildContext context) async {
    await hmsAnalytics.addDefaultEventParams({
      "param": "value",
    });
    _showDialog(context, "addDefaultEventParams success");
  }

  Future<void> setChannel(BuildContext context) async {
    await hmsAnalytics.setChannel('AppGallery');
    _showDialog(context, "setChannel success");
  }

  Future<void> setPropertyCollection(BuildContext context) async {
    await hmsAnalytics.setPropertyCollection('userAgent', true);
    _showDialog(context, "setPropertyCollection success");
  }

  Future<void> setCustomReferrer(BuildContext context) async {
    await hmsAnalytics.setCustomReferrer('CustomReferrer');
    _showDialog(context, "setCustomReferrer success");
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
            MyBtn("Enable Log", _onEnableLog),
            MyBtn("Enable Log With Level", _onEnableLogWithLevel),
            MyBtn("Set User Id", _setUserId),
            MyBtn("Set User Profile", _setUserProfile),
            MyBtn("Set Push Token", _setPushToken),
            MyBtn("Set Min Activity Sessions", _setMinActivitySessions),
            MyBtn("Set Sessions Duration", _setSessionDuration),
            MyBtn("Send Custom Event", _onCustomEvent),
            MyBtn("Send Predefined Event", _onPredefinedEvent),
            MyBtn("Clear Cached Data", _clearCachedData),
            MyBtn("Delete User Profile", _deleteUserProfile),
            MyBtn("Delete UserId", _deleteUserId),
            MyBtn("SetAnalyticsEnabled", _setAnalyticsEnabled),
            MyBtn("Get AAID", _getAAID),
            MyBtn("Get User Profiles", _getUserProfiles),
            MyBtn("Page Start", _pageStart),
            MyBtn("Page End", _pageEnd),
            MyBtn("setReportPolicies", _setReportPolicies),
            MyBtn("getReportPolicyThreshold", _getReportPolicyThreshold),
            MyBtn("setRestrictionEnabled", _setRestrictionEnabled),
            MyBtn("isRestrictionEnabled", _isRestrictionEnabled),
            MyBtn("setCollectAdsIdEnabled", setCollectAdsIdEnabled),
            MyBtn("addDefaultEventParams", addDefaultEventParams),
            MyBtn("setChannel", setChannel),
            MyBtn("setPropertyCollection", setPropertyCollection),
            MyBtn("setCustomReferrer", setCustomReferrer),
          ],
        ),
      ),
    );
  }
}
