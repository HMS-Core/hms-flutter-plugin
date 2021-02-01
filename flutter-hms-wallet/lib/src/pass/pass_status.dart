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

class PassStatus {
  final String state;
  final String effectTime;
  final String expireTime;
  PassStatus({
    this.state,
    this.effectTime,
    this.expireTime,
  });

  PassStatus copyWith({
    String state,
    String effectTime,
    String expireTime,
  }) {
    return PassStatus(
      state: state ?? this.state,
      effectTime: effectTime ?? this.effectTime,
      expireTime: expireTime ?? this.expireTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'state': state,
      'effectTime': effectTime,
      'expireTime': expireTime,
    };
  }

  factory PassStatus.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PassStatus(
      state: map['state'],
      effectTime: map['effectTime'],
      expireTime: map['expireTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PassStatus.fromJson(String source) =>
      PassStatus.fromMap(json.decode(source));

  @override
  String toString() =>
      'PassStatus(state: $state, effectTime: $effectTime, expireTime: $expireTime)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PassStatus &&
        o.state == state &&
        o.effectTime == effectTime &&
        o.expireTime == expireTime;
  }

  @override
  int get hashCode =>
      state.hashCode ^ effectTime.hashCode ^ expireTime.hashCode;
}
