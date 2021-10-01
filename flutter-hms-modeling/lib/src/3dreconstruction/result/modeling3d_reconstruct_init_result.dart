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

/// Initialization result of a 3D object reconstruction task.
class Modeling3dReconstructInitResult {
  final String taskId;
  final int retCode;
  final String retMessage;

  Modeling3dReconstructInitResult._(this.taskId, this.retCode, this.retMessage);

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'retCode': retCode,
      'retMessage': retMessage,
    };
  }

  factory Modeling3dReconstructInitResult.fromMap(Map<String, dynamic> map) {
    return Modeling3dReconstructInitResult._(
      map['taskId'] != null ? map['taskId'] : null,
      map['retCode'] != null ? map['retCode'] : null,
      map['retMsg'] != null ? map['retMsg'] : null,
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
