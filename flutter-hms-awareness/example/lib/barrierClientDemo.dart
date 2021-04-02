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
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:huawei_awareness/hmsAwarenessLibrary.dart';

import 'CustomWidgets/customButton.dart';
import 'CustomWidgets/customAppBar.dart';
import 'CustomWidgets/customConsole.dart';
import 'CustomWidgets/customRaisedButton.dart';

class BarrierClientDemo extends StatefulWidget {
  @override
  _BarrierClientDemoState createState() => _BarrierClientDemoState();
}

class _BarrierClientDemoState extends State<BarrierClientDemo> {
  bool isQueried = false;
  bool permissions = false;
  StreamSubscription<dynamic> subscription;
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

  void queryBarriers() async {
    BarrierQueryResponse response =
        await AwarenessBarrierClient.queryBarriers(BarrierQueryRequest.all());
    log(response.toJson(), name: "queryBarriers");
    setState(() {
      responses
          .add("Registered Barriers: " + response.barriers.length.toString());
    });
  }

  void deleteBarriers() async {
    bool status =
        await AwarenessBarrierClient.deleteBarrier(BarrierDeleteRequest.all());
    if (status) {
      setState(() {
        responses.add("Deleted Barriers");
      });
    }
  }

  void addBeaconBarrier() async {
    BeaconFilter filter = BeaconFilter.matchByBeaconContent(
      beaconNamespace: "namespace1",
      beaconType: "type1",
      beaconContent: Uint8List.fromList(utf8.encode("content")),
    );

    BeaconFilter filter2 = BeaconFilter.matchByNameType(
      beaconNamespace: "namespace2",
      beaconType: "type2",
    );

    BeaconFilter filter3 = BeaconFilter.matchByBeaconId(
      beaconId: "beacon-id",
    );

    bool status = await AwarenessBarrierClient.updateBarriers(
        barrier: BeaconBarrier.keep(
      barrierLabel: "Beacon Barrier",
      filters: [
        filter,
        filter2,
        filter3,
      ],
    ));
    if (status) {
      setState(() {
        responses.add("Beacon Barrier added.");
      });
    }
  }

  void addHeadsetBarrier() async {
    bool status = await AwarenessBarrierClient.updateBarriers(
        barrier: HeadsetBarrier.keeping(
      barrierLabel: "Headset Barrier",
      headsetStatus: HeadsetStatus.Connected,
    ));
    if (status) {
      setState(() {
        responses.add("Headset Barrier added.");
      });
    }
  }

  void addAmbientLightBarrier() async {
    bool status = await AwarenessBarrierClient.updateBarriers(
        barrier: AmbientLightBarrier.above(
            barrierLabel: "Light Barrier", minLightIntensity: 1000));
    if (status) {
      setState(() {
        responses.add("Light Barrier added.");
      });
    }
  }

  void addWiFiBarrier() async {
    bool status = await AwarenessBarrierClient.updateBarriers(
        barrier: WiFiBarrier.keeping(
      barrierLabel: "WiFi Barrier",
      wifiStatus: WiFiStatus.Connected,
    ));
    if (status) {
      setState(() {
        responses.add("WiFi Barrier added.");
      });
    }
  }

  void addScreenBarrier() async {
    bool status = await AwarenessBarrierClient.updateBarriers(
        autoRemove: false,
        barrier: ScreenBarrier.keeping(
          barrierLabel: "Screen Barrier",
          screenStatus: ScreenStatus.Unlock,
        ));
    if (status) {
      setState(() {
        responses.add("Screen Barrier added.");
      });
    }
  }

  void addBluetoothBarrier() async {
    bool status = await AwarenessBarrierClient.updateBarriers(
        barrier: BluetoothBarrier.keeping(
      barrierLabel: "Bluetooth Barrier",
      bluetoothStatus: BluetoothStatus.Connected,
      deviceType: BluetoothStatus.DeviceCar,
    ));
    if (status) {
      setState(() {
        responses.add("Bluetooth Barrier added.");
      });
    }
  }

  void addBehaviorBarrier() async {
    bool status = await AwarenessBarrierClient.updateBarriers(
        barrier: BehaviorBarrier.keeping(
      barrierLabel: "Behavior Barrier",
      behaviorTypes: [BehaviorBarrier.BehaviorStill],
    ));
    if (status) {
      setState(() {
        responses.add("Behavior Barrier added.");
      });
    }
  }

