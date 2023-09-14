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

part of huawei_ml_image;

class MLModelInputOutputSettings {
  static const int FLOAT32 = 1;
  static const int INT32 = 2;
  static const int BYTE = 3;
  static const int LONG = 4;

  int? _modelDataType;
  final List<int> _inputs = List<int>.filled(4, 0, growable: false);
  final List<int> _outputs = List<int>.filled(2, 0, growable: false);

  /// for example 1 for FLOAT32
  void setDataType(int type) {
    _modelDataType = type;
  }

  /// for example [1, 224, 224, 3]
  void setInputList(List<int> inputList) {
    if (inputList.length < 4) {
      throw 'List length must be 4';
    }
    for (int i = 0; i < _inputs.length; i++) {
      _inputs[i] = inputList[i];
    }
  }

  /// for example [1, 1001]
  void setOutputList(List<int> outputList) {
    if (outputList.length < 2) {
      throw 'List length must be 2';
    }
    for (int i = 0; i < _outputs.length; i++) {
      _outputs[i] = outputList[i];
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': _modelDataType,
      'inputs': _inputs,
      'outputs': _outputs,
    };
  }
}
