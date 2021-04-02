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
import 'package:flutter/services.dart';
import 'package:huawei_location/location/fused_location_provider_client.dart';
import 'package:huawei_location/location/navigation_request.dart';
import 'package:huawei_location/location/navigation_result.dart';

import '../widgets/custom_button.dart' show Btn;
import '../widgets/custom_textinput.dart';

class LocationEnhanceScreen extends StatefulWidget {
  static const String ROUTE_NAME = "LocationEnhanceScreen";

  @override
  _LocationEnhanceScreenState createState() => _LocationEnhanceScreenState();
}

class _LocationEnhanceScreenState extends State<LocationEnhanceScreen> {
  String _topText = "Enter type:\n\t1 for OVERPASS\n\t2 for IS_SUPPORT_EX";

  final FusedLocationProviderClient _locationService =
      FusedLocationProviderClient();
  final TextEditingController _typeTextController = TextEditingController();
  final List<TextInputFormatter> _numWithDecimalFormatter =
      <TextInputFormatter>[
    LengthLimitingTextInputFormatter(1),
    WhitelistingTextInputFormatter(
      RegExp(r"[12]+"),
    ),
  ];

  void _getNavigationContextState(int type) async {
    if (type != null) {
      try {
        final NavigationResult result = await _locationService
            .getNavigationContextState(NavigationRequest(type: type));
        _setTopText(result.toString());
      } on PlatformException catch (e) {
        _setTopText(e.toString());
      }
    }
  }

  void _setTopText([String text = ""]) {
    setState(() {
      _topText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Enhance Service'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 10,
              ),
              height: 90,
              child: Text(_topText),
            ),
            CustomTextInput(
              controller: _typeTextController,
              labelText: "Type",
              hintText: "Enter 1 or 2",
              inputFormatters: _numWithDecimalFormatter,
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
            ),
            Divider(
              thickness: 0.1,
              color: Colors.black,
            ),
            Btn("getNavigationContextState", () {
              _getNavigationContextState(int.parse(_typeTextController.text));
            }),
          ],
        ),
      ),
    );
  }
}
