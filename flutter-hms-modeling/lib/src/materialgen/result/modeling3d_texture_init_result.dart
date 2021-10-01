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

class Modeling3dTextureInitResult {
  /// Obtains the ID of a material generation task.
  String? taskId;

  /// Obtains the result code for material generation task initialization.
  int? retCode;

  /// Obtains the description of the result code for material generation task initialization.
  String? retMsg;

  Modeling3dTextureInitResult({this.retCode, this.retMsg, this.taskId});

  factory Modeling3dTextureInitResult.fromMap(Map<dynamic, dynamic> map) {
    return Modeling3dTextureInitResult(
        taskId: map['taskId'], retCode: map['retCode'], retMsg: map['retMsg']);
  }
}
