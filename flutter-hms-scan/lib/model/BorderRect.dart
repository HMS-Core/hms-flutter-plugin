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

import 'dart:math' show min, max;
import 'dart:ui' show hashValues;
import 'CornerPoint.dart';

class HmsBorderRect {
  int left = 2147483647;
  int top = 2147483647;
  int right = -2147483648;
  int bottom = -2147483648;

  double exactCenterX;
  double exactCenterY;
  int centerX;
  int centerY;
  List<CornerPoint> cornerPointsList;

  HmsBorderRect(List<CornerPoint> cornerPoints) {
    cornerPointsList = cornerPoints;
    for (int i = 0; i < cornerPointsList.length; ++i) {
      CornerPoint point = cornerPointsList[i];
      left = min(left, point.x);
      top = min(top, point.y);
      right = max(right, point.x);
      bottom = max(bottom, point.y);
    }
    exactCenterX = (left + right) * 0.5;
    exactCenterY = (top + bottom) * 0.5;
    centerX = (left + right) >> 1;
    centerY = (top + bottom) >> 1;
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final HmsBorderRect check = o;
    return o is HmsBorderRect &&
        check.left == left &&
        check.top == top &&
        check.right == right &&
        check.bottom == bottom &&
        check.exactCenterX == exactCenterX &&
        check.exactCenterY == exactCenterY &&
        check.centerX == centerX &&
        check.centerY == centerY &&
        check.cornerPointsList == cornerPointsList;
  }

  @override
  int get hashCode => hashValues(left, top, right, bottom, exactCenterX,
      exactCenterY, centerX, centerY, cornerPointsList);
}
