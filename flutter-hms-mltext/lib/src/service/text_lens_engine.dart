/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ml_text/src/common/constants.dart';
import 'package:huawei_ml_text/src/request/ml_text_lens_controller.dart';
import 'package:huawei_ml_text/src/result/ml_text.dart';

class MLTextLensEngine {
  late MethodChannel _channel;
  final MLTextLensController controller;

  TextTransactor? _transactor;

  MLTextLensEngine({required this.controller}) {
    _channel = _initMethodChannel();
  }

  MethodChannel _initMethodChannel() {
    const channel = MethodChannel('$baseChannel.lens');
    channel.setMethodCallHandler(_onMethodCall);
    return channel;
  }

  void _setup() {
    _channel.invokeMethod("lens#setup", controller.toMap());
  }

  Future<int> init({int? width, int? height}) async {
    _setup();
    return await _channel.invokeMethod(
        "lens#init", {'width': width ?? 1440, 'height': height ?? 1080});
  }

  void run() {
    _channel.invokeMethod("lens#run");
  }

  Future<bool> release() async {
    final bool res = await _channel.invokeMethod("lens#release");
    return res;
  }

  Future<Uint8List> capture() async {
    return await _channel.invokeMethod("lens#capture");
  }

  Future<void> zoom(double z) async {
    await _channel.invokeMethod("lens#zoom", {'zoom': z});
  }

  Future<int> getLensType() async {
    return await _channel.invokeMethod("lens#getLensType");
  }

  Future<Size> getDisplayDimension() async {
    Map<dynamic, dynamic> map =
        await _channel.invokeMethod("lens#getDimensions");
    int width = map['width'];
    int height = map['height'];
    return Size(width.toDouble(), height.toDouble());
  }

  Future<void> switchCamera() async {
    await _channel.invokeMethod("lens#switchCam");
  }

  void setTransactor(TextTransactor transactor) {
    _transactor = transactor;
  }

  Future<dynamic> _onMethodCall(MethodCall call) {
    Map<dynamic, dynamic> map = call.arguments;

    List res = map['result'] ?? List<dynamic>.empty();

    if (call.method == "text") {
      final blocks = res.map((e) => TextBlock.fromMap(e)).toList();
      _transactor!.call(result: blocks);
    }

    return Future<dynamic>.value(null);
  }
}
