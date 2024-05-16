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

import 'package:huawei_location_example/widgets/custom_button.dart' show Btn;
import 'package:huawei_location_example/screens/convert_coordinate_screen.dart';

class LocationUtilsScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'LocationUtilsScreen';

  const LocationUtilsScreen({Key? key}) : super(key: key);

  @override
  State<LocationUtilsScreen> createState() => _LocationUtilsScreenState();
}

class _LocationUtilsScreenState extends State<LocationUtilsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Utils Screen'),
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
                  Text('Obtains the coordinate type of the current location.'),
                  SizedBox(height: 15)
                ],
              ),
            ),
            Btn(
              'Convert Coordinate',
              () {
                Navigator.pushNamed(
                  context,
                  ConvertCoordinateScreen.ROUTE_NAME,
                );
              },
            ),
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
