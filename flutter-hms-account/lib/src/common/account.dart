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

import 'package:flutter/material.dart';

/// Account object obtained from android.accounts.Account
class Account {
  String type;
  String name;

  Account({this.name, this.type});

  factory Account.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;
    return Account(type: map['type'] ?? null, name: map['name'] ?? null);
  }

  Map<String, dynamic> toMap() => {'type': type, 'name': name};

  String toString() => 'Account(name: $name, type: $type)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Account && o.name == name && o.type == type;
  }

  @override
  int get hashCode {
    return hashList([name, type]);
  }
}
