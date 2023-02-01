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

part of huawei_wallet;

class CommonField {
  /// CommonField key.
  final String key;

  /// CommonField value.
  final String value;

  /// CommonField label.
  final String label;

  const CommonField({
    required this.key,
    required this.value,
    required this.label,
  });

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'key': key,
      'value': value,
      'label': label,
    };
  }

  @override
  String toString() {
    return '$CommonField('
        'key: $key, '
        'value: $value, '
        'label: $label)';
  }
}
