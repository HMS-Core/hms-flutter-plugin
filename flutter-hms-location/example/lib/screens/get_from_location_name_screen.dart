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

class GetFromLocationNameScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'GetFromLocationNameScreen';

  const GetFromLocationNameScreen({Key? key}) : super(key: key);

  @override
  State<GetFromLocationNameScreen> createState() =>
      _GetFromLocationNameScreenState();
}

class _GetFromLocationNameScreenState extends State<GetFromLocationNameScreen> {
  String _bottomText = '';
  late GetFromLocationNameRequest _getFromLocationNameRequest;
  final GeocoderService _geocoderService = GeocoderService();
  final TextEditingController _name = TextEditingController(
    text: 'Changjiang Community, Huannan Road, Binjiang District,'
        'Hangzhou City,Zhejiang Province',
  );
  final TextEditingController _maxResultsForName =
      TextEditingController(text: '3');
  final TextEditingController _lowerLat = TextEditingController(text: '0');
  final TextEditingController _lowerLng = TextEditingController(text: '0');
  final TextEditingController _upperLat = TextEditingController(text: '0');
  final TextEditingController _upperLng = TextEditingController(text: '0');

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

  void _getFromLocationName() async {
    _setBottomText();
    final String locationName = _name.text;
    final int maxResults = int.parse(_maxResultsForName.text);
    final double lowerLeftLatitude = double.parse(_lowerLat.text);
    final double lowerLeftLongitude = double.parse(_lowerLng.text);
    final double upperRightLatitude = double.parse(_lowerLat.text);
    final double upperRightLongitude = double.parse(_lowerLng.text);

    _getFromLocationNameRequest = GetFromLocationNameRequest(
      locationName: locationName,
      maxResults: maxResults,
      lowerLeftLatitude: lowerLeftLatitude,
      lowerLeftLongitude: lowerLeftLongitude,
      upperRightLatitude: upperRightLatitude,
      upperRightLongitude: upperRightLongitude,
    );

    try {
      final List<HWLocation> hwLocationNameList =
          await _geocoderService.getFromLocationName(
        _getFromLocationNameRequest,
      );
      _setBottomText(hwLocationNameList.toString());
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
        title: const Text('From Location Name Screen'),
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
                    controller: _name,
                    labelText: 'Location Name',
                    keyboardType: TextInputType.text,
                  ),
                  CustomTextInput(
                    controller: _maxResultsForName,
                    labelText: 'Max Results',
                    inputFormatters: _numWithDecimalFormatter,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                  ),
                  CustomTextInput(
                    controller: _lowerLat,
                    labelText: 'Lower Left Latitude',
                    inputFormatters: _numWithDecimalFormatter,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                  ),
                  CustomTextInput(
                    controller: _lowerLng,
                    labelText: 'Lower Left Longitude',
                    inputFormatters: _numWithDecimalFormatter,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                  ),
                  CustomTextInput(
                    controller: _upperLat,
                    labelText: 'Upper Right Latitude',
                    inputFormatters: _numWithDecimalFormatter,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                  ),
                  CustomTextInput(
                    controller: _upperLng,
                    labelText: 'Upper Right Longitude',
                    inputFormatters: _numWithDecimalFormatter,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                  ),
                  Btn('GET', _getFromLocationName),
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
