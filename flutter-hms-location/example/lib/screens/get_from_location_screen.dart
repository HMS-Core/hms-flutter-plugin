/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_location/huawei_location.dart';

import 'package:huawei_location_example/widgets/custom_button.dart' show Btn;
import 'package:huawei_location_example/widgets/custom_textinput.dart';

class GetFromLocationScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'GetFromLocationScreen';

  const GetFromLocationScreen({Key? key}) : super(key: key);

  @override
  State<GetFromLocationScreen> createState() => _GetFromLocationScreenState();
}

class _GetFromLocationScreenState extends State<GetFromLocationScreen> {
  String _bottomText = '';
  late GetFromLocationRequest _getFromLocationRequest;
  final GeocoderService _geocoderService = GeocoderService();
  final TextEditingController _lat = TextEditingController(text: '40');
  final TextEditingController _lng = TextEditingController(text: '30');
  final TextEditingController _maxResults = TextEditingController(text: '3');

  final List<FilteringTextInputFormatter> _numWithDecimalFormatter =
      <FilteringTextInputFormatter>[
    FilteringTextInputFormatter.allow(
      RegExp(r'[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)'),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _getFromLocation() async {
    _setBottomText();
    final double latitude = double.parse(_lat.text);
    final double longitude = double.parse(_lng.text);
    final int maxResults = int.parse(_maxResults.text);

    _getFromLocationRequest = GetFromLocationRequest(
      latitude: latitude,
      longitude: longitude,
      maxResults: maxResults,
    );

    try {
      final List<HWLocation> hwLocationList =
          await _geocoderService.getFromLocation(
        _getFromLocationRequest,
      );
      _setBottomText(hwLocationList.toString());
    } on PlatformException catch (e) {
      _setBottomText(e.toString());
    }
  }

  void _setBottomText([String text = '']) {
    setState(() {
      _bottomText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('From Location Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CustomTextInput(
                    controller: _lat,
                    labelText: 'Latitude',
                    inputFormatters: _numWithDecimalFormatter,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                  ),
                  CustomTextInput(
                    controller: _lng,
                    labelText: 'Longitude',
                    inputFormatters: _numWithDecimalFormatter,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                  ),
                  CustomTextInput(
                    controller: _maxResults,
                    labelText: 'Max Results',
                    inputFormatters: _numWithDecimalFormatter,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                  ),
                  Btn('GET', _getFromLocation),
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 15),
                          Text(
                            _bottomText,
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
