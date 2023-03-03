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

/// Initialization result of a 3D object reconstruction task.
class Modeling3dReconstructInitResult {
  /// ID of a 3D object reconstruction task.
  /// A unique task ID is generated each time the 3D object reconstruction API is called.
  final String taskId;

  /// Result code for a 3D object reconstruction task.
  final int retCode;

  /// Description of the result code for 3D object reconstruction task initialization.
  final String retMsg;

  const Modeling3dReconstructInitResult._({
    required this.taskId,
    required this.retCode,
    required this.retMsg,
  });

  factory Modeling3dReconstructInitResult._fromMap(Map<dynamic, dynamic> map) {
    return Modeling3dReconstructInitResult._(
      taskId: map['taskId'],
      retCode: map['retCode'],
      retMsg: map['retMsg'],
    );
  }

  @override
  String toString() {
    return '$Modeling3dReconstructInitResult('
        'taskId: $taskId, '
        'retCode: $retCode, '
        'retMsg: $retMsg)';
  }
}
