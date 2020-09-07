/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

class MlBorder {
  dynamic bottom;
  dynamic top;
  dynamic left;
  dynamic right;
  dynamic exactCenterX;
  dynamic centerY;
  dynamic centerX;
  dynamic describeContents;
  dynamic height;
  dynamic width;

  MlBorder(
      {this.bottom,
      this.top,
      this.left,
      this.right,
      this.exactCenterX,
      this.centerY,
      this.centerX,
      this.describeContents,
      this.height,
      this.width});

  MlBorder.fromJson(Map<String, dynamic> json) {
    bottom = json['bottom'] ?? null;
    top = json['top'] ?? null;
    left = json['left'] ?? null;
    right = json['right'] ?? null;
    exactCenterX = json['exactCenterX'] ?? null;
    centerY = json['centerY'] ?? null;
    centerX = json['centerX'] ?? null;
    describeContents = json['describeContents'] ?? null;
    height = json['height'] ?? null;
    width = json['width'] ?? null;
  }
}
