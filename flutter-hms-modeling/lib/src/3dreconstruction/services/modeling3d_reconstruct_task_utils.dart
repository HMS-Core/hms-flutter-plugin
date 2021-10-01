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

import 'package:flutter/services.dart';

import '../constants/channel.dart';
import '../result/result_export.dart';

/// Processes 3D object reconstruction tasks.
class Modeling3dReconstructTaskUtils {
  static const MethodChannel _channel = modelling3dRecTaskUtilsMethodChannel;

  static final _instance = Modeling3dReconstructTaskUtils._();

  /// Obtains a Modeling3dReconstructTaskUtils instance.
  static Future<Modeling3dReconstructTaskUtils> get instance async {
    await _channel.invokeMethod("getInstance");
    return _instance;
  }

  Modeling3dReconstructTaskUtils._();

  /// Queries the status of a 3D object reconstruction task.
  Future<Modeling3dReconstructQueryResult> queryTask(String taskId) async {
    final resultMap =
        await _channel.invokeMethod("queryTask", {"taskId": taskId});
    return Modeling3dReconstructQueryResult.fromMap(
        Map<String, dynamic>.from(resultMap));
  }

  /// Deletes a 3D object reconstruction task using its ID.
  Future<int> deleteTask(String taskId) async {
    return await _channel.invokeMethod("deleteTask", {"taskId": taskId});
  }

  /// Sets the restriction status of a 3D object reconstruction task using its ID.
  Future<int> setTaskRestrictStatus(String taskId, int restrictStatus) async {
    return await _channel.invokeMethod("setTaskRestrictStatus",
        {"taskId": taskId, "restrictStatus": restrictStatus});
  }

  /// Sets the restriction status of a 3D object reconstruction task using its ID.
  Future<int> queryTaskRestrictStatus(String taskId) async {
    return await _channel
        .invokeMethod("queryTaskRestrictStatus", {"taskId": taskId});
  }
}