  void addLocationBarrier() async {
    bool status = await AwarenessBarrierClient.updateBarriers(
        barrier: LocationBarrier.stay(
      barrierLabel: "Location Barrier",
      latitude: 22.4943,
      longitude: 113.7436,
      radius: 200,
      timeOfDuration: 10000,
    ));
    if (status) {
      setState(() {
        responses.add("Location Barrier added.");
      });
    }
  }

  void addTimeBarrier() async {
    bool status = await AwarenessBarrierClient.updateBarriers(
        barrier: TimeBarrier.duringPeriodOfWeek(
      barrierLabel: "Time Barrier",
      dayOfWeek: TimeBarrier.WednesdayCode,
      startTimeOfSpecifiedDay: 0,
      stopTimeOfSpecifiedDay: 86400000,
      timeZoneId: "Europe/Istanbul",
    ));
    if (status) {
      setState(() {
        responses.add("Time Barrier added.");
      });
    }
  }

  void createCombination() async {
    AwarenessBarrier barrier =
        CombinationBarrier.and(barrierLabel: "Combination Barrier", barriers: [
      CombinationBarrier.or(barrierLabel: "or", barriers: [
        HeadsetBarrier.keeping(
          barrierLabel: "Headset",
          headsetStatus: 1,
        ),
        AmbientLightBarrier.above(
          barrierLabel: "Light",
          minLightIntensity: 1000,
        ),
      ]),
      CombinationBarrier.not(
          barrierLabel: "not",
          barrier: ScreenBarrier.keeping(
            barrierLabel: "Screen",
            screenStatus: ScreenStatus.Unlock,
          )),
    ]);

    bool status = await AwarenessBarrierClient.updateBarriers(
        barrier: barrier, autoRemove: true);
    if (status) {
      setState(() {
        responses.add("Combination Barrier added.");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        icon: false,
        size: 100,
        title: "Barrier Client Demo",
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
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30.0))),
                                      child: Text("Query Barriers"),
                                      onPressed: queryBarriers,
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30.0))),
                                      child: Text("Delete Barriers"),
                                      onPressed: deleteBarriers,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomRaisedButton(
                                      buttonText: "Beacon Barrier",
                                      capabilityCode:
                                          CapabilityStatus.BeaconCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addBeaconBarrier,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Headset Barrier",
                                      capabilityCode: CapabilityStatus
                                          .HeadsetCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addHeadsetBarrier,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Ambient Light Barrier",
                                      capabilityCode: CapabilityStatus
                                          .AmbientLightCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addAmbientLightBarrier,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomRaisedButton(
                                      buttonText: "Wifi Barrier",
                                      capabilityCode:
                                          CapabilityStatus.WiFiCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addWiFiBarrier,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Screen Barrier",
                                      capabilityCode:
                                          CapabilityStatus.ScreenCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addScreenBarrier,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Bluetooth Barrier",
                                      capabilityCode: CapabilityStatus
                                          .InCarBluetoothCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addBluetoothBarrier,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomRaisedButton(
                                      buttonText: "Behavior Barrier",
                                      capabilityCode: CapabilityStatus
                                          .BehaviorCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addBehaviorBarrier,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Location Barrier",
                                      capabilityCode: CapabilityStatus
                                          .LocationNormalBarrierCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addLocationBarrier,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: "Time Barrier",
                                      capabilityCode:
                                          CapabilityStatus.TimeCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addTimeBarrier,
                                    ),
                                  ],
                                ),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0))),
                                  onPressed: createCombination,
                                  child: Text("Add Combination Barrier"),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0))),
                                        child: Text("Start Listening"),
                                        onPressed: () {
                                          subscription = AwarenessBarrierClient
                                              .onBarrierStatusStream
                                              .listen((event) {
                                            if (mounted) {
                                              setState(() {
                                                String name =
                                                    event.barrierLabel;
                                                responses.add("($name) - " +
                                                    "Present Status: " +
                                                    event.presentStatus
                                                        .toString());
                                              });
                                            }
                                          }, onError: (error) {
                                            log(error.toString());
                                          });
                                          log("Started listening.");
                                          setState(() {
                                            responses
                                                .add("-- Started Listening --");
                                          });
                                        }),
                                    RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0))),
                                        child: Text("Stop Listening"),
                                        onPressed: () {
                                          if (subscription != null) {
                                            subscription.cancel();
                                            log("Stopped listening.");
                                            setState(() {
                                              responses.add(
                                                  "-- Stopped Listening --");
                                            });
                                          }
                                        }),
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
