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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:huawei_nearbyservice/huawei_nearbyservice.dart';
import 'package:huawei_nearbyservice_example/widgets/custom_buttons.dart';

class BeaconScanningPage extends StatelessWidget {
  const BeaconScanningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beacon Registering Task (Beta)'),
      ),
      body: const BeaconScanningPageContent(),
    );
  }
}

class BeaconScanningPageContent extends StatefulWidget {
  const BeaconScanningPageContent({Key? key}) : super(key: key);

  @override
  State<BeaconScanningPageContent> createState() =>
      _BeaconScanningPageContentState();
}

class _BeaconScanningPageContentState extends State<BeaconScanningPageContent> {
  TextEditingController _beaconIdController = TextEditingController();
  TextEditingController _beaconTypeController = TextEditingController();
  TextEditingController _namespaceController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  late StreamSubscription<Beacon> _streamSubscription;
  String _logs = 'Double tap to clear the logs.\n';

  @override
  void initState() {
    _streamSubscription =
        HMSBeaconEngine.instance.getBeaconBroadcastStream!.listen((event) {
      print(event.toString());
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _beaconIdController.text = '5dc33487f02e477d40';
    _beaconTypeController.text = '1';
    _namespaceController.text = 'dev91050203040506';
    _typeController.text = 'HMS';

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextField(
                    controller: _beaconIdController,
                    hintText: 'Beacon Id',
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CustomTextField(
                    controller: _beaconTypeController,
                    hintText: 'Beacon Type',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextField(
                    controller: _namespaceController,
                    hintText: 'Namespace',
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CustomTextField(
                    controller: _typeController,
                    hintText: 'Type',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: CustomButton(
                text: 'registerBeaconScan',
                onPressed: () async {
                  BeaconPicker _beaconPicker = BeaconPicker(
                    beaconId: _beaconIdController.text,
                    beaconType: int.parse(_beaconTypeController.text),
                    namespace: _namespaceController.text,
                    type: _typeController.text,
                  );
                  await HMSBeaconEngine.instance
                      .registerScanTask(_beaconPicker);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: CustomButton(
                text: 'unRegisterBeaconScan',
                onPressed: () async {
                  await HMSBeaconEngine.instance.unRegisterScanTask();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: CustomButton(
                text: 'getBeaconMsgConditions',
                onPressed: () async {
                  List<BeaconMsgCondition> list =
                      (await HMSBeaconEngine.instance.getBeaconMsgConditions());
                  setState(() {
                    _logs = list.toString() + '\n' + _logs;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: CustomButton(
                  text: 'getRawBeaconConditions',
                  onPressed: () async {
                    List<RawBeaconCondition> list = await HMSBeaconEngine
                        .instance
                        .getRawBeaconConditions(beaconType: 1);
                    setState(() {
                      _logs = list.toString() + '\n' + _logs;
                    });
                  }),
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade800,
                  width: 2.0,
                ),
              ),
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Center(
                child: GestureDetector(
                  onDoubleTap: () => setState(() => _logs = ''),
                  child: SingleChildScrollView(
                    child: Text(_logs),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  const CustomTextField({
    required this.controller,
    Key? key,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
