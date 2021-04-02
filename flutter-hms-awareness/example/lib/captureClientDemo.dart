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

import 'dart:developer';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:huawei_awareness/hmsAwarenessLibrary.dart';

import 'CustomWidgets/customAppBar.dart';
import 'CustomWidgets/customButton.dart';
import 'CustomWidgets/customConsole.dart';
import 'CustomWidgets/customRaisedButton.dart';

class CaptureClientDemo extends StatefulWidget {
  @override
  _CaptureClientDemoState createState() => _CaptureClientDemoState();
}

class _CaptureClientDemoState extends State<CaptureClientDemo> {
  bool isQueried = false;
  bool permissions = false;

  List<String> responses = [];
  List<int> capabilityList = [];

  bool locationPermission;
  bool backgroundLocationPermission;
  bool activityRecognitionPermission;

  @override
  void initState() {
    checkPermissions();
    super.initState();
  }

  void queryCapabilities() async {
    CapabilityResponse capabilities =
        await AwarenessCaptureClient.querySupportingCapabilities();
    setState(() {
      capabilityList = capabilities.deviceSupportCapabilities;
      isQueried = true;
      log(capabilityList.toString(), name: "Supported Capability Codes");
    });
  }

  void checkPermissions() async {
    locationPermission = await AwarenessUtilsClient.hasLocationPermission();
    backgroundLocationPermission =
        await AwarenessUtilsClient.hasBackgroundLocationPermission();
    activityRecognitionPermission =
        await AwarenessUtilsClient.hasActivityRecognitionPermission();
    if (locationPermission &&
        backgroundLocationPermission &&
        activityRecognitionPermission) {
      setState(() {
        permissions = true;
      });
    }
  }

  void requestPermissions() async {
    if (locationPermission == false) {
      bool status = await AwarenessUtilsClient.requestLocationPermission();
      setState(() {
        locationPermission = status;
      });
    }

    if (backgroundLocationPermission == false) {
      bool status =
          await AwarenessUtilsClient.requestBackgroundLocationPermission();
      setState(() {
        locationPermission = status;
      });
    }

    if (activityRecognitionPermission == false) {
      bool status =
          await AwarenessUtilsClient.requestActivityRecognitionPermission();
      setState(() {
        locationPermission = status;
      });

      checkPermissions();
    }
  }

  void captureBeacon() async {
    BeaconFilter filter = BeaconFilter.matchByBeaconContent(
      beaconNamespace: "namespace1",
      beaconType: "type2",
      beaconContent: Uint8List.fromList(utf8.encode("content")),
    );

    BeaconFilter filter2 = BeaconFilter.matchByNameType(
      beaconNamespace: "namespace2",
      beaconType: "type2",
    );

    BeaconFilter filter3 = BeaconFilter.matchByBeaconId(
      beaconId: "beacon-id",
    );

    BeaconResponse response = await AwarenessCaptureClient.getBeaconStatus(
        filters: [filter, filter2, filter3]);
    setState(() {
      responses.add("Beacons Found: " + response.beacons.length.toString());
      log(response.toJson(), name: "beaconData");
    });
  }

  void captureBehavior() async {
    BehaviorResponse response = await AwarenessCaptureClient.getBehavior();
    setState(() {
      responses.add("Behavior: " + response.mostLikelyBehavior.type.toString());
    });
    log(response.toJson(), name: "captureBehavior");
  }

  void captureHeadset() async {
    HeadsetResponse response = await AwarenessCaptureClient.getHeadsetStatus();
    setState(() {
      switch (response.headsetStatus) {
        case HeadsetStatus.Connected:
          responses.add("Headset Status: Connected");
          break;
        case HeadsetStatus.Disconnected:
          responses.add("Headset Status: Disconnected");
          break;
        case HeadsetStatus.Unknown:
          responses.add("Headset Status: Unknown");
          break;
      }
    });
    log(response.toJson(), name: "captureHeadset");
  }

  void captureLocation() async {
    LocationResponse response = await AwarenessCaptureClient.getLocation();
    setState(() {
      responses.add("Location: " +
          response.latitude.toString() +
          " - " +
          response.longitude.toString());
    });
    log(response.toJson(), name: "captureLocation");
  }

