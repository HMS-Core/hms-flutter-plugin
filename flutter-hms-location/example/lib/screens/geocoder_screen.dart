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
import 'package:huawei_location/huawei_location.dart';

import 'package:huawei_location_example/widgets/custom_button.dart' show Btn;
import 'package:huawei_location_example/screens/get_from_location_name_screen.dart';
import 'package:huawei_location_example/screens/get_from_location_screen.dart';

class GeocoderScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'GeocoderScreen';

  const GeocoderScreen({Key? key}) : super(key: key);

  @override
  State<GeocoderScreen> createState() => _GeocoderScreenState();
}

class _GeocoderScreenState extends State<GeocoderScreen> {
  final GeocoderService _geocoderService = GeocoderService();
  @override
  void initState() {
    _initGeocoderService();
    super.initState();
  }

  _initGeocoderService() async {
    await _geocoderService.initGeocoderService(Locale(
      language: 'en',
      country: 'US',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geocoder Screen'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Divider(
              thickness: 0.1,
              color: Colors.black,
            ),
            Center(
              child: Column(
                children: const <Widget>[
                  Text('Reverse geocoding request'),
                  SizedBox(height: 15)
                ],
              ),
            ),
            Btn('Get From Location', () {
              Navigator.pushNamed(
                context,
                GetFromLocationScreen.ROUTE_NAME,
              );
            }),
            const Divider(
              thickness: 0.1,
              color: Colors.black,
            ),
            Center(
              child: Column(
                children: const <Widget>[
                  Text('Forward geocoding request information'),
                  SizedBox(height: 15)
                ],
              ),
            ),
            Btn('Get From Location Name', () {
              Navigator.pushNamed(
                context,
                GetFromLocationNameScreen.ROUTE_NAME,
              );
            }),
            const Divider(
              thickness: 0.1,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
