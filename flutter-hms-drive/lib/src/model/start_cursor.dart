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

/// StartCursor object class, that is, cursor for the start page of file changes.
class StartCursor {
  /// Resource type.
  ///
  /// The value is always `drive#startCursor`.
  String category;

  /// Cursor for the start page of file changes.
  String cursor;

  /// Default constructor.
  StartCursor({
    this.category,
    this.cursor,
  });

  /// Clones a StartCursor object.
  StartCursor clone({
    String category,
    String startCursor,
  }) {
    return StartCursor(
      category: category ?? this.category,
      cursor: startCursor ?? this.cursor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'startCursor': cursor,
    };
  }

  factory StartCursor.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StartCursor(
      category: map['category'],
      cursor: map['startCursor'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StartCursor.fromJson(String source) =>
      StartCursor.fromMap(json.decode(source));

  @override
  String toString() => 'StartCursor(category: $category, startCursor: $cursor)';
}
