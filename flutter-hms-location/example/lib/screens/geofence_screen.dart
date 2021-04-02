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

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_location/geofence/geofence.dart';
import 'package:huawei_location/geofence/geofence_data.dart';
import 'package:huawei_location/geofence/geofence_request.dart';
import 'package:huawei_location/geofence/geofence_service.dart';
import 'package:huawei_location/permission/permission_handler.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_textinput.dart';
import 'add_geofence_screen.dart';

class GeofenceScreen extends StatefulWidget {
  static const String ROUTE_NAME = "GeofenceScreen";

  @override
  _GeofenceScreenState createState() => _GeofenceScreenState();
}

class _GeofenceScreenState extends State<GeofenceScreen> {
  String _topText = "";
  String _bottomText = "";

  int _fenceCount;
  int _requestCode;
  String _geofenceListText;
  StreamSubscription<GeofenceData> _streamSubscription;

  final List<Geofence> _geofenceList = <Geofence>[];
  final List<String> _geofenceIdList = <String>[];
  final GeofenceService _geofenceService = GeofenceService();
  final GeofenceRequest _geofenceRequest = GeofenceRequest();
  final TextEditingController _uniqueId = TextEditingController();
  final PermissionHandler _permissionHandler = PermissionHandler();

  @override
  void initState() {
    super.initState();
    _fenceCount = _geofenceList.length;
    _geofenceListText = _geofenceIdList.toString();
    _streamSubscription = _geofenceService.onGeofenceData.listen((data) {
      _appendToBottomText(data.toString());
    });
  }

  void _hasPermission() async {
    try {
      final bool status =
          await _permissionHandler.hasBackgroundLocationPermission();
      _setTopText("Has permission: $status");
    } on PlatformException catch (e) {
      _setTopText(e.toString());
    }
  }

  void _requestPermission() async {
    try {
      final bool status =
          await _permissionHandler.requestBackgroundLocationPermission();
      _setTopText("Is permission granted: $status");
    } on PlatformException catch (e) {
      _setTopText(e.toString());
    }
  }

  void _createGeofenceList() async {
    if (_requestCode != null) {
      _setTopText(
          "Already created Geofence list. Call deleteGeofenceList method first.");
    } else if (_geofenceList.isEmpty) {
      _setTopText("Add Geofence first.");
    } else {
      _geofenceRequest.geofenceList = _geofenceList;
      _geofenceRequest.initConversions = 5;
      try {
        _requestCode =
            await _geofenceService.createGeofenceList(_geofenceRequest);
        _setTopText("Created geofence list successfully.");
      } on PlatformException catch (e) {
        _setTopText(e.toString());
      }
    }
  }

  void _deleteGeofenceList() async {
    if (_requestCode == null) {
      _setTopText("Call createGeofenceList method first.");
    } else {
      try {
        await _geofenceService.deleteGeofenceList(_requestCode);
        _requestCode = null;
        _setBottomText();
        _setTopText("");
      } on PlatformException catch (e) {
        _setTopText(e.toString());
      }
    }
  }

  void _deleteGeofenceListWithIds() async {
    if (_requestCode == null) {
      _setTopText("Call createGeofenceList method first.");
    } else {
      try {
        await _geofenceService.deleteGeofenceListWithIds(_geofenceIdList);
        _requestCode = null;
        _setBottomText();
        _setTopText("Geofence list is successfully deleted.");
      } on PlatformException catch (e) {
        _setTopText(e.toString());
      }
    }
  }

  void _deleteGeofenceListOnDispose() async {
    if (_requestCode != null) {
      try {
        await _geofenceService.deleteGeofenceList(_requestCode);
        _requestCode = null;
      } on PlatformException catch (e) {
        log(e.toString());
      }
    }
  }

  void _removeGeofence() {
    if (_geofenceList.isEmpty) {
      _setTopText("Geofence list is empty. Add geofence first.");
    }

    final String uniqueId = _uniqueId.text;

    if (uniqueId.isEmpty) {
      _setTopText("Enter unique id of the Geofence to remove it.");
    } else if (!_geofenceIdList.contains(uniqueId)) {
      _setTopText("Id '$uniqueId' does not exist on Geofence list.");
    } else {
      _geofenceIdList.remove(uniqueId);
      _geofenceList.removeWhere((e) => e.uniqueId == uniqueId);
      setState(() {
        _fenceCount = _geofenceList.length;
        _geofenceListText = _geofenceIdList.toString();
      });
    }
  }

  void _navigateAndWaitData(BuildContext context) async {
    final dynamic result = await Navigator.pushNamed(
        context, AddGeofenceScreen.ROUTE_NAME,
        arguments: {
          'geofenceList': _geofenceList,
          'geofenceIdList': _geofenceIdList,
        });
    setState(() {
      _fenceCount = _geofenceList.length;
      _geofenceListText = result['geofenceIdList'].toString();
    });
  }

  void _setTopText([String text = ""]) {
    setState(() {
      _topText = text;
    });
  }

  void _setBottomText([String text = ""]) {
    setState(() {
      _bottomText = text;
    });
  }

  void _appendToBottomText(String text) {
    setState(() {
      _bottomText = "$_bottomText\n\n$text";
    });
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
                  child: Text(_topText),
                ),
                Divider(
                  thickness: 0.1,
                  color: Colors.black,
                ),
                Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text("Geofences: $_fenceCount"),
                        SizedBox(height: 15),
                        Text(_geofenceListText),
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
                    Btn("hasPermission", _hasPermission),
                    Btn("requestPermission", _requestPermission),
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
                          controller: _uniqueId,
                          labelText: "Geofence UniqueId",
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Flexible(
                        flex: 6,
                        child: Container(
                          height: 45,
                          child: Btn("Remove Geofence", _removeGeofence),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.1,
                  color: Colors.black,
                ),
                Btn("createGeofenceList", _createGeofenceList),
                Btn("deleteGeofenceList", _deleteGeofenceList),
                Btn("deleteGeofenceListWithIds", _deleteGeofenceListWithIds),
                Text(_bottomText),
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
    _deleteGeofenceListOnDispose();
    _streamSubscription.cancel();
  }
}
