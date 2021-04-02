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

import 'package:huawei_ml/models/ml_border.dart';

class MLFrameProperty {
  static const int SCREEN_FIRST_QUADRANT = 0;
  static const int SCREEN_SECOND_QUADRANT = 1;
  static const int SCREEN_THIRD_QUADRANT = 2;
  static const int SCREEN_FOURTH_QUADRANT = 3;
  static const int IMAGE_FORMAT_NV21 = 17;
  static const int IMAGE_FORMAT_YV12 = 842094169;

  Ext ext;
  int formatType;
  int height;
  int itemIdentity;
  int quadrant;
  int timestamp;
  int width;

  MLFrameProperty(
      {this.ext,
      this.formatType,
      this.height,
      this.itemIdentity,
      this.quadrant,
      this.timestamp,
      this.width});

  MLFrameProperty.fromJson(Map<String, dynamic> json) {
    ext = json['ext'] != null ? new Ext.fromJson(json['ext']) : null;
    formatType = json['formatType'];
    height = json['height'];
    itemIdentity = json['itemIdentity'];
    quadrant = json['quadrant'];
    timestamp = json['timestamp'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ext != null) {
      data['ext'] = this.ext.toJson();
    }
    data['formatType'] = this.formatType;
    data['height'] = this.height;
    data['itemIdentity'] = this.itemIdentity;
    data['quadrant'] = this.quadrant;
    data['timestamp'] = this.timestamp;
    data['width'] = this.width;
    return data;
  }
}

class Ext {
  MLBorder border;
  int lensId;
  int maxZoom;
  int zoom;

  Ext({this.lensId, this.maxZoom, this.zoom, this.border});

  Ext.fromJson(Map<String, dynamic> json) {
    lensId = json['lensId'];
    maxZoom = json['maxZoom'];
    zoom = json['zoom'];
    border = json['rect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lensId'] = this.lensId;
    data['maxZoom'] = this.maxZoom;
    data['zoom'] = this.zoom;
    if (this.border != null) {
      data['border'] = this.border.toJson();
    }
    return data;
  }
}
