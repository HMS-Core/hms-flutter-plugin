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

part of materialgen;

/// Queries the status of a material generation task.
class Modeling3dTextureQueryResult {
  /// ID of a material generation task.
  /// A unique task ID is generated each time the material generation API is called.
  final String taskId;

  /// Status of a material generation task.
  /// Check [Modeling3dTextureConstants.progressStatus] for more.
  final int status;

  /// Result code for a material generation task.
  /// 0 indicates success, and other values indicate failure.
  final int retCode;

  /// Description of the result code for a material generation task.
  final String? retMsg;

  const Modeling3dTextureQueryResult._({
    required this.taskId,
    required this.status,
    required this.retCode,
    required this.retMsg,
  });

  factory Modeling3dTextureQueryResult._fromMap(Map<dynamic, dynamic> map) {
    return Modeling3dTextureQueryResult._(
      taskId: map['taskId'],
      status: map['status'],
      retCode: map['retCode'],
      retMsg: map['retMsg'],
    );
  }

  @override
  String toString() {
    return '$Modeling3dTextureQueryResult('
        'taskId: $taskId, '
        'status: $status, '
        'retCode: $retCode, '
        'retMsg: $retMsg)';
  }
}
