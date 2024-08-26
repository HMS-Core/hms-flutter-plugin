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

part of '../../huawei_ml_text.dart';

class MLTextLensEngine {
  late MethodChannel _channel;
  final MLTextLensController controller;
  TextTransactor? _transactor;
  bool _isRunning = false;

  MLTextLensEngine({
    required this.controller,
  }) {
    _channel = _initMethodChannel();
  }

  MethodChannel _initMethodChannel() {
    const MethodChannel channel = MethodChannel('$baseChannel.lens');
    channel.setMethodCallHandler(_onMethodCall);
    return channel;
  }

  void _setup() {
    _channel.invokeMethod(
      'lens#setup',
      controller.toMap(),
    );
  }

  Future<int> init({
    int? width,
    int? height,
  }) async {
    _setup();
    return await _channel.invokeMethod(
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
    _channel.invokeMethod(
      'lens#run',
    );
  }

  Future<bool> release() async {
    final bool res = await _channel.invokeMethod(
      'lens#release',
    );
    if (res) {
      _isRunning = false;
    }
    return res;
  }

  Future<Uint8List> capture() async {
    return await _channel.invokeMethod(
      'lens#capture',
    );
  }

  Future<void> zoom(double z) async {
    await _channel.invokeMethod(
      'lens#zoom',
      <String, dynamic>{
        'zoom': z,
      },
    );
  }

  Future<int> getLensType() async {
    return await _channel.invokeMethod(
      'lens#getLensType',
    );
  }

  Future<Size> getDisplayDimension() async {
    final Map<dynamic, dynamic> map = await _channel.invokeMethod(
      'lens#getDimensions',
    );
    final int width = map['width'];
    final int height = map['height'];
    return Size(width.toDouble(), height.toDouble());
  }

  Future<void> switchCamera() async {
    await _channel.invokeMethod(
      'lens#switchCam',
    );
  }

  void setTransactor(TextTransactor transactor) {
    _transactor = transactor;
  }

  Future<dynamic> _onMethodCall(MethodCall call) {
    final Map<dynamic, dynamic> map = call.arguments;
    final List<dynamic> res = map['result'] ?? <dynamic>[];

    if (call.method == 'text') {
      final List<TextBlock> blocks = res.map((dynamic e) {
        return TextBlock.fromMap(e);
      }).toList();
      _transactor!.call(result: blocks);
    }
    return Future<dynamic>.value(null);
  }
}
