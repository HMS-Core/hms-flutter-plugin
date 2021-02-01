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

class RelatedPassInfo {
  final String typeId;
  final String id;
  RelatedPassInfo({
    this.typeId,
    this.id,
  });

  RelatedPassInfo copyWith({
    String typeId,
    String id,
  }) {
    return RelatedPassInfo(
      typeId: typeId ?? this.typeId,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'typeId': typeId,
      'id': id,
    };
  }

  factory RelatedPassInfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RelatedPassInfo(
      typeId: map['typeId'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RelatedPassInfo.fromJson(String source) =>
      RelatedPassInfo.fromMap(json.decode(source));

  @override
  String toString() => 'RelatedPassInfo(typeId: $typeId, id: $id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RelatedPassInfo && o.typeId == typeId && o.id == id;
  }

  @override
  int get hashCode => typeId.hashCode ^ id.hashCode;
}
