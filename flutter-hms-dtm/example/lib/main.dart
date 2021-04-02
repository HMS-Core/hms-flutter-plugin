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
import 'package:huawei_dtm/huawei_dtm.dart';

import 'widgets/custom_button.dart';
import 'widgets/custom_appbar.dart';
import 'keys.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var subscription;
  bool _showFourthButton = false;

  @override
  void initState() {
    subscription = HMSDTM.customTagStream.listen((event) {
      print("Custom Tag response: " + event.toString());

      /*
        The condition to detect the tag for setting the custom variable.
       */
      if (event['price'] != null) {
        _setCustomVariable(event);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.black),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: customAppBar(
          title: 'HMS DTM Kit Flutter Demo',
        ),
        body: Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CustomButton(
                key: Key(Keys.SEND_CUSTOM_EVENT),
                title: "Send Custom Event",
                onPressed: _sendCustomEvent,
              ),
              CustomButton(
                key: Key(Keys.CUSTOM_TAG),
                title: "Custom Tag",
                onPressed: _customTag,
              ),
              CustomButton(
                key: Key(Keys.SET_CUSTOM_VARIABLE_VALUE),
                title: "Set Custom Variable Value",
                onPressed: () {
                  _customVariableWithTag();
                  setState(() {
                    _showFourthButton = true;
                  });
                },
              ),
              _showFourthButton
                  ? CustomButton(
                      key: Key(Keys.REPORT_EVENT_WITH_CUSTOM_VARIABLE),
                      title: "Report Event with Custom Variable",
                      onPressed: _reportEventWithCustomVariable,
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  _sendCustomEvent() async {
    try {
      const eventName = "Platform";
      const bundle = {
        "platformName": "Flutter",
      };
      await HMSDTM.onEvent(eventName, bundle);
    } catch (e) {
      print("SendCustomEvent error: " + e.toString());
    }
  }

  _customTag() async {
    try {
      const eventName = "PurchaseShoes";
      await HMSDTM.onEvent(eventName, Map<String, dynamic>());
    } catch (e) {
      print("CustomTag error: " + e.toString());
    }
  }

  _customVariableWithTag() async {
    try {
      const eventName = "SetPantsPrice";
      await HMSDTM.onEvent(eventName, Map<String, dynamic>());
    } catch (e) {
      print("CustomVariableWithTag error: " + e.toString());
    }
  }

  _setCustomVariable(Map map) async {
    try {
      var price = double.parse(map['price']);
      var discount = double.parse(map['discount']);
      var newPrice = price - (price / 100 * discount);
      await HMSDTM.setCustomVariable("PantsPrice", newPrice);
    } catch (e) {
      print("SetCustomVariable error: " + e.toString());
    }
  }

  _reportEventWithCustomVariable() async {
    try {
      const eventName = "PurchasePants";
      await HMSDTM.onEvent(eventName, Map<String, dynamic>());
    } catch (e) {
      print("ReportEventWithCustomVariable error: " + e.toString());
    }
  }
}
