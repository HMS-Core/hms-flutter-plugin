/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

/// Huawei AREngine Flutter Plugin Constants
abstract class Constants {
  static const String VIEW_TYPE = "com.huawei.flutter.hms.ar.ar_scene_view";

  static const String NOT_SUPPORTED = "platform doesn't supported by Huawei "
      "AREngine Flutter Plugin.";

  static const String PERMISSION_TITLE = "Camera Permission Required";

  static const String PERMISSION_BODY_MESSAGE =
      "AREngine Needs the Camera Permission to display the "
      "ARScene";

  static const String PERMISSION_BUTTON_TEXT = "Request Camera Permission";
}
