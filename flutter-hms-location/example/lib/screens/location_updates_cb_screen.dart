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
import 'package:huawei_location/location/fused_location_provider_client.dart';
import 'package:huawei_location/location/location_availability.dart';
import 'package:huawei_location/location/location_callback.dart';
import 'package:huawei_location/location/location_request.dart';
import 'package:huawei_location/location/location_result.dart';

import '../widgets/custom_button.dart' show Btn;

class LocationUpdatesCbScreen extends StatefulWidget {
  static const String routeName = "LocationUpdatesCbScreen";

  @override
  _LocationUpdatesCbScreenState createState() =>
      _LocationUpdatesCbScreenState();
}

class _LocationUpdatesCbScreenState extends State<LocationUpdatesCbScreen> {
  String topText;
  String bottomText;
  int callbackId;
  FusedLocationProviderClient locationService;
  LocationRequest locationRequest;
  LocationCallback locationCallback;

  @override
  void initState() {
    super.initState();
    initServices();
  }

  void initServices() {
    topText = "";
    bottomText = "";
    locationService = FusedLocationProviderClient();
    locationRequest = LocationRequest();
    locationRequest.interval = 5000;
    locationCallback = LocationCallback(
      onLocationResult: _onLocationResult,
      onLocationAvailability: _onLocationAvailability,
    );
  }

  void _onLocationResult(LocationResult res) {
    setState(() {
      bottomText = bottomText + "\n\n" + res.toString();
    });
  }

  void _onLocationAvailability(LocationAvailability availability) {
    setState(() {
      bottomText = bottomText + "\n\n" + availability.toString();
    });
  }

  void requestLocationUpdatesCb() async {
    if (callbackId == null) {
      try {
        int _callbackId = await locationService.requestLocationUpdatesCb(
            locationRequest, locationCallback);
        callbackId = _callbackId;
        setState(() {
          topText = "Location updates requested successfully";
        });
      } catch (e) {
        setState(() {
          topText = e.toString();
        });
      }
    } else {
      setState(() {
        topText =
            "Already requested location updates. Try removing location updates";
      });
    }
  }

  void removeLocationUpdatesCb() async {
    if (callbackId != null) {
      try {
        await locationService.removeLocationUpdatesCb(callbackId);
        callbackId = null;
        setState(() {
          topText = "Location updates are removed successfully";
          bottomText = "";
        });
      } catch (e) {
        setState(() {
          topText = e.toString();
        });
      }
    } else {
      setState(() {
        topText = "callbackId does not exist. Request location updates first";
      });
    }
  }

  void removeLocationUpdatesOnDispose() async {
    if (callbackId != null) {
      try {
        await locationService.removeLocationUpdatesCb(callbackId);
        callbackId = null;
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Updates with CB'),
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
            Btn("Request Location Updates w Callback",
                requestLocationUpdatesCb),
            Btn("Remove Location Updates", removeLocationUpdatesCb),
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
    removeLocationUpdatesOnDispose();
  }
}
