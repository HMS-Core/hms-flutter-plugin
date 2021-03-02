/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'dart:typed_data';
import 'package:flutter/material.dart' show Image;

/// Remove the null entries on a map instance.
Map<String, dynamic> removeNulls(Map<String, dynamic> map) {
  return map..removeWhere((k, v) => v == null);
}

/// Returns Image from Uint8List
Image imageFromUInt8List(Uint8List data) {
  return Image.memory(data);
}
