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

import 'package:collection/collection.dart';

const DeepCollectionEquality _equality = DeepCollectionEquality();

/// Checks if two instance types are equal.
bool isTypeEqual<T>(T current, Object other) {
  if (current == null || other == null) return false;
  if (!(other is T)) return false;
  return true;
}

/// Checks if two objects are the same.
bool isEquals(dynamic current, dynamic other, List<dynamic> currentArgs,
    List<dynamic> otherArgs) {
  if (identical(current, other)) return true;
  if (currentArgs.length != otherArgs.length) return false;
  if (_equality.equals(currentArgs, otherArgs)) return true;
  return equalLists(currentArgs, otherArgs);
}

/// Checks if two lists are equal.
bool equalLists(List list1, List list2) {
  if (identical(list1, list2)) return true;
  if (list1 == null || list2 == null) return false;
  final length = list1.length;
  if (length != list2.length) return false;

  for (var i = 0; i < length; i++) {
    final dynamic unit1 = list1[i];
    final dynamic unit2 = list2[i];

    if (unit1 is Iterable || unit1 is Map) {
      if (!_equality.equals(unit1, unit2)) return false;
    } else if (unit1?.runtimeType != unit2?.runtimeType) {
      return false;
    } else if (unit1 != unit2) {
      return false;
    }
  }
  return true;
}
