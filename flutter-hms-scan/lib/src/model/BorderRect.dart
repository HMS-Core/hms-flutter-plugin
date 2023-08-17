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

part of huawei_scan;

class HmsBorderRect {
  int left = 2147483647;
  int top = 2147483647;
  int right = -2147483648;
  int bottom = -2147483648;

  double? exactCenterX;
  double? exactCenterY;
  int? centerX;
  int? centerY;
  List<CornerPoint?>? cornerPointsList;

  HmsBorderRect(List<CornerPoint?>? cornerPoints) {
    cornerPointsList = cornerPoints;
    for (int i = 0; i < (cornerPointsList?.length ?? 0); ++i) {
      CornerPoint? point = cornerPointsList![i];
      left = min(left, point?.x ?? left);
      top = min(top, point?.y ?? top);
      right = max(right, point?.x ?? right);
      bottom = max(bottom, point?.y ?? bottom);
    }
    exactCenterX = (left + right) * 0.5;
    exactCenterY = (top + bottom) * 0.5;
    centerX = (left + right) >> 1;
    centerY = (top + bottom) >> 1;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is HmsBorderRect &&
        other.left == left &&
        other.top == top &&
        other.right == right &&
        other.bottom == bottom &&
        other.exactCenterX == exactCenterX &&
        other.exactCenterY == exactCenterY &&
        other.centerX == centerX &&
        other.centerY == centerY &&
        listEquals(other.cornerPointsList, cornerPointsList);
  }

  @override
  int get hashCode {
    return Object.hash(
      left,
      top,
      right,
      bottom,
      exactCenterX,
      exactCenterY,
      centerX,
      centerY,
      cornerPointsList,
    );
  }
}
