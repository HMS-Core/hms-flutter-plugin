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
import 'package:huawei_nearbyservice/huawei_nearbyservice.dart';
import 'package:huawei_nearbyservice_example/pages/discovery_transfer_page.dart';
import 'package:huawei_nearbyservice_example/pages/message_page.dart';
import 'package:huawei_nearbyservice_example/pages/nearby_menu_page.dart';
import 'package:huawei_nearbyservice_example/pages/wifi_share_page.dart';
import 'utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  requestPermissions();
  runApp(HmsNearbyDemo());
}

class HmsNearbyDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.menuPage,
      routes: {
        '/': (context) => NearbyMenuPage(),
        Routes.discoveryAndTransfer: (context) => DiscoveryTransferPage(),
        Routes.wifi: (context) => WifiSharePage(),
        Routes.message: (context) => MessagingPage(),
      },
    );
  }
}

void requestPermissions() async {
  List<NearbyPermission> permissions = List<NearbyPermission>();
  bool location = await NearbyPermissionHandler.hasLocationPermission();
  print('Location Permission : $location');
  if (!location) {
    permissions.add(NearbyPermission.location);
  }

  bool storage = await NearbyPermissionHandler.hasExternalStoragePermission();
  print('Storage Permission : $storage');
  if (!storage) {
    permissions.add(NearbyPermission.externalStorage);
  }

  if (permissions.length != 0) {
    await NearbyPermissionHandler.requestPermission(permissions);
  }
}
