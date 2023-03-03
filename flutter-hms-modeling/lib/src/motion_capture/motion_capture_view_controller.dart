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

part of motion_capture;

class MotionCaptureViewController {
  late final MethodChannel _channel;

  MotionCaptureViewController._(int viewId) {
    _channel = MethodChannel(
      'com.huawei.hms.flutter.modeling3d/motionCaptureView/$viewId',
    );
  }

  /// Detects skeleton points in an input image in synchronous mode.
  Future<List<Modeling3dMotionCaptureSkeleton>> analyseFrame(
    String path,
  ) async {
    final List<dynamic> res = await _channel.invokeMethod(
      'analyseFrame',
      <String, dynamic>{
        'path': path,
      },
    );
    return res
        .map((dynamic e) => Modeling3dMotionCaptureSkeleton._fromMap(e))
        .toList();
  }

  /// Detects skeleton points in an input image in asynchronous mode.
  Future<List<Modeling3dMotionCaptureSkeleton>> asyncAnalyseFrame(
    String path,
  ) async {
    final List<dynamic> res = await _channel.invokeMethod(
      'asyncAnalyseFrame',
      <String, dynamic>{
        'path': path,
      },
    );
    return res
        .map((dynamic e) => Modeling3dMotionCaptureSkeleton._fromMap(e))
        .toList();
  }

  /// Releases the resources used by the motion capture engine.
  Future<void> stop() async {
    await _channel.invokeMethod(
      'stop',
    );
  }
}
