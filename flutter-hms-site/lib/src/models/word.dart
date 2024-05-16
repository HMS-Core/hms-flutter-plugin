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

part of huawei_site;

class Word {
  int offset;
  String value;

  Word({
    int? offset,
    String? value,
  })  : offset = offset ?? 0,
        value = value ?? '';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'offset': offset,
      'value': value,
    };
  }

  factory Word.fromMap(Map<dynamic, dynamic> map) {
    return Word(
      offset: map['offset'] ?? 0,
      value: map['value'] ?? '',
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory Word.fromJson(String source) {
    return Word.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '$Word('
        'offset: $offset, '
        'value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Word && other.offset == offset && other.value == value;
  }

  @override
  int get hashCode {
    return offset.hashCode ^ value.hashCode;
  }
}
