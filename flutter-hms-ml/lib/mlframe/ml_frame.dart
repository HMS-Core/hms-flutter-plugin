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

import 'package:flutter/services.dart';
import 'package:huawei_ml/models/ml_frame_property.dart';
import 'package:huawei_ml/utils/channels.dart';

class MLFrame {
  static const int SCREEN_FIRST_QUADRANT = 0;
  static const int SCREEN_SECOND_QUADRANT = 1;
  static const int SCREEN_THIRD_QUADRANT = 2;
  static const int SCREEN_FOURTH_QUADRANT = 3;

  final MethodChannel _channel = Channels.frameMethodChannel;
  MLFrameProperty property;

  MLFrame({this.property});

  MLFrame.fromJson(Map<String, dynamic> json) {
    property = json['property'] != null
        ? MLFrameProperty.fromJson(json['property'])
        : null;
  }

  Future<String> getPreviewBitmap() async {
    return await _channel.invokeMethod("getPreviewBitmap");
  }

  Future<String> readBitmap() async {
    return await _channel.invokeMethod("readBitmap");
  }

  Future<String> rotate(String path, int quadrant) async {
    return await _channel.invokeMethod(
        "rotate", <String, dynamic>{'path': path, 'quadrant': quadrant});
  }
}
