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

class MLGestureAnalyzer implements MLBodyAnalyzer<MLGesture, String> {
  late MethodChannel _channel;

  MLGestureAnalyzer() {
    _channel = const MethodChannel('$baseChannel.gesture');
  }

  @override
  Future<List<MLGesture>> asyncAnalyseFrame(
    String path,
  ) async {
    if (path.isEmpty) {
      throw ArgumentError('Image path can not be empty!');
    }
    final List<dynamic> res = await _channel.invokeMethod(
      'gesture#asyncAnalyseFrame',
      <String, dynamic>{
        'path': path,
      },
    );
    return res.map((dynamic e) => MLGesture.fromMap(e)).toList();
  }

  @override
  Future<List<MLGesture>> analyseFrame(
    String path,
  ) async {
    if (path.isEmpty) {
      throw ArgumentError('Image path can not be empty!');
    }
    final List<dynamic> res = await _channel.invokeMethod(
      'gesture#analyseFrame',
      <String, dynamic>{
        'path': path,
      },
    );
    return res.map((dynamic e) => MLGesture.fromMap(e)).toList();
  }

  @override
  Future<bool> destroy() async {
    return await _channel.invokeMethod(
      'gesture#destroy',
    );
  }

  @override
  Future<bool> isAvailable() async {
    return await _channel.invokeMethod(
      'gesture#isAvailable',
    );
  }

  Future<bool> stop() async {
    return await _channel.invokeMethod(
      'gesture#stop',
    );
  }
}
