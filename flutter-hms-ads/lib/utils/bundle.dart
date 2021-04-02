/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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
class Bundle {
  Map<String, Map<String, dynamic>> _bundle;
  static const String _int = "int";
  static const String _intList = "intList";
  static const String _string = "String";
  static const String _stringList = "StringList";
  static const String _bool = "bool";
  static const String _boolList = "boolList";

  Bundle() {
    _bundle = new Map<String, Map<String, dynamic>>();
  }

  get bundle => _bundle;

  void putInt(String key, int i) => _bundle[key] = {"type": _int, "val": i};
  void putIntegerArrayList(String key, List<int> arr) =>
      _bundle[key] = {"type": _intList, "val": arr};
  void putString(String key, String s) =>
      _bundle[key] = {"type": _string, "val": s};
  void putStringArrayList(String key, List<String> arr) =>
      _bundle[key] = {"type": _stringList, "val": arr};
  void putBoolean(String key, bool b) =>
      _bundle[key] = {"type": _bool, "val": b};
  void putBooleanArrayList(String key, List<bool> arr) =>
      _bundle[key] = {"type": _boolList, "val": arr};

  int getInt(String key) {
    if (_bundle[key] != null && _bundle[key]["type"] == _int)
      return _bundle[key]["val"];
    return null;
  }

  List<int> getIntegerArrayList(String key) {
    if (_bundle[key] != null && _bundle[key]["type"] == _intList)
      return _bundle[key]["val"];
    return null;
  }

  String getString(String key) {
    if (_bundle[key] != null && _bundle[key]["type"] == _string)
      return _bundle[key]["val"];
    return null;
  }

  List<String> getArrayString(String key) {
    if (_bundle[key] != null && _bundle[key]["type"] == _stringList)
      return _bundle[key]["val"];
    return null;
  }

  bool getBoolean(String key) {
    if (_bundle[key] != null && _bundle[key]["type"] == _bool)
      return _bundle[key]["val"];
    return null;
  }

  List<bool> getBooleanArrayList(String key) {
    if (_bundle[key] != null && _bundle[key]["type"] == _boolList)
      return _bundle[key]["val"];
    return null;
  }
}
