/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_health;

/// Defines the options for adding a customized data type to Health Kit.
class DataTypeAddOptions {
  String? name;
  List<Field> fields = <Field>[];

  DataTypeAddOptions(
    this.name,
    this.fields,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'fields': List<Map<String, dynamic>>.from(
        fields.map((Field e) => e.toMap()),
      ),
    }..removeWhere((String k, dynamic v) => v == null);
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(Object other) {
    return other is DataTypeAddOptions &&
        other.name == name &&
        listEquals(other.fields, fields);
  }

  @override
  int get hashCode {
    return Object.hash(
      name,
      Object.hashAll(fields),
    );
  }
}
