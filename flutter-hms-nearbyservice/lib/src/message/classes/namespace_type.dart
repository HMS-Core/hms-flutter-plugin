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

part of huawei_nearbyservice;

class NamespaceType {
  final String? namespace;
  final String? type;

  NamespaceType(
    this.namespace,
    this.type,
  );

  bool equals(dynamic object) {
    return identical(this, object) ||
        object is NamespaceType &&
            namespace == object.namespace &&
            type == object.type;
  }

  factory NamespaceType.fromMap(Map<dynamic, dynamic> map) {
    return NamespaceType(
      map['namespace'],
      map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'namespace': namespace,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'namespace=$namespace, type=$type';
  }
}
