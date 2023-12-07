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

part of huawei_map;

@immutable
class MyLocationStyle {
  final Offset anchor;
  final Color radiusFillColor;
  final BitmapDescriptor? icon;

  const MyLocationStyle({
    required this.anchor,
    required this.radiusFillColor,
    this.icon,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is MyLocationStyle &&
        anchor == other.anchor &&
        radiusFillColor == other.radiusFillColor &&
        icon == other.icon;
  }

  @override
  int get hashCode => Object.hash(anchor, icon, radiusFillColor);
}
