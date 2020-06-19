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
import 'package:flutter/services.dart';
import 'package:huawei_location/geofence/geofence.dart';
import 'package:huawei_location/location/fused_location_provider_client.dart';
import 'package:huawei_location/location/location_callback.dart';
import 'package:huawei_location/location/location_request.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_textinput.dart';

class AddGeofenceScreen extends StatefulWidget {
  static const String routeName = "AddGeofenceScreen";

  @override
  _AddGeofenceScreenState createState() => _AddGeofenceScreenState();
}

class _AddGeofenceScreenState extends State<AddGeofenceScreen> {
  String topText;
  String bottomText;
  int fenceCount;
  int callbackId;

  TextEditingController _lat;
  TextEditingController _lng;
  TextEditingController _rad;
  TextEditingController _uid;
  TextEditingController _conversions;
  TextEditingController _validTime;
  TextEditingController _dwellTime;
  TextEditingController _notifInterval;

  List<Geofence> geofenceList;
  List<String> geofenceIdList;

  List<TextInputFormatter> numWithDecimalFormatter = <TextInputFormatter>[
    WhitelistingTextInputFormatter(
        RegExp(r"[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)")),
  ];

  List<TextInputFormatter> digitsOnlyFormatter = <TextInputFormatter>[
    WhitelistingTextInputFormatter.digitsOnly,
  ];

  FusedLocationProviderClient locationService;
  LocationCallback locCallback;

  @override
  void initState() {
    super.initState();
    initialValues();
    getGeofenceFromRoute();
  }

  void initialValues() {
    topText = "";
    bottomText = "";
    fenceCount = 0;
    _lat = TextEditingController();
    _lng = TextEditingController();
    _rad = TextEditingController(text: "60");
    _uid = TextEditingController();
    _conversions = TextEditingController(text: "5");
    _validTime = TextEditingController(text: "1000000");
    _dwellTime = TextEditingController(text: "10000");
    _notifInterval = TextEditingController(text: "100");
    locationService = FusedLocationProviderClient();
    locCallback = LocationCallback(onLocationResult: (locationRes) {
      _lat.text = locationRes.locations.last.latitude.toString();
      _lng.text = locationRes.locations.last.longitude.toString();
    });
  }

  void getGeofenceFromRoute() {
    Future.delayed(Duration.zero, () {
      Map<String, Object> args = ModalRoute.of(context).settings.arguments;
      geofenceList = args['geofenceList'];
      geofenceIdList = args['geofenceIdList'];
      setState(() {
        bottomText = geofenceIdList.toString();
        fenceCount = geofenceIdList.length;
      });
    });
  }

  void addGeofence() {
    try {
      String uniqueId = _uid.text;

      if (uniqueId == '') {
        setState(() {
          topText = "UniqueId cannot be empty.";
        });
      } else if (geofenceIdList.contains(uniqueId)) {
        setState(() {
          topText = "Geofence with this UniqueId already exists.";
        });
      } else {
        int conversions = int.parse(_conversions.text);
        int validDuration = int.parse(_validTime.text);
        double latitude = double.parse(_lat.text);
        double longitude = double.parse(_lng.text);
        double radius = double.parse(_rad.text);
        int notificationInterval = int.parse(_notifInterval.text);
        int dwellDelayTime = int.parse(_dwellTime.text);

        Geofence geofence = Geofence(
          uniqueId: uniqueId,
          conversions: conversions,
          validDuration: validDuration,
          latitude: latitude,
          longitude: longitude,
          radius: radius,
          notificationInterval: notificationInterval,
          dwellDelayTime: dwellDelayTime,
        );

        geofenceList.add(geofence);
        geofenceIdList.add(geofence.uniqueId);

        setState(() {
          fenceCount++;
          bottomText = geofenceIdList.toString();
          topText = "Geofence added successfully.";
        });
      }
    } catch (e) {
      setState(() {
        topText = e.toString();
      });
    }
  }

  void removeLocationUpdatesCb(int callbackId) async {
    try {
      await locationService.removeLocationUpdatesCb(callbackId);
      print("Removed location updates with callback id $callbackId");
    } catch (e) {
      print(e.toString());
    }
  }

  void requestLocationUpdatesCb() async {
    LocationRequest locationRequest;
    locationService = FusedLocationProviderClient();
    locationRequest = LocationRequest();
    locationRequest.interval = 1000;

    try {
      callbackId = await locationService.requestLocationUpdatesCb(
          locationRequest, locCallback);
      print("Requested location updates with callback id $callbackId");
      print("Now removing location updates");
      removeLocationUpdatesCb(callbackId);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, {
          'geofenceList': geofenceList,
          'geofenceIdList': geofenceIdList,
        });
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Add Geofence Screen'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(topText),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CustomTextInput(
                        controller: _lat,
                        labelText: "Latitude",
                        hintText: "[-90,90]",
                        inputFormatters: numWithDecimalFormatter,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                      ),
                      CustomTextInput(
                        controller: _lng,
                        labelText: "Longitude",
                        hintText: "[-180,180]",
                        inputFormatters: numWithDecimalFormatter,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                      ),
                      CustomTextInput(
                        controller: _rad,
                        labelText: "Radius",
                        hintText: "in meters",
                        inputFormatters: numWithDecimalFormatter,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                      ),
                      CustomTextInput(
                        controller: _uid,
                        labelText: "UniqueId",
                        keyboardType: TextInputType.text,
                      ),
                      CustomTextInput(
                        controller: _conversions,
                        labelText: "Conversions",
                        inputFormatters: digitsOnlyFormatter,
                        keyboardType: TextInputType.number,
                      ),
                      CustomTextInput(
                        controller: _validTime,
                        labelText: "ValidTime",
                        inputFormatters: digitsOnlyFormatter,
                        keyboardType: TextInputType.number,
                      ),
                      CustomTextInput(
                        controller: _dwellTime,
                        labelText: "DwellDelayTime",
                        inputFormatters: digitsOnlyFormatter,
                        keyboardType: TextInputType.number,
                      ),
                      CustomTextInput(
                        controller: _notifInterval,
                        labelText: "NotificationInterval",
                        inputFormatters: digitsOnlyFormatter,
                        keyboardType: TextInputType.number,
                      ),
                      Btn("Get Current Location", requestLocationUpdatesCb),
                      Btn("Add Geofence", () {
                        addGeofence();
                      }),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Text("Geofences: $fenceCount"),
                              SizedBox(height: 15),
                              Text(bottomText),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
