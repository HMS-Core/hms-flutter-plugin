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
import 'dart:convert';

class CommonField {
  final String key;
  final String value;
  final String label;
  CommonField({
    this.key,
    this.value,
    this.label,
  });

  CommonField copyWith({
    String key,
    String value,
    String label,
  }) {
    return CommonField(
      key: key ?? this.key,
      value: value ?? this.value,
      label: label ?? this.label,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'value': value,
      'label': label,
    };
  }

  factory CommonField.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CommonField(
      key: map['key'],
      value: map['value'],
      label: map['label'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CommonField.fromJson(String source) =>
      CommonField.fromMap(json.decode(source));

  @override
  String toString() => 'CommonField(key: $key, value: $value, label: $label)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CommonField &&
        o.key == key &&
        o.value == value &&
        o.label == label;
  }

  @override
  int get hashCode => key.hashCode ^ value.hashCode ^ label.hashCode;
}
