/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_adsprime.dart';

class Bundle {
  static const String _int = 'int';
  static const String _intList = 'intList';
  static const String _string = 'String';
  static const String _stringList = 'StringList';
  static const String _bool = 'bool';
  static const String _boolList = 'boolList';

  final Map<String, Map<String, dynamic>> bundle =
      <String, Map<String, dynamic>>{};

  void putInt(String key, int? i) {
    bundle[key] = <String, dynamic>{
      'type': _int,
      'val': i,
    };
  }

  void putIntegerArrayList(String key, List<int> arr) {
    bundle[key] = <String, dynamic>{
      'type': _intList,
      'val': arr,
    };
  }

  void putString(String key, String? s) {
    bundle[key] = <String, dynamic>{
      'type': _string,
      'val': s,
    };
  }

  void putStringArrayList(String key, List<String> arr) {
    bundle[key] = <String, dynamic>{
      'type': _stringList,
      'val': arr,
    };
  }

  void putBoolean(String key, bool b) {
    bundle[key] = <String, dynamic>{
      'type': _bool,
      'val': b,
    };
  }

  void putBooleanArrayList(String key, List<bool> arr) {
    bundle[key] = <String, dynamic>{
      'type': _boolList,
      'val': arr,
    };
  }

  int? getInt(String key) {
    if (bundle[key] != null && bundle[key]!['type'] == _int) {
      return bundle[key]!['val'];
    }
    return null;
  }

  List<int>? getIntegerArrayList(String key) {
    if (bundle[key] != null && bundle[key]!['type'] == _intList) {
      return bundle[key]!['val'];
    }
    return null;
  }

  String? getString(String key) {
    if (bundle[key] != null && bundle[key]!['type'] == _string) {
      return bundle[key]!['val'];
    }
    return null;
  }

  List<String>? getArrayString(String key) {
    if (bundle[key] != null && bundle[key]!['type'] == _stringList) {
      return bundle[key]!['val'];
    }
    return null;
  }

  bool? getBoolean(String key) {
    if (bundle[key] != null && bundle[key]!['type'] == _bool) {
      return bundle[key]!['val'];
    }
    return null;
  }

  List<bool>? getBooleanArrayList(String key) {
    if (bundle[key] != null && bundle[key]!['type'] == _boolList) {
      return bundle[key]!['val'];
    }
    return null;
  }
}
