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

import 'dart:ui';

import 'package:huawei_health/src/hihealth/data/field.dart';
import 'package:huawei_health/src/hihealth/util/util.dart';

/// Defines the options for adding a customized data type to Health Kit.
class DataTypeAddOptions {
  String name;
  List<Field> fields;

  DataTypeAddOptions(this.name, this.fields);

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "fields": fields != null
          ? List<Map<String, dynamic>>.from(fields.map((e) => e.toMap()))
          : null,
    }..removeWhere((k, v) => v == null);
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(Object other) {
    if (!isTypeEqual(this, other)) return false;
    DataTypeAddOptions compare = other;
    List<dynamic> currentArgs = [name, fields];
    List<dynamic> otherArgs = [compare.name, compare.fields];
    return isEquals(this, other, currentArgs, otherArgs);
  }

  @override
  int get hashCode => hashValues(name, hashList(fields));
}
