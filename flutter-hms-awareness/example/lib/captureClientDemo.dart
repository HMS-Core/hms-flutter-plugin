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

import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:huawei_awareness/huawei_awareness.dart';

import 'customWidgets/customAppBar.dart';
import 'customWidgets/customButton.dart';
import 'customWidgets/customConsole.dart';
import 'customWidgets/customRaisedButton.dart';

class CaptureClientDemo extends StatefulWidget {
  const CaptureClientDemo({Key? key}) : super(key: key);

  @override
  State<CaptureClientDemo> createState() => _CaptureClientDemoState();
}

class _CaptureClientDemoState extends State<CaptureClientDemo> {
  bool isQueried = false;

  List<String> responses = <String>[];
  List<int> capabilityList = <int>[];

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  // TODO: Please implement your own 'Permission Handler'.
  void _requestPermission() async {
    // Huawei Awareness needs some permissions to work properly.
    // You are expected to handle these permissions to use required features.

    // You can learn more about the required permissions from our official documentations.
    // https://developer.huawei.com/consumer/en/doc/HMS-Plugin-Guides/dev-process-0000001074588370-V1?ha_source=hms1
  }

  void queryCapabilities() async {
    CapabilityResponse capabilities =
        await AwarenessCaptureClient.querySupportingCapabilities();
    setState(() {
      capabilityList = capabilities.deviceSupportCapabilities!;
      isQueried = true;
      log(capabilityList.toString(), name: 'Supported Capability Codes');
    });
  }

  void captureBeacon() async {
    BeaconFilter filter = BeaconFilter.matchByBeaconContent(
      beaconNamespace: 'namespace1',
      beaconType: 'type2',
      beaconContent: Uint8List.fromList(utf8.encode('content')),
    );

    BeaconFilter filter2 = BeaconFilter.matchByNameType(
      beaconNamespace: 'namespace2',
      beaconType: 'type2',
    );

    BeaconFilter filter3 = BeaconFilter.matchByBeaconId(
      beaconId: 'beacon-id',
    );

    BeaconResponse response = await AwarenessCaptureClient.getBeaconStatus(
        filters: <BeaconFilter>[filter, filter2, filter3]);
    setState(() {
      responses.add('Beacons Found: ${response.beacons!.length}');
      log(
        response.toJson(),
        name: 'beaconData',
      );
    });
  }

  void captureBehavior() async {
    BehaviorResponse response = await AwarenessCaptureClient.getBehavior();
    setState(() {
      responses.add('Behavior: ${response.mostLikelyBehavior!.type}');
    });
    log(response.toJson(), name: 'captureBehavior');
  }

  void captureHeadset() async {
    HeadsetResponse response = await AwarenessCaptureClient.getHeadsetStatus();
    setState(() {
      switch (response.headsetStatus) {
        case HeadsetStatus.connected:
          responses.add('Headset Status: Connected');
          break;
        case HeadsetStatus.disconnected:
          responses.add('Headset Status: Disconnected');
          break;
        case HeadsetStatus.unknown:
          responses.add('Headset Status: Unknown');
          break;
      }
    });
    log(response.toJson(), name: 'captureHeadset');
  }

  void captureLocation() async {
    LocationResponse response = await AwarenessCaptureClient.getLocation();
    setState(() {
      responses.add('Location: ${response.latitude} - ${response.longitude}');
    });
    log(response.toJson(), name: 'captureLocation');
  }

  void captureCurrentLocation() async {
    LocationResponse response =
        await AwarenessCaptureClient.getCurrentLocation();
    setState(() {
      responses.add(
          'Current Location: ${response.latitude} - ${response.longitude}');
    });
    log(response.toJson(), name: 'captureCurrentLocation');
  }

  void captureTimeCategories() async {
    TimeCategoriesResponse response =
        await AwarenessCaptureClient.getTimeCategories();
    setState(() {
      responses.add('Time Categories: ${response.timeCategories}');
    });
    log(response.toJson(), name: 'captureTimeCategories');
  }

  void captureTimeByUser() async {
    TimeCategoriesResponse response =
        await AwarenessCaptureClient.getTimeCategoriesByUser(
            latitude: 22.4943, longitude: 113.7436);
    setState(() {
      responses.add('Time Categories: ${response.timeCategories}');
    });
    log(response.toJson(), name: 'captureTimeByUser');
  }

  void captureTimeByCountry() async {
    TimeCategoriesResponse response =
        await AwarenessCaptureClient.getTimeCategoriesByCountryCode(
            countryCode: 'CN');
    setState(() {
      responses.add('Time Categories: ${response.timeCategories}');
    });
    log(response.toJson(), name: 'captureTimeByCountry');
  }

  void captureTimeByIp() async {
    TimeCategoriesResponse response =
        await AwarenessCaptureClient.getTimeCategoriesByIP();
    setState(() {
      responses.add('Time Categories: ${response.timeCategories}');
    });
    log(response.toJson(), name: 'captureTimeByIp');
  }

  void captureTimeForFuture() async {
    TimeCategoriesResponse response =
        await AwarenessCaptureClient.getTimeCategoriesForFuture(
            futureTimestamp: DateTime.now()
                .add(const Duration(days: 1))
                .millisecondsSinceEpoch);
    setState(() {
      responses.add('Time Categories: ${response.timeCategories}');
    });
    log(response.toJson(), name: 'captureTimeForFuture');
  }