  void captureCurrentLocation() async {
    LocationResponse response =
        await AwarenessCaptureClient.getCurrentLocation();
    setState(() {
      responses.add("Current Location: " +
          response.latitude.toString() +
          " - " +
          response.longitude.toString());
    });
    log(response.toJson(), name: "captureCurrentLocation");
  }

  void captureTimeCategories() async {
    TimeCategoriesResponse response =
        await AwarenessCaptureClient.getTimeCategories();
    setState(() {
      responses.add("Time Categories: " + response.timeCategories.toString());
    });
    log(response.toJson(), name: "captureTimeCategories");
  }

  void captureTimeByUser() async {
    TimeCategoriesResponse response =
        await AwarenessCaptureClient.getTimeCategoriesByUser(
            latitude: 22.4943, longitude: 113.7436);
    setState(() {
      responses.add("Time Categories: " + response.timeCategories.toString());
    });
    log(response.toJson(), name: "captureTimeByUser");
  }

  void captureTimeByCountry() async {
    TimeCategoriesResponse response =
        await AwarenessCaptureClient.getTimeCategoriesByCountryCode(
            countryCode: "CN");
    setState(() {
      responses.add("Time Categories: " + response.timeCategories.toString());
    });
    log(response.toJson(), name: "captureTimeByCountry");
  }

  void captureTimeByIp() async {
    TimeCategoriesResponse response =
        await AwarenessCaptureClient.getTimeCategoriesByIP();
    setState(() {
      responses.add("Time Categories: " + response.timeCategories.toString());
    });
    log(response.toJson(), name: "captureTimeByIp");
  }

  void captureTimeForFuture() async {
    TimeCategoriesResponse response =
        await AwarenessCaptureClient.getTimeCategoriesForFuture(
            futureTimestamp: 1577867600000);
    setState(() {
      responses.add("Time Categories: " + response.timeCategories.toString());
    });
    log(response.toJson(), name: "captureTimeForFuture");
  }

  void captureLightIntensity() async {
    LightIntensityResponse response =
        await AwarenessCaptureClient.getLightIntensity();
    setState(() {
      responses.add("Light Intensity: " + response.lightIntensity.toString());
    });
    log(response.toJson(), name: "captureLightIntensity");
  }

  void captureWeatherByDevice() async {
    WeatherResponse response =
        await AwarenessCaptureClient.getWeatherByDevice();
    setState(() {
      responses.add("Temperature: " +
          response.weatherSituation.situation.temperatureC.toString());
    });
    log(response.toJson(), name: "captureWeatherByDevice");
  }

  void captureWeatherByPosition() async {
    WeatherResponse response =
        await AwarenessCaptureClient.getWeatherByPosition(
            weatherPosition: WeatherPosition(
                city: "London", locale: "en_GB", country: "United Kingdom"));
    setState(() {
      responses.add("Temperature: " +
          response.weatherSituation.situation.temperatureC.toString());
    });
    log(response.toJson(), name: "captureWeatherByPosition");
  }

  void captureBluetooth() async {
    BluetoothResponse response =
        await AwarenessCaptureClient.getBluetoothStatus(
            deviceType: BluetoothStatus.DeviceCar);
    setState(() {
      responses.add("Bluetooth Status: " + response.bluetoothStatus.toString());
    });
    log(response.toJson(), name: "captureBluetooth");
  }

  void captureScreen() async {
    ScreenStatusResponse response =
        await AwarenessCaptureClient.getScreenStatus();
    setState(() {
      responses.add("Screen Status: " + response.screenStatus.toString());
    });
    log(response.toJson(), name: "captureScreen");
  }

  void captureWiFi() async {
    WiFiResponse response = await AwarenessCaptureClient.getWifiStatus();
    setState(() {
      responses.add("WiFi Status: " + response.status.toString());
    });
    log(response.toJson(), name: "captureWiFi");
  }

