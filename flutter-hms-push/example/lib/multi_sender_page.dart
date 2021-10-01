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
import 'package:huawei_push/huawei_push.dart';

class MultiSenderPage extends StatefulWidget {
  MultiSenderPage({Key? key}) : super(key: key);

  @override
  _MultiSenderPageState createState() => _MultiSenderPageState();
}

class _MultiSenderPageState extends State<MultiSenderPage> {
  @override
  void initState() {
    super.initState();
    Push.getMultiSenderTokenStream
        .listen(_onMultiSenderTokenReceived, onError: _onMultiSenderTokenError);
  }

  void _onMultiSenderTokenReceived(Map<String, dynamic> multiSenderTokenEvent) {
    showResult(
        '[onMultiSenderTokenReceived]' + multiSenderTokenEvent.toString());
  }

  void _onMultiSenderTokenError(dynamic error) {
    showResult('[onMultiSenderTokenError]' + error.toString());
  }

  TextEditingController logTextController = TextEditingController();
  final padding = EdgeInsets.symmetric(vertical: 1.0, horizontal: 10);
  final TextStyle _textStyle = TextStyle(fontSize: 16);
  Widget customTextField(TextEditingController controller, String hintText,
      {EdgeInsets? customPadding}) {
    return Padding(
      padding: customPadding ?? padding,
      child: Container(
        child: TextField(
          controller: controller,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
            ),
            contentPadding: EdgeInsets.zero,
            hintText: hintText,
            hintStyle: TextStyle(fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }

  Widget labelText(String text) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: _textStyle.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _clearLog() {
    setState(() {
      logTextController.text = "";
    });
  }

  Widget customButton(String label, Function() callback, {Color? color}) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: padding.copyWith(top: 0.0, bottom: 0.0),
        child: ElevatedButton(
          onPressed: callback,
          style: ElevatedButton.styleFrom(
            primary: color ?? Colors.grey.shade300,
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ),
      ),
    );
  }

  void showResult(String name, [String? msg = "Button pressed."]) {
    if (msg == null) {
      msg = "";
    }
    appendLog("[" + name + "]" + ": " + msg);
    print("[" + name + "]" + ": " + msg);
    Push.showToast("[" + name + "]: " + msg);
  }

  void appendLog([String msg = "Button pressed."]) {
    setState(() {
      logTextController.text = msg + "\n" + logTextController.text;
    });
  }

  void isSupportProfile() async {
    showResult(
        'isSupportProfile', (await HmsProfile.isSupportProfile()).toString());
  }

  void getMultiSenderTOken() {
    Push.getMultiSenderToken("<subjectId>").then(
      (_) => print("[getMultiSenderToken] Success"),
      onError: (e) => print("[getMultiSenderToken] Error: " + e.toString()),
    );
  }

  void addProfile() async {
    HmsProfile.addProfile(HmsProfile.HUAWEI_PROFILE, "<profileId>").then(
      (_) => print("[addProfile] + Success"),
      onError: (e) => print("[addProfile] Error:" + e.toString()),
    );
    ProxySettings.setCountryCode('<countryCode>');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Push Kit Demo - Multi-Sender',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              customButton(
                'isSupportProfile',
                () => isSupportProfile(),
              ),
            ],
          ),
          Row(
            children: [
              customButton(
                'addProfile',
                () => HmsProfile.addProfile(
                        HmsProfile.HUAWEI_PROFILE, "profile001")
                    .then(
                  (_) => showResult("addProfile", "Success"),
                  onError: (e) => showResult("addProfile Error:", e.toString()),
                ),
              ),
            ],
          ),
          Row(
            children: [
              customButton(
                'addMultiSenderProfile',
                () => HmsProfile.addMultiSenderProfile("<subjectId>",
                        HmsProfile.HUAWEI_PROFILE, "multiSenderProfile001")
                    .then(
                  (_) => showResult("addMultiSenderProfile", "Success"),
                  onError: (e) =>
                      showResult("addMultiSenderProfile Error:", e.toString()),
                ),
              ),
            ],
          ),
          Row(
            children: [
              customButton(
                'deleteProfile',
                () => HmsProfile.deleteProfile("profile001").then(
                  (_) => showResult("deleteProfile", "Success"),
                  onError: (e) =>
                      showResult("deleteProfile Error:", e.toString()),
                ),
              ),
            ],
          ),
          Row(
            children: [
              customButton(
                'deleteMultiSenderProfile',
                () => HmsProfile.deleteMultiSenderProfile(
                        "<subjectId>", "multiSenderProfile001")
                    .then(
                  (_) => showResult("deleteMultiSenderProfile", "Success"),
                  onError: (e) => showResult(
                      "deleteMultiSenderProfile Error:", e.toString()),
                ),
              ),
            ],
          ),
          // Enter the sender app's project id to the subjectId parameter to get the Multi-Sender push token.
          Row(
            children: [
              customButton(
                'getMultiSenderToken',
                () => Push.getMultiSenderToken("<subjectId>").then(
                  (_) => showResult("getMultiSenderToken", "Success"),
                  onError: (e) =>
                      showResult("getMultiSenderToken Error:", e.toString()),
                ),
              ),
            ],
          ),
          // Enter the sender app's project id to the subjectId parameter to delete the obtained Multi-Sender push token.
          Row(
            children: [
              customButton(
                'deleteMultiSenderToken',
                () => Push.deleteMultiSenderToken("<subjectId>").then(
                  (_) => showResult("deleteMultiSenderToken", "Success"),
                  onError: (e) =>
                      showResult("deleteMultiSenderToken Error:", e.toString()),
                ),
              ),
            ],
          ),
          Row(
            children: [customButton('clearLog', () => _clearLog())],
          ),
          Padding(
            padding: padding.copyWith(top: 10.0, bottom: 10.0),
            child: Divider(
              height: 1.0,
              thickness: 2.0,
            ),
          ),
          Padding(
            padding: padding,
            child: TextField(
              controller: logTextController,
              keyboardType: TextInputType.multiline,
              maxLines: 15,
              readOnly: true,
              decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 3.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey, width: 3.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
