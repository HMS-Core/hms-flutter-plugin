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

import 'dart:convert';

/// Information about a user's storage quota limits and usage, in bytes.
class StorageQuota {
  /// Storage usage of a user.
  final int? usedSpace;

  /// Storage usage of a user.
  final int? userCapacity;

  StorageQuota({
    this.usedSpace,
    this.userCapacity,
  });

  factory StorageQuota.fromMap(Map<String, dynamic> map) {
    return StorageQuota(
      usedSpace: map['usedSpace'] != null ? int.parse(map['usedSpace']) : null,
      userCapacity:
          map['userCapacity'] != null ? int.parse(map['userCapacity']) : null,
    );
  }
  factory StorageQuota.fromJson(String source) =>
      StorageQuota.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'usedSpace': usedSpace,
      'userCapacity': userCapacity,
    };
  }

  String toJson() => jsonEncode(toMap());

  @override
  String toString() =>
      'StorageQuota(usedSpace: $usedSpace, userCapacity: $userCapacity)';
}
