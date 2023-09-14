/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_ml_image;

class MLImageLensEngine {
  late MethodChannel _channel;
  final MLImageLensController controller;

  ImageTransactor? _transactor;

  MLImageLensEngine({
    required this.controller,
  }) {
    _channel = _initMethodChannel();
  }

  MethodChannel _initMethodChannel() {
    const MethodChannel channel = MethodChannel('$baseChannel.image_lens');
    channel.setMethodCallHandler(_onMethodCall);
    return channel;
  }

  void _setup() {
    _channel.invokeMethod(
      setup,
      controller.toMap(),
    );
  }

  Future<int> init({
    int? width,
    int? height,
  }) async {
    _setup();
    return await _channel.invokeMethod(
      mInit,
      <String, dynamic>{
        'width': width ?? 1440,
        'height': height ?? 1080,
      },
    );
  }

  void run() {
    _channel.invokeMethod(
      mRun,
    );
  }

  Future<bool> release() async {
    final bool res = await _channel.invokeMethod(
      mRelease,
    );
    return res;
  }

  Future<Uint8List> capture() async {
    return await _channel.invokeMethod(
      mCapture,
    );
  }

  Future<int> zoom(double z) async {
    return await _channel.invokeMethod(
      mZoom,
      <String, dynamic>{
        'zoom': z,
      },
    );
  }

  Future<int> getLensType() async {
    return await _channel.invokeMethod(
      mGetLensType,
    );
  }

  Future<Size> getDisplayDimension() async {
    final Map<dynamic, dynamic> map = await _channel.invokeMethod(
      mGetDimensions,
    );
    final int width = map['width'];
    final int height = map['height'];
    return Size(width.toDouble(), height.toDouble());
  }

  Future<void> switchCamera() async {
    await _channel.invokeMethod(
      mSwitchCam,
    );
  }

  void setTransactor(ImageTransactor transactor) {
    _transactor = transactor;
  }

  Future<dynamic> _onMethodCall(MethodCall call) {
    final Map<dynamic, dynamic> map = call.arguments;
    final List<dynamic> res = map['result'] ?? <dynamic>[];

    switch (call.method) {
      case 'classification':
        final List<MLImageClassification> clsList = res
            .map((dynamic e) => MLImageClassification.fromTransaction(e))
            .toList();
        _transactor!.call(result: clsList);
        break;
      case 'segmentation':
        final List<MLImageSegmentation> segList =
            res.map((dynamic e) => MLImageSegmentation.fromMap(e)).toList();
        _transactor!.call(result: segList);
        break;
      case 'object':
        final List<MLObject> objects =
            res.map((dynamic e) => MLObject.fromMap(map)).toList();
        _transactor!.call(result: objects);
        break;
      case 'scene':
        final List<MLSceneDetection> scenes =
            res.map((dynamic e) => MLSceneDetection.fromJson(e)).toList();
        _transactor!.call(result: scenes);
        break;
      default:
        throw ArgumentError('Unsupported type of body stream!');
    }
    return Future<dynamic>.value(null);
  }
}
