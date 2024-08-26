/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_ml_body.dart';

class MlBodyActions {
  Map<int, String> actionArray;
  int num;
  bool isRandom;

  MlBodyActions({
    required this.actionArray,
    required this.num,
    required this.isRandom,
  });

  factory MlBodyActions.fromJson(String str) {
    return MlBodyActions.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory MlBodyActions.fromMap(Map<String, dynamic> json) {
    return MlBodyActions(
      actionArray: Map<int, String>.from(json['actionArray']),
      num: json['num'],
      isRandom: json['isRandom'],
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <dynamic, dynamic>{
      'actionArray': actionArray,
      'num': num,
      'isRandom': isRandom,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is MlBodyActions &&
        other.actionArray == actionArray &&
        other.num == num &&
        other.isRandom == isRandom;
  }
}