  void captureLightIntensity() async {
    LightIntensityResponse response =
        await AwarenessCaptureClient.getLightIntensity();
    setState(() {
      responses.add('Light Intensity: ${response.lightIntensity}');
    });
    log(response.toJson(), name: 'captureLightIntensity');
  }

  void captureWeatherByDevice() async {
    WeatherResponse response =
        await AwarenessCaptureClient.getWeatherByDevice();
    setState(() {
      responses.add(
          'Temperature: ${response.weatherSituation!.situation!.temperatureC}');
    });
    log(response.toJson(), name: 'captureWeatherByDevice');
  }

  void captureWeatherByPosition() async {
    WeatherResponse response =
        await AwarenessCaptureClient.getWeatherByPosition(
            weatherPosition: WeatherPosition(
                city: 'London', locale: 'en_GB', country: 'United Kingdom'));
    setState(() {
      responses.add(
          'Temperature: ${response.weatherSituation!.situation!.temperatureC}');
    });
    log(response.toJson(), name: 'captureWeatherByPosition');
  }

  void captureBluetooth() async {
    BluetoothResponse response =
        await AwarenessCaptureClient.getBluetoothStatus(
            deviceType: BluetoothStatus.deviceCar);
    setState(() {
      responses.add('Bluetooth Status: ${response.bluetoothStatus}');
    });
    log(response.toJson(), name: 'captureBluetooth');
  }

  void captureScreen() async {
    ScreenStatusResponse response =
        await AwarenessCaptureClient.getScreenStatus();
    setState(() {
      responses.add('Screen Status: ${response.screenStatus}');
    });
    log(response.toJson(), name: 'captureScreen');
  }

  void captureWiFi() async {
    WiFiResponse response = await AwarenessCaptureClient.getWifiStatus();
    setState(() {
      responses.add('WiFi Status: ${response.status}');
    });
    log(response.toJson(), name: 'captureWiFi');
  }

  void captureApplication() async {
    ApplicationResponse response =
        await AwarenessCaptureClient.getApplicationStatus(
            packageName: 'package_name');
    setState(() {
      responses.add('Application Status: ${response.applicationStatus}');
    });
    log(response.toJson(), name: 'captureApplication');
  }

  void captureDarkMode() async {
    DarkModeResponse response =
        await AwarenessCaptureClient.getDarkModeStatus();
    setState(() {
      responses.add('Dark Mode Status: ${response.isDarkModeOn}');
    });
    log(response.toJson(), name: 'captureDarkMode');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        icon: false,
        size: 100,
        title: 'Capture Client Demo',
        fontSize: 20,
        backButton: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          isQueried
              ? const SizedBox.shrink()
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Before starting...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromRGBO(30, 61, 89, 1),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Text(
                        'Obtaining capabilities supported by Awareness Kit on the current device is a good practice before starting.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(30, 61, 89, 1),
                        ),
                      ),
                    ),
                    CustomButton(
                      onPressed: queryCapabilities,
                      text: 'Query Capabilities',
                    ),
                  ],
                ),
          isQueried
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    CustomRaisedButton(
                                      buttonText: 'Beacon',
                                      capabilityCode:
                                          CapabilityStatus.beaconCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureBeacon,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Behavior',
                                      capabilityCode: CapabilityStatus
                                          .behaviorCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureBehavior,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Headset',
                                      capabilityCode: CapabilityStatus
                                          .headsetCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureHeadset,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    CustomRaisedButton(
                                      buttonText: 'Location',
                                      capabilityCode: CapabilityStatus
                                          .locationCaptureCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureLocation,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Current Location',
                                      capabilityCode: CapabilityStatus
                                          .locationCaptureCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureCurrentLocation,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Time Categories',
                                      capabilityCode:
                                          CapabilityStatus.timeCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureTimeCategories,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    CustomRaisedButton(
                                      buttonText: 'Time Categories By User',
                                      capabilityCode:
                                          CapabilityStatus.timeCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureTimeByUser,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Time Categories By Country',
                                      capabilityCode:
                                          CapabilityStatus.timeCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureTimeByCountry,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Time Categories By IP',
                                      capabilityCode:
                                          CapabilityStatus.timeCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureTimeByIp,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    CustomRaisedButton(
                                      buttonText: 'Time Categories For Future',
                                      capabilityCode:
                                          CapabilityStatus.timeCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureTimeForFuture,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Light Intensity',
                                      capabilityCode: CapabilityStatus
                                          .ambientLightCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureLightIntensity,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Weather By Device',
                                      capabilityCode: CapabilityStatus
                                          .weatherCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureWeatherByDevice,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    CustomRaisedButton(
                                      buttonText: 'Weather By Position',
                                      capabilityCode: CapabilityStatus
                                          .weatherCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureWeatherByPosition,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Bluetooth',
                                      capabilityCode: CapabilityStatus
                                          .inCarBluetoothCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureBluetooth,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Screen',
                                      capabilityCode:
                                          CapabilityStatus.screenCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureScreen,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    CustomRaisedButton(
                                      buttonText: 'WiFi',
                                      capabilityCode:
                                          CapabilityStatus.wiFiCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureWiFi,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Application',
                                      capabilityCode: CapabilityStatus
                                          .applicationCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureApplication,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Dark Mode',
                                      capabilityCode: CapabilityStatus
                                          .darkModeCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: captureDarkMode,
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30.0),
                                        ),
                                      ),
                                    ),
                                    child: const Text('Clear Console'),
                                    onPressed: () {
                                      setState(() {
                                        responses.clear();
                                      });
                                    }),
                                CustomConsole(
                                  responses: responses,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
