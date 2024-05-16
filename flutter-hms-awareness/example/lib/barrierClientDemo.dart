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

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:huawei_awareness/huawei_awareness.dart';

import 'customWidgets/customAppBar.dart';
import 'customWidgets/customButton.dart';
import 'customWidgets/customConsole.dart';
import 'customWidgets/customRaisedButton.dart';

class BarrierClientDemo extends StatefulWidget {
  const BarrierClientDemo({Key? key}) : super(key: key);

  @override
  State<BarrierClientDemo> createState() => _BarrierClientDemoState();
}

class _BarrierClientDemoState extends State<BarrierClientDemo> {
  bool isQueried = false;
  StreamSubscription<dynamic>? subscription;
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

  void queryBarriers() async {
    BarrierQueryResponse response =
        await AwarenessBarrierClient.queryBarriers(BarrierQueryRequest.all());
    log(response.toJson(), name: 'queryBarriers');
    setState(() {
      responses.add('Registered Barriers: ${response.barriers!.length}');
    });
  }

  void deleteBarriers() async {
    bool status =
        await AwarenessBarrierClient.deleteBarrier(BarrierDeleteRequest.all());
    if (status) {
      setState(() {
        responses.add('Deleted Barriers');
      });
    }
  }

  void addBeaconBarrier() async {
    BeaconFilter filter = BeaconFilter.matchByBeaconContent(
      beaconNamespace: 'namespace1',
      beaconType: 'type1',
      beaconContent: Uint8List.fromList(utf8.encode('content')),
    );

    BeaconFilter filter2 = BeaconFilter.matchByNameType(
      beaconNamespace: 'namespace2',
      beaconType: 'type2',
    );

    BeaconFilter filter3 = BeaconFilter.matchByBeaconId(
      beaconId: 'beacon-id',
    );

    bool status = await AwarenessBarrierClient.updateBarriers(
      barrier: BeaconBarrier.keep(
        barrierLabel: 'Beacon Barrier',
        filters: <BeaconFilter>[
          filter,
          filter2,
          filter3,
        ],
      ),
    );
    if (status) {
      setState(() {
        responses.add('Beacon Barrier added.');
      });

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
  }

  void addHeadsetBarrier() async {
    bool status = await AwarenessBarrierClient.updateBarriers(
        barrier: HeadsetBarrier.keeping(
      barrierLabel: 'Headset Barrier',
      headsetStatus: HeadsetStatus.connected,
    ));
    if (status) {
      setState(() {
        responses.add('Headset Barrier added.');
      });
    }
  }

  void addAmbientLightBarrier() async {
    bool status = await AwarenessBarrierClient.updateBarriers(
      barrier: AmbientLightBarrier.above(
        barrierLabel: 'Light Barrier',
        minLightIntensity: 1000,
      ),
    );
    if (status) {
      setState(() {
        responses.add('Light Barrier added.');
      });
    }
  }

  void addWiFiBarrier() async {
    bool status = await AwarenessBarrierClient.updateBarriers(
        barrier: WiFiBarrier.keeping(
      barrierLabel: 'WiFi Barrier',
      wifiStatus: WiFiStatus.connected,
    ));
    if (status) {
      setState(() {
        responses.add('WiFi Barrier added.');
      });
    }
  }

  void addScreenBarrier() async {
    bool status = await AwarenessBarrierClient.updateBarriers(
        autoRemove: false,
        barrier: ScreenBarrier.keeping(
          barrierLabel: 'Screen Barrier',
          screenStatus: ScreenStatus.unlock,
        ));
    if (status) {
      setState(() {
        responses.add('Screen Barrier added.');
      });
    }
  }

  void addBluetoothBarrier() async {
    bool status = await AwarenessBarrierClient.updateBarriers(
        barrier: BluetoothBarrier.keeping(
      barrierLabel: 'Bluetooth Barrier',
      bluetoothStatus: BluetoothStatus.connected,
      deviceType: BluetoothStatus.deviceCar,
    ));
    if (status) {
      setState(() {
        responses.add('Bluetooth Barrier added.');
      });
    }
  }

  void addBehaviorBarrier() async {
    bool status = await AwarenessBarrierClient.updateBarriers(
        barrier: BehaviorBarrier.keeping(
      barrierLabel: 'Behavior Barrier',
      behaviorTypes: <int>[BehaviorBarrier.behaviorStill],
    ));
    if (status) {
      setState(() {
        responses.add('Behavior Barrier added.');
      });
    }
  }

  void addLocationBarrier() async {
    bool status = await AwarenessBarrierClient.updateBarriers(
        barrier: LocationBarrier.stay(
      barrierLabel: 'Location Barrier',
      latitude: 22.4943,
      longitude: 113.7436,
      radius: 200,
      timeOfDuration: 10000,
    ));
    if (status) {
      setState(() {
        responses.add('Location Barrier added.');
      });
    }
  }

  void addTimeBarrier() async {
    bool status = await AwarenessBarrierClient.updateBarriers(
      barrier: TimeBarrier.duringPeriodOfWeek(
        barrierLabel: 'Time Barrier',
        dayOfWeek: TimeBarrier.wednesdayCode,
        startTimeOfSpecifiedDay: 0,
        stopTimeOfSpecifiedDay: 86400000,
        timeZoneId: 'Europe/Istanbul',
      ),
    );
    if (status) {
      setState(() {
        responses.add('Time Barrier added.');
      });
    }
  }

  void createCombination() async {
    AwarenessBarrier barrier = CombinationBarrier.and(
      barrierLabel: 'Combination Barrier',
      barriers: <AwarenessBarrier>[
        CombinationBarrier.or(
          barrierLabel: 'or',
          barriers: <AwarenessBarrier>[
            HeadsetBarrier.keeping(
              barrierLabel: 'Headset',
              headsetStatus: 1,
            ),
            AmbientLightBarrier.above(
              barrierLabel: 'Light',
              minLightIntensity: 1000,
            ),
          ],
        ),
        CombinationBarrier.not(
          barrierLabel: 'not',
          barrier: ScreenBarrier.keeping(
            barrierLabel: 'Screen',
            screenStatus: ScreenStatus.unlock,
          ),
        ),
      ],
    );

    bool status = await AwarenessBarrierClient.updateBarriers(
        barrier: barrier, autoRemove: true);
    if (status) {
      setState(() {
        responses.add('Combination Barrier added.');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        icon: false,
        size: 100,
        title: 'Barrier Client Demo',
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
                        text: 'Query Capabilities'),
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
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0))),
                                      ),
                                      onPressed: queryBarriers,
                                      child: const Text('Query Barriers'),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0))),
                                      ),
                                      onPressed: deleteBarriers,
                                      child: const Text('Delete Barriers'),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    CustomRaisedButton(
                                      buttonText: 'Beacon Barrier',
                                      capabilityCode:
                                          CapabilityStatus.beaconCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addBeaconBarrier,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Headset Barrier',
                                      capabilityCode: CapabilityStatus
                                          .headsetCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addHeadsetBarrier,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Ambient Light Barrier',
                                      capabilityCode: CapabilityStatus
                                          .ambientLightCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addAmbientLightBarrier,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    CustomRaisedButton(
                                      buttonText: 'Wifi Barrier',
                                      capabilityCode:
                                          CapabilityStatus.wiFiCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addWiFiBarrier,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Screen Barrier',
                                      capabilityCode:
                                          CapabilityStatus.screenCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addScreenBarrier,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Bluetooth Barrier',
                                      capabilityCode: CapabilityStatus
                                          .inCarBluetoothCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addBluetoothBarrier,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    CustomRaisedButton(
                                      buttonText: 'Behavior Barrier',
                                      capabilityCode: CapabilityStatus
                                          .behaviorCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addBehaviorBarrier,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Location Barrier',
                                      capabilityCode: CapabilityStatus
                                          .locationNormalBarrierCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addLocationBarrier,
                                    ),
                                    CustomRaisedButton(
                                      buttonText: 'Time Barrier',
                                      capabilityCode:
                                          CapabilityStatus.timeCapabilityCode,
                                      capabilityList: capabilityList,
                                      onPressed: addTimeBarrier,
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0))),
                                  ),
                                  onPressed: createCombination,
                                  child: const Text('Add Combination Barrier'),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0))),
                                        ),
                                        child: const Text('Start Listening'),
                                        onPressed: () {
                                          subscription = AwarenessBarrierClient
                                              .onBarrierStatusStream
                                              .listen((BarrierStatus event) {
                                            if (mounted) {
                                              setState(() {
                                                String name =
                                                    event.barrierLabel!;
                                                responses.add(
                                                    '($name) - Present Status:${event.presentStatus}');
                                              });
                                            }
                                          }, onError: (dynamic error) {
                                            log(error.toString());
                                          });
                                          log('Started listening.');
                                          setState(() {
                                            responses
                                                .add('-- Started Listening --');
                                          });
                                        }),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0))),
                                        ),
                                        child: const Text('Stop Listening'),
                                        onPressed: () {
                                          if (subscription != null) {
                                            subscription?.cancel();
                                            log('Stopped listening.');
                                            setState(
                                              () {
                                                responses.add(
                                                    '-- Stopped Listening --');
                                              },
                                            );
                                          }
                                        }),
                                  ],
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30.0))),
                                    ),
                                    child: const Text('Clear Console'),
                                    onPressed: () {
                                      setState(() {
                                        responses.clear();
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CustomConsole(
                            responses: responses,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
