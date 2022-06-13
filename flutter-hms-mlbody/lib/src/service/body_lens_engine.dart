/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:huawei_ml_body/src/common/constants.dart';
import 'package:huawei_ml_body/src/request/ml_body_lens_controller.dart';
import 'package:huawei_ml_body/src/result/ml_3d_face.dart';
import 'package:huawei_ml_body/src/result/ml_face.dart';
import 'package:huawei_ml_body/src/result/ml_gesture.dart';
import 'package:huawei_ml_body/src/result/ml_hand_keypoints.dart';
import 'package:huawei_ml_body/src/result/ml_skeleton.dart';

class MLBodyLensEngine {
  late MethodChannel _c;
  final MLBodyLensController controller;

  BodyTransactor? _transactor;
  bool _isRunning = false;

  MLBodyLensEngine({required this.controller}) {
    _c = _initMethodChannel();
  }

  MethodChannel _initMethodChannel() {
    const channel = MethodChannel('$baseChannel.lens');
    channel.setMethodCallHandler(_onMethodCall);
    return channel;
  }

  void _setup() {
    _c.invokeMethod("lens#setup", controller.toMap());
  }

  Future<int> init({int? width, int? height}) async {
    _setup();
    return await _c.invokeMethod(
        "lens#init", {'width': width ?? 1440, 'height': height ?? 1080});
  }

  void run() {
    if (_isRunning) {
      return;
    }
    _isRunning = true;
    _c.invokeMethod("lens#run");
  }

  Future<bool> release() async {
    final bool res = await _c.invokeMethod("lens#release");
    if (res) {
      _isRunning = false;
    }
    return res;
  }

  Future<Uint8List> capture() async {
    return await _c.invokeMethod("lens#capture");
  }

  Future<int> zoom(double z) async {
    return await _c.invokeMethod("lens#zoom", {'zoom': z});
  }

  Future<int> getLensType() async {
    return await _c.invokeMethod("lens#getLensType");
  }

  Future<Size> getDisplayDimension() async {
    Map<dynamic, dynamic> map = await _c.invokeMethod("lens#getDimensions");
    int width = map['width'];
    int height = map['height'];
    return Size(width.toDouble(), height.toDouble());
  }

  Future<void> switchCamera() async {
    await _c.invokeMethod("lens#switchCam");
  }

  void setTransactor(BodyTransactor transactor) {
    _transactor = transactor;
  }

  Future<dynamic> _onMethodCall(MethodCall call) {
    Map<dynamic, dynamic> map = call.arguments;

    List res = map['result'] ?? List<dynamic>.empty();

    switch (call.method) {
      case 'face':
        final faces = res.map((e) => MLFace.fromMap(e)).toList();
        _transactor!.call(result: faces);
        break;
      case 'face3d':
        final faces1 = res.map((e) => ML3DFace.fromMap(e)).toList();
        _transactor!.call(result: faces1);
        break;
      case 'skeleton':
        final skl = res.map((e) => MLSkeleton.fromMap(e)).toList();
        _transactor!.call(result: skl);
        break;
      case 'hand':
        final hands = res.map((e) => MLHandKeyPoints.fromMap(e)).toList();
        _transactor!.call(result: hands);
        break;
      case 'gesture':
        final gestures = res.map((e) => MLGesture.fromMap(e)).toList();
        _transactor!.call(result: gestures);
        break;
      default:
        throw ArgumentError('Unsupported type of body stream!');
    }
    return Future<dynamic>.value(null);
  }
}
