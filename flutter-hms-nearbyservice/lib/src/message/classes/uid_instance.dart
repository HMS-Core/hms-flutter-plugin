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

class UidInstance {
  /// Hex namespace
  final String? uid;
  final String? instance;
  final bool _isIncludeInstance;

  UidInstance({
    required this.uid,
    this.instance,
  }) : _isIncludeInstance = instance != null ? true : false;

  bool equals(dynamic object) {
    return identical(this, object) ||
        object is UidInstance &&
            uid == object.uid &&
            instance == object.instance &&
            _isIncludeInstance == object._isIncludeInstance;
  }

  factory UidInstance.fromMap(Map<dynamic, dynamic> map) {
    return UidInstance(
      uid: map['uid'],
      instance: map['instance'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'instance': instance,
      'isIncludeInstance': _isIncludeInstance,
    };
  }

  @override
  String toString() {
    return 'uid=$uid, instance=$instance';
  }
}
