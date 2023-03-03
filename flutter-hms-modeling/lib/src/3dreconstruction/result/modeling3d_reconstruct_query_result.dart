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

/// Queries the status of a 3D object reconstruction task.
class Modeling3dReconstructQueryResult {
  /// ID of a 3D object reconstruction task.
  /// A unique task ID is generated each time the 3D object reconstruction API is called.
  final String taskId;

  /// Status of a 3D object reconstruction task.
  /// Check [Modeling3dReconstructConstants.progressStatus] for more.
  final int status;

  /// Result code for a 3D object reconstruction task.
  final int retCode;

  /// Description of the result code for a 3D object reconstruction task.
  final String? retMessage;

  /// Reason why the 3D object reconstruction task fails.
  final String? reconstructFailMessage;

  /// Supported model file formats.
  final List<String>? modelFormat;

  const Modeling3dReconstructQueryResult._({
    required this.taskId,
    required this.status,
    required this.retCode,
    required this.retMessage,
    required this.reconstructFailMessage,
    required this.modelFormat,
  });

  factory Modeling3dReconstructQueryResult._fromMap(Map<dynamic, dynamic> map) {
    return Modeling3dReconstructQueryResult._(
      taskId: map['taskId'],
      status: map['status'],
      retCode: map['retCode'],
      retMessage: map['retMsg'],
      modelFormat: ((map['modelFormat'] ?? <String>[]) as List<dynamic>)
          .map((dynamic e) => '$e')
          .toList(),
      reconstructFailMessage: map['reconstructFailMessage'],
    );
  }

  @override
  String toString() {
    return '$Modeling3dReconstructQueryResult('
        'taskId: $taskId, '
        'status: $status, '
        'retCode: $retCode, '
        'retMessage: $retMessage, '
        'reconstructFailMessage: $reconstructFailMessage, '
        'modelFormat: $modelFormat)';
  }
}
