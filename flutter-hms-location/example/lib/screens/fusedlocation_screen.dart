/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_location/location/fused_location_provider_client.dart';
import 'package:huawei_location/location/hwlocation.dart';
import 'package:huawei_location/location/location.dart';
import 'package:huawei_location/location/location_availability.dart';
import 'package:huawei_location/location/location_request.dart';
import 'package:huawei_location/location/location_settings_request.dart';
import 'package:huawei_location/location/location_settings_states.dart';
import 'package:huawei_location/permission/permission_handler.dart';

import '../screens/location_updates_cb_screen.dart';
import '../screens/location_updates_ex_cb_screen.dart';
import '../screens/location_updates_screen.dart';
import '../widgets/custom_button.dart' show Btn;
import '../widgets/custom_row.dart' show CRow;

class FusedLocationScreen extends StatefulWidget {
  static const String routeName = "FusedLocationScreen";

  @override
  _FusedLocationScreenState createState() => _FusedLocationScreenState();
}

class _FusedLocationScreenState extends State<FusedLocationScreen> {
  PermissionHandler permissionHandler;
  FusedLocationProviderClient locationService;
  Location mockLocation;
  LocationRequest locationRequest;
  List<LocationRequest> locationRequestList;
  LocationSettingsRequest locationSettingsRequest;

  String topText;
  String bottomText;

  @override
  void initState() {
    super.initState();
    initServices();
  }

  void initServices() async {
    topText = "";
    bottomText = "";
    permissionHandler = PermissionHandler();
    locationService = FusedLocationProviderClient();
    locationRequest = LocationRequest();
    locationRequest.interval = 5000;
    locationRequestList = <LocationRequest>[locationRequest];
    mockLocation = Location(latitude: 48.8583, longitude: 2.2945);
    locationSettingsRequest =
        LocationSettingsRequest(requests: locationRequestList);
  }

  void hasPermission() async {
    try {
      bool status = await permissionHandler.hasLocationPermission();
      setState(() {
        topText = "Has permission: $status";
      });
    } catch (e) {
      setState(() {
        topText = e.toString();
      });
    }
  }

  void requestPermission() async {
    try {
      bool status = await permissionHandler.requestLocationPermission();
      setState(() {
        topText = "Is permission granted $status";
      });
    } catch (e) {
      setState(() {
        topText = e.toString();
      });
    }
  }

  void checkLocationSettings() async {
    try {
      LocationSettingsStates states =
          await locationService.checkLocationSettings(locationSettingsRequest);
      setState(() {
        topText = states.toString();
      });
    } catch (e) {
      setState(() {
        topText = e.toString();
      });
    }
  }

  void getLastLocation() async {
    setState(() {
      topText = "";
    });
    try {
      Location location = await locationService.getLastLocation();
      setState(() {
        bottomText = location.toString();
      });
    } catch (e) {
      setState(() {
        topText = e.toString();
      });
    }
  }

  void getLastLocationWithAddress() async {
    setState(() {
      topText = "";
    });
    try {
      HWLocation location =
          await locationService.getLastLocationWithAddress(locationRequest);
      setState(() {
        bottomText = location.toString();
      });
    } catch (e) {
      setState(() {
        topText = e.toString();
      });
    }
  }

  void getLocationAvailability() async {
    setState(() {
      topText = "";
    });
    try {
      LocationAvailability availability =
          await locationService.getLocationAvailability();
      setState(() {
        bottomText = availability.toString();
      });
    } catch (e) {
      setState(() {
        topText = e.toString();
      });
    }
  }

  void setMockModeTrue() async {
    setState(() {
      topText = "";
    });
    try {
      await locationService.setMockMode(true);
      setState(() {
        topText = "Mock mode set to 'true'";
      });
    } on PlatformException catch (e) {
      setState(() {
        topText = e.toString();
      });
    }
  }

  void setMockModeFalse() async {
    setState(() {
      topText = "";
    });
    try {
      await locationService.setMockMode(false);
      setState(() {
        topText = "Mock mode set to 'false'";
      });
    } catch (e) {
      setState(() {
        topText = e.toString();
      });
    }
  }

  void setMockLocation() async {
    setState(() {
      topText = "";
    });
    try {
      await locationService.setMockLocation(mockLocation);
      setState(() {
        topText =
            "Mock location has set lat:${mockLocation.latitude} lng:${mockLocation.longitude}";
      });
    } catch (e) {
      setState(() {
        topText = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fused Location Service'),
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
              child: Text(topText),
            ),
            Divider(
              thickness: 0.1,
              color: Colors.black,
            ),
            CRow(
              children: <Widget>[
                Btn("hasPermission", hasPermission),
                Btn("requestPermission", this.requestPermission),
              ],
            ),
            Btn("checkLocationSettings", checkLocationSettings),
            CRow(
              children: <Widget>[
                Btn("getLastLocation", this.getLastLocation),
                Btn("getLastLocationWithAddress",
                    this.getLastLocationWithAddress)
              ],
            ),
            CRow(children: <Widget>[
              Btn("getLocationAvailability", getLocationAvailability),
              Btn("setMockModeTrue", setMockModeTrue)
            ]),
            CRow(children: <Widget>[
              Btn("setMockModeFalse", setMockModeFalse),
              Btn("setMockLocation", setMockLocation)
            ]),
            Btn("Location Updates", () {
              Navigator.pushNamed(
                context,
                LocationUpdatesScreen.routeName,
              );
            }),
            Btn("Location Updates with Callback", () {
              Navigator.pushNamed(
                context,
                LocationUpdatesCbScreen.routeName,
              );
            }),
            Btn("Location Updates Ex with Callback", () {
              Navigator.pushNamed(
                context,
                LocationUpdatesExCbScreen.routeName,
              );
            }),
            Expanded(
              child: new SingleChildScrollView(
                child: Text(
                  bottomText,
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
