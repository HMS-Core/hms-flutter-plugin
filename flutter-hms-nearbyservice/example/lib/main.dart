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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_nearbyservice_example/pages/discovery_transfer_page.dart';
import 'package:huawei_nearbyservice_example/pages/message_page.dart';
import 'package:huawei_nearbyservice_example/pages/nearby_menu_page.dart';
import 'package:huawei_nearbyservice_example/pages/beacon_scanning_page.dart';
import 'package:huawei_nearbyservice_example/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ],
  );
  await requestPermissions();
  runApp(const HmsNearbyDemo());
}

// TODO: Please implement your own 'Permission Handler'.
Future<void> requestPermissions() async {
  // Huawei Nearby Service needs some permissions to work properly.
  // You are expected to handle these permissions to use Huawei Nearby Service Demo.

  // You can learn more about the required permissions from our official documentations.
  // https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/dev-process-0000001073825475?ha_source=hms1
}

class HmsNearbyDemo extends StatelessWidget {
  const HmsNearbyDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.blue,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            fontSize: 22.0,
            color: Colors.white,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      initialRoute: Routes.menuPage,
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const NearbyMenuPage(),
        Routes.discoveryAndTransfer: (BuildContext context) =>
            const DiscoveryTransferPage(),
        Routes.message: (BuildContext context) => const MessagingPage(),
        Routes.beaconScan: (BuildContext context) => const BeaconScanningPage(),
      },
    );
  }
}
