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

import 'dart:convert' show json;
import 'package:huawei_awareness/constants/param.dart';

class TimeCategoriesResponse {
  List<int> timeCategories;

  TimeCategoriesResponse({
    this.timeCategories,
  });

  factory TimeCategoriesResponse.fromJson(String str) =>
      TimeCategoriesResponse.fromMap(json.decode(str));

  factory TimeCategoriesResponse.fromMap(Map<dynamic, dynamic> jsonMap) =>
      TimeCategoriesResponse(
        timeCategories: jsonMap[Param.timeCategories] == null
            ? null
            : List<int>.from(jsonMap[Param.timeCategories].map((x) => x)),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      Param.timeCategories: timeCategories == null
          ? null
          : List<dynamic>.from(timeCategories.map((x) => x)),
    };
  }
}
