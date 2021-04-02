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

import 'package:flutter/material.dart';

class MLSceneDetection {
  String result;
  dynamic confidence;

  MLSceneDetection({this.confidence, this.result});

  factory MLSceneDetection.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return MLSceneDetection(
        result: json['result'] ?? null, confidence: json['confidence'] ?? null);
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MLSceneDetection &&
        o.confidence == confidence &&
        o.result == result;
  }

  @override
  int get hashCode => hashList([result, confidence]);
}
