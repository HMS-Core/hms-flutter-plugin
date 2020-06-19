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
import 'package:huawei_location/geofence/geofence.dart';
import 'package:huawei_location/geofence/geofence_data.dart';
import 'package:huawei_location/geofence/geofence_request.dart';
import 'package:huawei_location/geofence/geofence_service.dart';
import 'package:huawei_location/location/fused_location_provider_client.dart';
import 'package:huawei_location/permission/permission_handler.dart';

import '../screens/add_geofence_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textinput.dart';

class GeofenceScreen extends StatefulWidget {
  static const String routeName = "GeofenceScreen";

  @override
  _GeofenceScreenState createState() => _GeofenceScreenState();
}

class _GeofenceScreenState extends State<GeofenceScreen> {
  String topText;
  String geofenceText;
  String bottomText;
  int fenceCount;
  int requestCode;

  List<Geofence> geofenceList;
  List<String> geofenceIdList;
  PermissionHandler permissionHandler;
  GeofenceService geofenceService;
  GeofenceRequest geofenceRequest;
  FusedLocationProviderClient locationService;
  StreamSubscription<GeofenceData> geofenceStreamSub;
  TextEditingController _uid;
  TextEditingController _trigger;

  @override
  void initState() {
    super.initState();
    initialValues();
  }

  void initialValues() {
    topText = "";
    geofenceText = "";
    bottomText = "";
    fenceCount = 0;
    geofenceList = <Geofence>[];
    geofenceIdList = <String>[];
    permissionHandler = PermissionHandler();
    geofenceService = GeofenceService();
    geofenceRequest = GeofenceRequest();
    locationService = FusedLocationProviderClient();
    _uid = TextEditingController();
    _trigger = TextEditingController(text: "5");
    geofenceStreamSub = geofenceService.onGeofenceData.listen((data) {
      setState(() {
        bottomText = bottomText + '\n\n' + data.toString();
      });
    });

    geofenceText = geofenceIdList.toString();
    fenceCount = geofenceList.length;
  }

  void hasPermission() async {
    try {
      bool status = await permissionHandler.hasBackgroundLocationPermission();
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
      bool status =
          await permissionHandler.requestBackgroundLocationPermission();
      setState(() {
        topText = "Is permission granted $status";
      });
    } catch (e) {
      setState(() {
        topText = e.toString();
      });
    }
  }

  void createGeofenceList() async {
    if (requestCode != null) {
      setState(() {
        topText =
            "Already created geofence list. Call deleteGeofenceList method first.";
      });
    } else if (geofenceList.isEmpty) {
      setState(() {
        topText = "Add Geofence first.";
      });
    } else {
      geofenceRequest.geofenceList = geofenceList;
      geofenceRequest.initConversions = 5;
      try {
        requestCode = await geofenceService.createGeofenceList(geofenceRequest);
        setState(() {
          topText = "Created geofence list successfully.";
        });
      } catch (e) {
        setState(() {
          topText = e.toString();
        });
      }
    }
  }

  void deleteGeofenceList() async {
    if (requestCode == null) {
      setState(() {
        topText = "Call createGeofenceList method first.";
      });
    } else {
      try {
        await geofenceService.deleteGeofenceList(requestCode);
        requestCode = null;
        setState(() {
          topText = "Deleted geofence list successfully.";
          bottomText = "";
        });
      } catch (e) {
        setState(() {
          topText = e.toString();
        });
      }
    }
  }

  void deleteGeofenceListWithIds() async {
    if (requestCode == null) {
      setState(() {
        topText = "Call createGeofenceList method first.";
      });
    } else {
      try {
        await geofenceService.deleteGeofenceListWithIds(geofenceIdList);
        requestCode = null;
        setState(() {
          topText = "Deleted geofence list successfully.";
          bottomText = "";
        });
      } catch (e) {
        setState(() {
          topText = e.toString();
        });
      }
    }
  }

  void deleteGeofenceListOnDispose() async {
    if (requestCode != null) {
      try {
        await geofenceService.deleteGeofenceList(requestCode);
        requestCode = null;
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void _navigateAndWaitData(BuildContext context) async {
    final dynamic result = await Navigator.pushNamed(
        context, AddGeofenceScreen.routeName,
        arguments: {
          'geofenceList': geofenceList,
          'geofenceIdList': geofenceIdList,
        });
    setState(() {
      fenceCount = geofenceList.length;
      geofenceText = result['geofenceIdList'].toString();
    });
  }

  void removeGeofence() {
    if (geofenceList.isEmpty) {
      setState(() {
        topText = "Geofence list is empty. Add geofence first.";
      });
    }
    String uniqueId = _uid.text;

    if (uniqueId == '') {
      setState(() {
        topText = "Enter unique id of the geofence to remove it.";
      });
    } else if (!geofenceIdList.contains(uniqueId)) {
      setState(() {
        topText = "Id '$uniqueId' does not exist on geofence list.";
      });
    } else {
      geofenceIdList.remove(uniqueId);
      geofenceList.removeWhere((e) => e.uniqueId == uniqueId);

      setState(() {
        fenceCount = geofenceList.length;
        geofenceText = geofenceIdList.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geofence Screen'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(topText),
                ),
                Divider(
                  thickness: 0.1,
                  color: Colors.black,
                ),
                Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text("Geofences: $fenceCount"),
                        SizedBox(height: 15),
                        Text(geofenceText),
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.1,
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Btn("hasPermission", hasPermission),
                    Btn("requestPermission", requestPermission),
                  ],
                ),
                Btn("Add Geofence", () {
                  _navigateAndWaitData(context);
                }),
                Divider(
                  thickness: 0.1,
                  color: Colors.black,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 9,
                        child: CustomTextInput(
                          padding: EdgeInsets.all(0),
                          controller: _uid,
                          labelText: "Geofence UniqueId",
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Flexible(
                        flex: 6,
                        child: Container(
                          height: 45,
                          child: Btn("Remove Geofence", removeGeofence),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.1,
                  color: Colors.black,
                ),
                Btn("createGeofenceList", createGeofenceList),
                Btn("deleteGeofenceList", deleteGeofenceList),
                Btn("deleteGeofenceListWithIds", deleteGeofenceListWithIds),
                Text(bottomText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    deleteGeofenceListOnDispose();
    geofenceStreamSub.cancel();
  }
}
