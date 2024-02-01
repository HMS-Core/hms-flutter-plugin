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
import 'package:huawei_analytics/huawei_analytics.dart';

void main() {
  runApp(const MaterialApp(home: MyHomePage()));
}

class MyBtn extends StatelessWidget {
  final String title;
  final Function _onPress;

  const MyBtn(this.title, this._onPress, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
      color: Colors.white,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: () async {
          _onPress();
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _appTitle = 'Huawei HMS Analytics Flutter  Demo';

  late HMSAnalytics hmsAnalytics;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    hmsAnalytics = await HMSAnalytics.getInstance();
  }

  void _showDialog(String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Result'),
          content: SingleChildScrollView(child: Text(content)),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _onEnableLog() async {
    await hmsAnalytics.enableLog();
    _showDialog('enableLog success');
  }

  Future<void> _onEnableLogWithLevel() async {
    // Possible options DEBUG, INFO, WARN, ERROR
    await hmsAnalytics.enableLogWithLevel('INFO');
    _showDialog('enableLogWithLevel success');
  }

  Future<void> _setUserId() async {
    await hmsAnalytics.setUserId('userId');
    _showDialog('setUserId success');
  }

  Future<void> _setUserProfile() async {
    await hmsAnalytics.setUserProfile('key', 'value');
    _showDialog('setUserProfile success');
  }

  Future<void> _setPushToken() async {
    await hmsAnalytics.setPushToken('<your_token>');
    _showDialog('setPushToken success');
  }

  Future<void> _setMinActivitySessions() async {
    await hmsAnalytics.setMinActivitySessions(1000);
    _showDialog('setMinActivitySessions success');
  }

  Future<void> _setSessionDuration() async {
    await hmsAnalytics.setSessionDuration(1000);
    _showDialog('setSessionDuration success');
  }

  Future<void> _onCustomEvent() async {
    String name = 'my_custom_event';

    Map<String, dynamic> customEvent = <String, dynamic>{
      'string_value': 'analytics',
      'integer_value': '42',
      'long_value': 4294967298,
      'double_value': 4.2,
      'boolean_value': true,
      // "list_of_integers": <int>[1, 2, 3, 4, 5, 6, 10], // You can only send one list at a time.
      'list_of_strings': <String>['Huawei', 'Analytics'],
      'inner_bundle_example': <String, dynamic>{
        'string_val': 'hms',
        'int_val': 23,
      },
    };

    await hmsAnalytics.onEvent(name, customEvent);
    _showDialog('onEvent success');
  }

  Future<void> _onPredefinedEvent() async {
    String name = HAEventType.SUBMITSCORE;
    dynamic value = <String, dynamic>{
      HAParamType.SCORE: 12,
    };

    await hmsAnalytics.onEvent(name, value);
    _showDialog('onEvent success');
  }

  Future<void> _clearCachedData() async {
    await hmsAnalytics.clearCachedData();
    _showDialog('clearCachedData success');
  }

  Future<void> _setAnalyticsEnabled() async {
    await hmsAnalytics.setAnalyticsEnabled(true);
    _showDialog('setAnalyticsEnabled success');
  }

  Future<void> _getAAID() async {
    String? aaid = await hmsAnalytics.getAAID();
    _showDialog('AAID : $aaid');
  }

  Future<void> _getUserProfiles() async {
    Map<String, dynamic> profiles = await hmsAnalytics.getUserProfiles(true);
    _showDialog('User Profiles : $profiles');
  }

  Future<void> _pageStart() async {
    await hmsAnalytics.pageStart('pageName', 'pageClassOverride');
    _showDialog('pageStart success');
  }

  Future<void> _pageEnd() async {
    await hmsAnalytics.pageEnd('pageName');
    _showDialog('pageEnd success');
  }

  Future<void> _setReportPolicies() async {
    await hmsAnalytics.setReportPolicies(scheduledTime: 90);
    _showDialog('setReportPolicies success');
  }

  Future<void> _getReportPolicyThreshold() async {
    int? type = await hmsAnalytics
        .getReportPolicyThreshold(ReportPolicyType.ON_SCHEDULED_TIME_POLICY);
    _showDialog('getReportPolicyThreshold $type');
  }

  Future<void> _isRestrictionEnabled() async {
    bool enabled = await hmsAnalytics.isRestrictionEnabled();
    _showDialog('isRestrictionEnabled $enabled');
  }

  Future<void> _setRestrictionEnabled() async {
    await hmsAnalytics.setRestrictionEnabled(true);
    _showDialog('setRestrictionEnabled success');
  }

  Future<void> _deleteUserProfile() async {
    await hmsAnalytics.deleteUserProfile('key');
    _showDialog('deleteUserProfile success');
  }

  Future<void> _deleteUserId() async {
    await hmsAnalytics.deleteUserId();
    _showDialog('deleteUserId success');
  }

  Future<void> _setCollectAdsIdEnabled() async {
    await hmsAnalytics.setCollectAdsIdEnabled(true);
    _showDialog('setCollectAdsIdEnabled success');
  }

  Future<void> _addDefaultEventParams() async {
    await hmsAnalytics.addDefaultEventParams(
      <String, Object>{
        'param': 'value',
      },
    );
    _showDialog('addDefaultEventParams success');
  }

  Future<void> _setChannel() async {
    await hmsAnalytics.setChannel('AppGallery');
    _showDialog('setChannel success');
  }

  Future<void> _setPropertyCollection() async {
    await hmsAnalytics.setPropertyCollection('userAgent', true);
    _showDialog('setPropertyCollection success');
  }

  Future<void> _setCustomReferrer() async {
    await hmsAnalytics.setCustomReferrer('CustomReferrer');
    _showDialog('setCustomReferrer success');
  }

  Future<void> _getDataUploadSiteInfo() async {
    String? dataUploadSiteInfo = await hmsAnalytics.getDataUploadSiteInfo();
    _showDialog('DataUploadSiteInfo : $dataUploadSiteInfo');
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
            MyBtn('Enable Log', _onEnableLog),
            MyBtn('Enable Log With Level', _onEnableLogWithLevel),
            MyBtn('Set User Id', _setUserId),
            MyBtn('Set User Profile', _setUserProfile),
            MyBtn('Set Push Token', _setPushToken),
            MyBtn('Set Min Activity Sessions', _setMinActivitySessions),
            MyBtn('Set Sessions Duration', _setSessionDuration),
            MyBtn('Send Custom Event', _onCustomEvent),
            MyBtn('Send Predefined Event', _onPredefinedEvent),
            MyBtn('Clear Cached Data', _clearCachedData),
            MyBtn('Delete User Profile', _deleteUserProfile),
            MyBtn('Delete UserId', _deleteUserId),
            MyBtn('Set Analytics Enabled', _setAnalyticsEnabled),
            MyBtn('Get AAID', _getAAID),
            MyBtn('Get User Profiles', _getUserProfiles),
            MyBtn('Page Start', _pageStart),
            MyBtn('Page End', _pageEnd),
            MyBtn('Set Report Policies', _setReportPolicies),
            MyBtn('Get Report Policy Threshold', _getReportPolicyThreshold),
            MyBtn('Set Restriction Enabled', _setRestrictionEnabled),
            MyBtn('Is Restriction Enabled', _isRestrictionEnabled),
            MyBtn('Set Collect Ads Id Enabled', _setCollectAdsIdEnabled),
            MyBtn('Add Default Event Params', _addDefaultEventParams),
            MyBtn('Set Channel', _setChannel),
            MyBtn('Set Property Collection', _setPropertyCollection),
            MyBtn('Set Custom Referrer', _setCustomReferrer),
            MyBtn('Get Data Upload Site Info', _getDataUploadSiteInfo),
          ],
        ),
      ),
    );
  }
}
