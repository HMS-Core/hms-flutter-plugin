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

import 'package:huawei_drive/src/model/change.dart';

/// Change list class, which is used to parse and serialize change list data
/// transferred over the network.
class ChangeList {
  /// The resource type.
  ///
  /// The value is always `drive#changeList`.
  String? category;

  /// List of changes.
  ///
  /// If nextCursor is contained, the returned list is incomplete and another request
  /// needs to be sent to obtain other results.
  List<Change>? changes;

  ///	Cursor for the next page of changes, which is contained only when there are
  /// still changes to be returned.
  ///
  /// If the cursor is rejected for any reason, paging should be restarted from
  /// the first page of results.
  String? nextCursor;

  /// Cursor for the start page of new changes.
  String? newStartCursor;

  ChangeList._({
    this.category,
    this.changes,
    this.nextCursor,
    this.newStartCursor,
  });

  factory ChangeList.fromMap(Map<dynamic, dynamic> map) {
    return ChangeList._(
      category: map['category'],
      changes: map['changes'] == null
          ? null
          : List<Change>.from(
              map['changes']?.map((dynamic x) => Change.fromMap(x)),
            ),
      nextCursor: map['nextCursor'],
      newStartCursor: map['newStartCursor'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'changes': changes?.map((Change x) => x.toMap()).toList(),
      'nextCursor': nextCursor,
      'newStartCursor': newStartCursor,
    };
  }

  @override
  String toString() {
    return '$ChangeList('
        'category: $category, '
        'changes: $changes, '
        'nextCursor: $nextCursor, '
        'newStartCursor: $newStartCursor)';
  }
}
