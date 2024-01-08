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

@Deprecated('This Class has been deprecated.')
/// Defines the request permissions.
///
/// Permissions are defined by [DataType], which determines the Health Kit scopes
/// authorized to the signed-in HUAWEI ID.
class HiHealthOption {
  /// Data type that the developer needs to access.
  DataType? dataType;

  /// [AccessType] options are `AccessType.read` and `Access.write`.
  AccessType? accessType;

  HiHealthOption(
    this.dataType,
    this.accessType,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dataType': dataType?.toMap(),
      'accessType': accessType?.index,
    }..removeWhere((String k, dynamic v) => v == null);
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(Object other) {
    return other is HiHealthOption &&
        other.dataType == dataType &&
        other.accessType == accessType;
  }

  /// Returns the hashCode of the [ActivityRecord] object.
  @override
  int get hashCode {
    return Object.hash(
      dataType,
      accessType,
    );
  }
}

enum AccessType {
  /// Read permission.
  read,

  /// Write permission.
  write,
}
