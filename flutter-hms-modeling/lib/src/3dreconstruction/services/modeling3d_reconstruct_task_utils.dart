/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of objreconstruct;

/// Processes 3D object reconstruction tasks.
abstract class Modeling3dReconstructTaskUtils {
  static const MethodChannel _c = MethodChannel(
    'com.huawei.hms.flutter.modeling3d/reconstructTaskUtils/method',
  );

  /// Queries the status of a 3D object reconstruction task.
  static Future<Modeling3dReconstructQueryResult> queryTask(
    String taskId,
  ) async {
    final Map<dynamic, dynamic> result = await _c.invokeMethod(
      'queryTask',
      <String, dynamic>{
        'taskId': taskId,
      },
    );
    return Modeling3dReconstructQueryResult._fromMap(result);
  }

  /// Deletes a 3D object reconstruction task using its ID.
  /// Returns deletion result. 0 indicates success, and other values indicate failure.
  static Future<int> deleteTask(String taskId) async {
    return await _c.invokeMethod(
      'deleteTask',
      <String, dynamic>{
        'taskId': taskId,
      },
    );
  }

  /// Sets the restriction status of a 3D object reconstruction task using its ID.
  /// Check [Modeling3dReconstructConstants.restrictStatus] for more.
  /// Returns restriction status setting result. 0 indicates success, and other values indicate failure.
  static Future<int> setTaskRestrictStatus(
    String taskId,
    int restrictStatus,
  ) async {
    return await _c.invokeMethod(
      'setTaskRestrictStatus',
      <String, dynamic>{
        'taskId': taskId,
        'restrictStatus': restrictStatus,
      },
    );
  }

  /// Queries the restriction status of a 3D object reconstruction task using its ID.
  /// Returns restriction status.
  /// 0 indicates that the task is not restricted.
  /// 1 indicates that the task is restricted.
  /// Other values indicate a query failure.
  static Future<int> queryTaskRestrictStatus(String taskId) async {
    return await _c.invokeMethod(
      'queryTaskRestrictStatus',
      <String, dynamic>{
        'taskId': taskId,
      },
    );
  }
}
