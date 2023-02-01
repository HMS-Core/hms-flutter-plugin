/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_ar;

/// The coordinate system type.
///
/// Index of this enum corresponds to the value+1 of the Native AREngine SDK.
enum ARCoordinateSystemType {
  /// Unknown coordinate system.
  COORDINATE_SYSTEM_TYPE_UNKNOWN,

  /// World coordinate system
  COORDINATE_SYSTEM_TYPE_3D_WORLD,

  /// Local coordinate system.
  COORDINATE_SYSTEM_TYPE_3D_SELF,

  /// OpenGL NDC coordinate system.
  COORDINATE_SYSTEM_TYPE_2D_IMAGE,

  /// Camera coordinate system.
  COORDINATE_SYSTEM_TYPE_3D_CAMERA,
}

/// The lighting estimate mode.
class LightMode {
  /// Do not enable the lighting estimate capability.
  static const LightMode NONE = LightMode._(0);

  /// Enable the lighting intensity estimate capability.
  static const LightMode AMBIENT_INTENSITY = LightMode._(1);

  /// Enable the ambient lighting estimate capability.
  static const LightMode ENVIRONMENT_LIGHTING = LightMode._(2);

  /// Enable the lighting environment texture estimate capability.
  static const LightMode ENVIRONMENT_TEXTURE = LightMode._(4);

  /// Enable all lighting estimate capabilities.
  static const LightMode ALL = LightMode._(65535);

  final int value;
  const LightMode._(this.value);
}

/// The power consumption mode.
enum PowerMode {
  /// Common mode.
  NORMAL,

  /// Power saving mode.
  POWER_SAVING,

  /// Ultra power saving mode.
  ULTRA_POWER_SAVING,

  /// Performance first.
  PERFORMANCE_FIRST,
}

/// The focus mode.
enum FocusMode {
  /// Fixed focus to infinity focus.
  FIXED_FOCUS,

  /// Auto focus.
  AUTO_FOCUS,
}

/// The update mode.
enum UpdateMode {
  /// The update() method of ARSession returns data only when a new frame is available.
  BLOCKING,

  /// The update() method of ARSession returns data immediately.
  LATEST_CAMERA_IMAGE,
}

/// The camera type, which can be front or rear.
enum CameraLensFacing {
  /// Rear camera.
  REAR,

  /// Front camera.
  FRONT,
}

/// The semantic mode.
enum SemanticMode {
  /// Disable semantic recognition.
  NONE,

  /// Enable the plane semantic recognition mode.
  PLANE,

  /// Enable the target semantic recognition mode.
  TARGET,

  /// All.
  ALL,
}

/// The plane finding mode.
enum PlaneFindingMode {
  /// Plane detection is disabled.
  DISABLED,

  /// Plane detection is enabled, including horizontal and vertical planes.
  ENABLE,

  /// Only the horizontal plane is detected.
  HORIZONTAL_ONLY,

  /// Only the vertical plane is detected.
  VERTICAL_ONLY,
  
}

/// Huawei AREngine Flutter Plugin Constants
abstract class Constants {
  static const String VIEW_TYPE = 'com.huawei.flutter.hms.ar.ar_scene_view';

  static const String NOT_SUPPORTED = "platform doesn't supported by Huawei "
      'AREngine Flutter Plugin.';
}
