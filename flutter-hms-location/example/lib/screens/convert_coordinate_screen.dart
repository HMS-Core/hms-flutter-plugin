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

class ConvertCoordinateScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'ConvertCoordinateScreen';

  const ConvertCoordinateScreen({Key? key}) : super(key: key);

  @override
  State<ConvertCoordinateScreen> createState() =>
      _ConvertCoordinateScreenState();
}

class _ConvertCoordinateScreenState extends State<ConvertCoordinateScreen> {
  late LonLat _lonLat;
  String _bottomText = '';
  final LocationUtils _locationUtils = LocationUtils();

  final TextEditingController _latitudeTextEditingController =
      TextEditingController(text: '0');
  final TextEditingController _longitudeTextEditingController =
      TextEditingController(text: '0');
  final TextEditingController _coordTypeTextEditingController =
      TextEditingController(text: '1');

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

  void _convertCoordinate() async {
    _setBottomText();
    final int coordType = int.parse(_coordTypeTextEditingController.text);
    final double latitude = double.parse(_latitudeTextEditingController.text);
    final double longitude = double.parse(_longitudeTextEditingController.text);

    try {
      _lonLat = await _locationUtils.convertCoord(
        latitude,
        longitude,
        coordType,
      );

      _setBottomText(_lonLat.toString());
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
        title: const Text('Convert Coordinate Screen'),
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
                    controller: _coordTypeTextEditingController,
                    labelText: 'Coord Type',
                    inputFormatters: _numWithDecimalFormatter,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                  ),
                  CustomTextInput(
                    controller: _longitudeTextEditingController,
                    labelText: 'Longitude',
                    inputFormatters: _numWithDecimalFormatter,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                  ),
                  CustomTextInput(
                    controller: _latitudeTextEditingController,
                    labelText: 'Latitude',
                    inputFormatters: _numWithDecimalFormatter,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                  ),
                  Btn('convertCoordinate', _convertCoordinate),
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
