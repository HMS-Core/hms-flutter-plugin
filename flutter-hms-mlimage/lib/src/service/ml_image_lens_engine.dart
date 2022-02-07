import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:huawei_ml_image/huawei_ml_image.dart';
import 'package:huawei_ml_image/src/common/constants.dart';
import 'package:huawei_ml_image/src/common/method.dart';
import 'package:huawei_ml_image/src/request/ml_image_lens_controller.dart';
import 'package:huawei_ml_image/src/result/ml_image_segmentation.dart';

class MLImageLensEngine {
  late MethodChannel _channel;
  final MLImageLensController controller;

  ImageTransactor? _transactor;

  MLImageLensEngine({required this.controller}) {
    _channel = _initMethodChannel();
  }

  MethodChannel _initMethodChannel() {
    const channel = MethodChannel("$baseChannel.image_lens");
    channel.setMethodCallHandler(_onMethodCall);
    return channel;
  }

  void _setup() {
    _channel.invokeMethod(setup, controller.toMap());
  }

  Future<int> init({int? width, int? height}) async {
    _setup();
    return await _channel.invokeMethod(mInit, {
      'width': width ?? 1440,
      'height': height ?? 1080,
    });
  }

  void run() {
    _channel.invokeMethod(mRun);
  }

  Future<bool> release() async {
    final bool res = await _channel.invokeMethod(mRelease);
    return res;
  }

  Future<Uint8List> capture() async {
    return await _channel.invokeMethod(mCapture);
  }

  Future<int> zoom(double z) async {
    return await _channel.invokeMethod(mZoom, {'zoom': z});
  }

  Future<int> getLensType() async {
    return await _channel.invokeMethod(mGetLensType);
  }

  Future<Size> getDisplayDimension() async {
    Map<dynamic, dynamic> map = await _channel.invokeMethod(mGetDimensions);
    int width = map['width'];
    int height = map['height'];
    return Size(width.toDouble(), height.toDouble());
  }

  Future<void> switchCamera() async {
    await _channel.invokeMethod(mSwitchCam);
  }

  void setTransactor(ImageTransactor transactor) {
    _transactor = transactor;
  }

  Future<dynamic> _onMethodCall(MethodCall call) {
    Map<dynamic, dynamic> map = call.arguments;

    List res = map['result'] ?? List<dynamic>.empty();

    switch (call.method) {
      case 'classification':
        final clsList =
            res.map((e) => MLImageClassification.fromTransaction(e)).toList();
        _transactor!.call(result: clsList);
        break;
      case 'segmentation':
        final segList = res.map((e) => MLImageSegmentation.fromMap(e)).toList();
        _transactor!.call(result: segList);
        break;
      case 'object':
        final objects = res.map((e) => MLObject.fromMap(map)).toList();
        _transactor!.call(result: objects);
        break;
      case 'scene':
        final scenes = res.map((e) => MLSceneDetection.fromJson(e)).toList();
        _transactor!.call(result: scenes);
        break;
      default:
        throw ArgumentError('Unsupported type of body stream!');
    }
    return Future<dynamic>.value(null);
  }
}
