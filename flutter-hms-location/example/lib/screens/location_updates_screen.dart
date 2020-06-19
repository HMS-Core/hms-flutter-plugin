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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:huawei_location/location/fused_location_provider_client.dart';
import 'package:huawei_location/location/location.dart';
import 'package:huawei_location/location/location_request.dart';

import '../widgets/custom_button.dart' show Btn;

class LocationUpdatesScreen extends StatefulWidget {
  static const String routeName = "LocationUpdatesScreen";

  @override
  _LocationUpdatesScreenState createState() => _LocationUpdatesScreenState();
}

class _LocationUpdatesScreenState extends State<LocationUpdatesScreen> {
  FusedLocationProviderClient locationService;
  LocationRequest locationRequest;
  StreamSubscription<Location> streamSubs;

  String topText;
  String bottomText;
  int requestCode;

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
    streamSubs = locationService.onLocationData.listen((location) {
      setState(() {
        bottomText = bottomText + '\n' + location.toString();
      });
    });
  }

  void requestLocationUpdates() async {
    if (requestCode == null) {
      try {
        int _requestCode =
            await locationService.requestLocationUpdates(locationRequest);
        requestCode = _requestCode;
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

  void removeLocationUpdates() async {
    if (requestCode != null) {
      try {
        await locationService.removeLocationUpdates(requestCode);
        requestCode = null;
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
        topText = "requestCode does not exist. Request location updates first";
      });
    }
  }

  void removeLocationUpdatesOnDispose() async {
    if (requestCode != null) {
      try {
        await locationService.removeLocationUpdates(requestCode);
        requestCode = null;
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Updates'),
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
            Btn("Request Location Updates", requestLocationUpdates),
            Btn("Remove Location Updates", removeLocationUpdates),
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
    streamSubs.cancel();
  }
}
