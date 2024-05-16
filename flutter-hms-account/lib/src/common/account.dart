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

part of huawei_account;

/// Account object obtained from `android.accounts.Account`.
class Account {
  String? name;
  String? type;

  Account({
    this.name,
    this.type,
  });

  factory Account.fromMap(Map<dynamic, dynamic> map) {
    return Account(
      name: map['name'],
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
    };
  }

  @override
  String toString() {
    return '$Account(name: $name, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Account && name == other.name && type == other.type;
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <dynamic>[
        name,
        type,
      ],
    );
  }
}
