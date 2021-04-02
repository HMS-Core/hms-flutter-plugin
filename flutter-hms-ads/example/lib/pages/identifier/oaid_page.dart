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
import 'package:flutter/material.dart';
import 'package:huawei_ads/hms_ads_lib.dart';
import 'package:huawei_ads_example/utils/constants.dart';

class OaidPage extends StatefulWidget {
  @override
  _OaidPageState createState() => _OaidPageState();
}

class _OaidPageState extends State<OaidPage> {
  AdvertisingIdClientInfo _client;
  String _oaid = '';
  bool _limitAdTracking;
  bool _verified;

  void getAdvertisingIdInfo() async {
    AdvertisingIdClientInfo client =
        await AdvertisingIdClient.getAdvertisingIdInfo();
    setState(() {
      _client = client;
      _oaid = client.getId;
      _limitAdTracking = client.isLimitAdTrackingEnabled;
    });
    testVerifyAdId();
  }

  void testVerifyAdId() async {
    bool isVerified = await AdvertisingIdClient.verifyAdId(
        _oaid, _client.isLimitAdTrackingEnabled);
    setState(() {
      _verified = isVerified;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_client == null) getAdvertisingIdInfo();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Huawei Ads - Identifier OAID',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('OAID', style: Styles.headerTextStyle),
              SizedBox(
                height: 10,
              ),
              Text(
                '$_oaid',
                style: Styles.textContentStyle,
              ),
              SizedBox(
                height: 30,
              ),
              Text('Limit Ad Tracking Enabled', style: Styles.headerTextStyle),
              SizedBox(
                height: 10,
              ),
              Text(
                '${_limitAdTracking ?? ''}',
                style: Styles.textContentStyle,
              ),
              SizedBox(
                height: 30,
              ),
              Text('Verify Ad Id', style: Styles.headerTextStyle),
              SizedBox(
                height: 10,
              ),
              Text(
                '${_verified ?? 'This method takes a long time. You may need to wait a while to see the verification result.'}',
                style: _verified != null
                    ? Styles.textContentStyle
                    : Styles.warningTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _client = null;
  }
}
