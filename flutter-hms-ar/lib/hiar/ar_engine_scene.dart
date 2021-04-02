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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/channel.dart' as CHANNEL;
import '../constants/constants.dart';
import 'ar_body.dart';
import 'ar_engine.dart';
import 'ar_face.dart';
import 'ar_hand.dart';
import 'ar_plane.dart';
import 'ar_scene_config.dart';
import 'ar_trackable_base.dart';

typedef void ARSceneCreatedCallback(ARSceneController controller);
typedef void ARTrackableCallback(ARTrackableBase arTrackable);

enum ARSceneType { HAND, FACE, BODY, WORLD }

class AREngineScene extends StatefulWidget {
  final double height;
  final double width;

  final ARSceneType arSceneType;
  final ARSceneBaseConfig arSceneConfig;
  final ARSceneCreatedCallback onArSceneCreated;

  final String notSupportedText;
  final String permissionTitleText;
  final String permissionBodyText;
  final String permissionButtonText;

  final TextStyle notSupportedTextStyle;
  final TextStyle permissionTitleTextStyle;
  final TextStyle permissionBodyTextStyle;
  final TextStyle permissionButtonTextStyle;

  final Color permissionButtonColor;
  final Color permissionMessageBgColor;

  static const TextStyle _permissionTitleTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white);

  static const TextStyle _permissionBodyTextStyle =
      TextStyle(color: Colors.white);

  static const TextStyle _permissionButtonTextStyle =
      TextStyle(fontWeight: FontWeight.bold);

  AREngineScene(
    this.arSceneType,
    this.arSceneConfig, {
    Key key,
    this.height,
    this.width,
    this.onArSceneCreated,
    this.notSupportedText = Constants.NOT_SUPPORTED,
    this.permissionTitleText = Constants.PERMISSION_TITLE,
    this.permissionBodyText = Constants.PERMISSION_BODY_MESSAGE,
    this.permissionButtonText = Constants.PERMISSION_BUTTON_TEXT,
    this.permissionTitleTextStyle = _permissionTitleTextStyle,
    this.permissionBodyTextStyle = _permissionBodyTextStyle,
    this.notSupportedTextStyle = _permissionButtonTextStyle,
    this.permissionButtonTextStyle = _permissionButtonTextStyle,
    this.permissionButtonColor = Colors.white,
    this.permissionMessageBgColor = Colors.green,
  }) : super(key: key);

  @override
  _AREngineSceneState createState() => _AREngineSceneState();
}

class _AREngineSceneState extends State<AREngineScene>
    with WidgetsBindingObserver {
  bool _hasPermission = false;

  MethodChannel _channel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkCameraPermission();
  }

  void checkCameraPermission() async {
    if (!mounted) return;
    AREngine.hasCameraPermission().then((value) => setState(() {
          _hasPermission = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      if (_hasPermission) {
        return Container(
          height: widget.height,
          width: widget.width,
          child: AndroidView(
            key: widget.key,
            viewType: Constants.VIEW_TYPE,
            onPlatformViewCreated: _onPlatformViewCreated,
            creationParams: widget.arSceneConfig.getARSceneConfig(),
            creationParamsCodec: const JSONMessageCodec(),
          ),
        );
      } else {
        return Container(
          height: widget.height,
          width: widget.width,
          color: widget.permissionMessageBgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.permissionTitleText,
                textAlign: TextAlign.center,
                style: widget.permissionTitleTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.permissionBodyText,
                textAlign: TextAlign.center,
                style: widget.permissionBodyTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                child: Text(
                  widget.permissionButtonText,
                  style: widget.permissionButtonTextStyle,
                ),
                color: widget.permissionButtonColor,
                onPressed: () {
                  AREngine.requestCameraPermission()
                      .then((_) => checkCameraPermission());
                },
              )
            ],
          ),
        );
      }
    }
    return Text(
      "$defaultTargetPlatform ${widget.notSupportedText}",
      style: widget.notSupportedTextStyle,
    );
  }

  void _onPlatformViewCreated(int id) {
    if (widget.onArSceneCreated == null) {
      return;
    }
    _channel = MethodChannel(CHANNEL.AR_SCENE_METHOD_CHANNEL + id.toString());
    widget.onArSceneCreated(ARSceneController._(id, _channel));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class ARSceneController {
  final MethodChannel _channel;
  ARTrackableCallback onDetectTrackable;

  ARSceneController._(int id, this._channel) {
    _channel.setMethodCallHandler((call) => _onMethodCallHandler(call));
  }

  _onMethodCallHandler(MethodCall call) {
    switch (call.method) {
      case "onDetectTrackable#Hand":
        _onDetectARHand(call);
        break;
      case "onDetectTrackable#Face":
        _onDetectARFace(call);
        break;
      case "onDetectTrackable#Body":
        _onDetectARBody(call);
        break;
      case "onDetectTrackable#Plane":
        _onDetectARPlane(call);
        break;
    }
  }

  _onDetectARHand(MethodCall call) {
    ARHand arHand;
    try {
      if (call.arguments != null) {
        arHand = ARHand.fromJSON(call.arguments);
        onDetectTrackable(arHand);
      }
    } catch (e) {
      debugPrint("Cannot convert json arguments to ARHand. " + e.toString());
    }
  }

  _onDetectARFace(MethodCall call) {
    ARFace arFace;
    try {
      if (call.arguments != null) {
        arFace = ARFace.fromJSON(call.arguments);
        onDetectTrackable(arFace);
      }
    } catch (e) {
      debugPrint("Cannot convert json arguments to ARFace. " + e.toString());
    }
  }

  _onDetectARBody(MethodCall call) {
    ARBody arBody;
    try {
      if (call.arguments != null) {
        arBody = ARBody.fromJSON(call.arguments);
        onDetectTrackable(arBody);
      }
    } catch (e) {
      debugPrint("Cannot convert json arguments to ARBody. " + e.toString());
    }
  }

  _onDetectARPlane(MethodCall call) {
    ARPlane arPlane;
    try {
      if (call.arguments != null) {
        arPlane = ARPlane.fromJSON(call.arguments);
        onDetectTrackable(arPlane);
      }
    } catch (e) {
      debugPrint("Cannot convert json arguments to ARPlane. " + e.toString());
    }
  }

  void dispose() async {
    _channel.invokeMethod("dispose");
  }
}
