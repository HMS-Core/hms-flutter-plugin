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

class MotionCaptureView extends StatelessWidget {
  /// If using video frames, set isPhoto to false.
  final bool isPhoto;

  const MotionCaptureView({
    required this.onViewCreated,
    Key? key,
    this.isPhoto = true,
  }) : super(key: key);

  final void Function(
    MotionCaptureViewController controller,
  ) onViewCreated;

  @override
  Widget build(BuildContext context) {
    return AndroidView(
      viewType: 'com.huawei.hms.flutter.modeling3d/motionCaptureView',
      onPlatformViewCreated: (int viewId) {
        onViewCreated.call(
          MotionCaptureViewController._(viewId),
        );
      },
      creationParamsCodec: const StandardMessageCodec(),
      creationParams: <String, dynamic>{
        'isPhoto': isPhoto,
      },
    );
  }
}
