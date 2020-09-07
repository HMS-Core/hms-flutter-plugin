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

import 'dart:convert';

import 'package:huawei_ml/helpers/product_vision_helpers.dart';

class MlProductVisionSearchSettings {
  String path;
  int largestNumberOfReturns;
  int region;

  MlProductVisionSearchSettings() {
    path = null;
    largestNumberOfReturns = 5;
    region = ProductVisionRegion.REGION_DR_UNKNOWN;
  }

  Map<String, dynamic> toMap() {
    return {
      "settings": {
        "path": json.encode(path),
        "largestNumberOfReturns": largestNumberOfReturns,
        "region": region
      }
    };
  }
}
