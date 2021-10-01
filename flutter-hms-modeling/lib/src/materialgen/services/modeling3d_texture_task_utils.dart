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

import '../result/modeling3d_texture_query_result.dart';

class Modeling3dTextureTaskUtils {
  late MethodChannel _c;

  Modeling3dTextureTaskUtils() {
    _c = MethodChannel("com.huawei.modeling3d.materialtask/method");
  }

  /// Queries the status of a material generation task.
  Future<Modeling3dTextureQueryResult> queryTask(String taskId) async {
    return Modeling3dTextureQueryResult.fromMap(
        await _c.invokeMethod("queryTask", {'taskId': taskId}));
  }

  /// Deletes a material generation task using its ID.
  Future<int> deleteTask(String taskId) async {
    return await _c.invokeMethod("deleteTask", {'taskId': taskId});
  }

  /// Sets the restriction status of a material generation task using its ID.
  Future<int> setTaskRestrictStatus(String taskId, int restrictStatus) async {
    return await _c.invokeMethod("setTaskRestrictStatus",
        {'taskId': taskId, 'restrictStatus': restrictStatus});
  }

  /// Queries the restriction status of a material generation task using its ID.
  Future<int> queryTaskRestrictStatus(String taskId) async {
    return await _c.invokeMethod("queryTaskRestrictStatus", {'taskId': taskId});
  }
}
