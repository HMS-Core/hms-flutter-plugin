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

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:huawei_ml_text/src/common/constants.dart';

class MLTextPermissions {
  late MethodChannel _channel;

  MLTextPermissions() {
    _channel = const MethodChannel("$baseChannel.permission");
  }

  Future<bool> requestPermission(List<TextPermission> permissions) async {
    if (permissions.isEmpty) {
      throw ArgumentError("List of permissions must not be empty");
    }

    List<String> permissionList = [];

    permissions.forEach((element) {
      permissionList.add(describeEnum(element));
    });

    return await _channel.invokeMethod(
        "requestPermission", <String, dynamic>{'list': permissionList});
  }

  Future<bool> hasCameraPermission() async {
    return await _channel.invokeMethod("hasCameraPermission");
  }

  Future<bool> hasStoragePermission() async {
    return await _channel.invokeMethod("hasStoragePermission");
  }
}
