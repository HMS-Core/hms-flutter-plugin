/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';
import 'package:flutter/foundation.dart';

class HmsAvailabilityDemo extends StatefulWidget {
  @override
  _HmsAvailabilityDemoState createState() => _HmsAvailabilityDemoState();
}

class _HmsAvailabilityDemoState extends State<HmsAvailabilityDemo> {
  HmsApiAvailability hmsApiAvailability;

  String _result = "HMS availability result code: unknown";
  List<String> _eventList = ["Availability result events will be listed"];

  @override
  void initState() {
    super.initState();
    // Create an instance
    hmsApiAvailability = new HmsApiAvailability();
  }

  _getAvailability() async {
    try {
      final int res = await hmsApiAvailability.isHMSAvailableWithApkVersion(28);
      setState(() => _result = "Availability result code: $res");
      if (res != 0) {
        _getErrorDialog(res);
      }
    } on Exception catch (e) {
      _updateList(e.toString());
    } on Error catch (e) {
      _updateList(e.toString());
    }
  }

  _getErrorDialog(int code) {
    // Set a listener to track events for activity results and dialog cancellations
    hmsApiAvailability.setResultListener = ((AvailabilityEvent event) {
      _updateList("Availability event: " + describeEnum(event));
    });

    try {
      hmsApiAvailability.getErrorDialog(code, 1000, true);
    } on Exception catch (e) {
      _updateList(e.toString());
    } on Error catch (e) {
      _updateList(e.toString());
    }
  }

  _updateList(String s) {
    setState(() => _eventList.add(s));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hms Availability Demo")),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(_result),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: RaisedButton(
                  color: Color(0xff394867),
                  textColor: Colors.white,
                  child: Text("Check Hms Core Availability"),
                  onPressed: _getAvailability),
            ),
            Divider(color: Colors.black),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListView.builder(
                    itemCount: _eventList.length,
                    itemBuilder: (ctx, index) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(_eventList[index],
                            style: TextStyle(
                                fontWeight: index == 0
                                    ? FontWeight.bold
                                    : FontWeight.normal)),
                      ));
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    hmsApiAvailability.destroyStreams();
    super.dispose();
  }
}
