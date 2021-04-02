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

import 'dart:convert';

class NavigationResult {
  int possibility;
  int state;

  NavigationResult({
    this.possibility,
    this.state,
  });

  Map<String, dynamic> toMap() {
    return {
      'state': state,
      'possibility': possibility,
    };
  }

  factory NavigationResult.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return NavigationResult(
      state: map["state"] == null ? null : map["state"],
      possibility: map["possibility"] == null ? null : map["possibility"],
    );
  }

  String toJson() => json.encode(toMap());

  factory NavigationResult.fromJson(String source) =>
      NavigationResult.fromMap(json.decode(source));

  @override
  String toString() {
    return 'State: $state, Possibility: $possibility';
  }
}