  void captureApplication() async {
    ApplicationResponse response =
        await AwarenessCaptureClient.getApplicationStatus(
            packageName: "package_name");
    setState(() {
      responses
          .add("Application Status: " + response.applicationStatus.toString());
    });
    log(response.toJson(), name: "captureApplication");
  }

  void captureDarkMode() async {
    DarkModeResponse response =
        await AwarenessCaptureClient.getDarkModeStatus();
    setState(() {
      responses.add("Dark Mode Status: " + response.isDarkModeOn.toString());
    });
    log(response.toJson(), name: "captureDarkMode");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        icon: false,
        size: 100,
        title: "Capture Client Demo",
        fontSize: 20,
        backButton: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          isQueried && permissions
              ? SizedBox.shrink()
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Before starting...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromRGBO(30, 61, 89, 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text(
                        "Obtaining capabilities supported by Awareness Kit on the current device is a good practice before starting.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(30, 61, 89, 1),
                        ),
                      ),
                    ),
                    CustomButton(
                        onPressed: queryCapabilities,
                        text: "Query Capabilities"),
                    permissions
                        ? SizedBox.shrink()
                        : Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Text(
                                  "Also, users should grant Location, Background Location and Activity Recognition permissions to fully benefit from Huawei Awareness Kit.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(30, 61, 89, 1),
                                  ),
                                ),
                              ),
                              CustomButton(
                                  onPressed: requestPermissions,
                                  text: "Request Permissions"),
                            ],
                          ),
                  ],
                ),
          isQueried && permissions
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomRaisedButton(
                                      buttonText: "Beacon",
                                      capabilityCode:
                                          CapabilityStatus.BeaconCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureBeacon,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Behavior",
                                      capabilityCode: CapabilityStatus
                                          .BehaviorCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureBehavior,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Headset",
                                      capabilityCode: CapabilityStatus
                                          .HeadsetCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureHeadset,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomRaisedButton(
                                      buttonText: "Location",
                                      capabilityCode: CapabilityStatus
                                          .LocationCaptureCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureLocation,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Current Location",
                                      capabilityCode: CapabilityStatus
                                          .LocationCaptureCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureCurrentLocation,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Time Categories",
                                      capabilityCode:
                                          CapabilityStatus.TimeCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureTimeCategories,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomRaisedButton(
                                      buttonText: "Time Categories By User",
                                      capabilityCode:
                                          CapabilityStatus.TimeCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureTimeByUser,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Time Categories By Country",
                                      capabilityCode:
                                          CapabilityStatus.TimeCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureTimeByCountry,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Time Categories By IP",
                                      capabilityCode:
                                          CapabilityStatus.TimeCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureTimeByIp,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomRaisedButton(
                                      buttonText: "Time Categories For Future",
                                      capabilityCode:
                                          CapabilityStatus.TimeCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureTimeForFuture,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Light Intensity",
                                      capabilityCode: CapabilityStatus
                                          .AmbientLightCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureLightIntensity,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Weather By Device",
                                      capabilityCode: CapabilityStatus
                                          .WeatherCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureWeatherByDevice,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomRaisedButton(
                                      buttonText: "Weather By Position",
                                      capabilityCode: CapabilityStatus
                                          .WeatherCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureWeatherByPosition,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Bluetooth",
                                      capabilityCode: CapabilityStatus
                                          .InCarBluetoothCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureBluetooth,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Screen",
                                      capabilityCode:
                                          CapabilityStatus.ScreenCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureScreen,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomRaisedButton(
                                      buttonText: "WiFi",
                                      capabilityCode:
                                          CapabilityStatus.WiFiCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureWiFi,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Application",
                                      capabilityCode: CapabilityStatus
                                          .ApplicationCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureApplication,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Dark Mode",
                                      capabilityCode: CapabilityStatus
                                          .DarkModeCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureDarkMode,
                                    ),
                                  ],
                                ),
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0))),
                                    child: Text("Clear Console"),
                                    onPressed: () {
                                      setState(() {
                                        responses.clear();
                                      });
                                    }),
                              ],
                            ),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: CustomConsole(
                            responses: responses,
                          ),
                          flex: 1,
                        )
                      ],
                    ),
                  ),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
