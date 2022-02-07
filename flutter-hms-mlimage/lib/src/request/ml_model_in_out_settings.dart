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

class MLModelInputOutputSettings {
  static const int FLOAT32 = 1;
  static const int INT32 = 2;
  static const int BYTE = 3;
  static const int LONG = 4;

  int? _modelDataType;
  late List<int> _inputs;
  late List<int> _outputs;

  MLModelInputOutputSettings() {
    _inputs = List.filled(4, 0, growable: false);
    _outputs = List.filled(2, 0, growable: false);
  }

  /// for example FLOAT32
  void setDataType(int type) {
    this._modelDataType = type;
  }

  /// for example [1, 224, 224, 3]
  void setInputList(List<int> inputList) {
    if (inputList.length < 4) throw "List length must be 4";

    for (int i = 0; i < _inputs.length; i++) {
      _inputs[i] = inputList[i];
    }
  }

  /// for example [1 1001]
  void setOutputList(List<int> outputList) {
    if (outputList.length < 2) throw "List length must be 2";

    for (int i = 0; i < _outputs.length; i++) {
      _outputs[i] = outputList[i];
    }
  }

  Map toMap() {
    return {"type": _modelDataType, "inputs": _inputs, "outputs": _outputs};
  }
}
