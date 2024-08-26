/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_ml_body.dart';

class MLBodyLensEngine {
  late MethodChannel _c;
  final MLBodyLensController controller;

  BodyTransactor? _transactor;
  bool _isRunning = false;

  MLBodyLensEngine({
    required this.controller,
  }) {
    _c = _initMethodChannel();
  }

  MethodChannel _initMethodChannel() {
    const MethodChannel channel = MethodChannel('$baseChannel.lens');
    channel.setMethodCallHandler(_onMethodCall);
    return channel;
  }

  void _setup() {
    _c.invokeMethod(
      'lens#setup',
      controller.toMap(),
    );
  }

  Future<int> init({
    int? width,
    int? height,
  }) async {
    _setup();
    return await _c.invokeMethod(
      'lens#init',
      <String, dynamic>{
        'width': width ?? 1440,
        'height': height ?? 1080,
      },
    );
  }

  void run() {
    if (_isRunning) {
      return;
    }
    _isRunning = true;
    _c.invokeMethod(
      'lens#run',
    );
  }

  Future<bool> release() async {
    final bool res = await _c.invokeMethod(
      'lens#release',
    );
    if (res) {
      _isRunning = false;
    }
    return res;
  }

  Future<Uint8List> capture() async {
    return await _c.invokeMethod(
      'lens#capture',
    );
  }

  Future<int> zoom(double z) async {
    return await _c.invokeMethod(
      'lens#zoom',
      <String, dynamic>{
        'zoom': z,
      },
    );
  }

  Future<int> getLensType() async {
    return await _c.invokeMethod(
      'lens#getLensType',
    );
  }

  Future<Size> getDisplayDimension() async {
    final Map<dynamic, dynamic> map = await _c.invokeMethod(
      'lens#getDimensions',
    );
    final int width = map['width'];
    final int height = map['height'];
    return Size(
      width.toDouble(),
      height.toDouble(),
    );
  }

  Future<void> switchCamera() async {
    await _c.invokeMethod(
      'lens#switchCam',
    );
  }

  void setTransactor(BodyTransactor transactor) {
    _transactor = transactor;
  }

  Future<dynamic> _onMethodCall(MethodCall call) {
    final Map<dynamic, dynamic> map = call.arguments;
    final List<dynamic> res = map['result'] ?? <dynamic>[];

    switch (call.method) {
      case 'face':
        final List<MLFace> faces =
            res.map((dynamic e) => MLFace.fromMap(e)).toList();
        _transactor!.call(
          result: faces,
        );
        break;
      case 'face3d':
        final List<ML3DFace> faces1 =
            res.map((dynamic e) => ML3DFace.fromMap(e)).toList();
        _transactor!.call(
          result: faces1,
        );
        break;
      case 'skeleton':
        final List<MLSkeleton> skl =
            res.map((dynamic e) => MLSkeleton.fromMap(e)).toList();
        _transactor!.call(
          result: skl,
        );
        break;
      case 'hand':
        final List<MLHandKeyPoints> hands =
            res.map((dynamic e) => MLHandKeyPoints.fromMap(e)).toList();
        _transactor!.call(
          result: hands,
        );
        break;
      case 'gesture':
        final List<MLGesture> gestures =
            res.map((dynamic e) => MLGesture.fromMap(e)).toList();
        _transactor!.call(
          result: gestures,
        );
        break;
      default:
        throw ArgumentError('Unsupported type of body stream!');
    }
    return Future<dynamic>.value(null);
  }
}
