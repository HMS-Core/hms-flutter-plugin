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

import 'dart:convert';

import 'package:huawei_drive/src/model/history_version.dart';

/// History version list class, which used for reading the list of historical file
/// versions by pagination.
class HistoryVersionList {
  /// Resource type.
  ///
  /// The value is always `drive#historyVersionList`.
  String? category;

  ///	Next page cursor for query.
  ///
  /// If nextCursor is empty, there is no next page.
  String? nextCursor;

  /// List of historical file versions.
  List<HistoryVersion>? historyVersions;

  HistoryVersionList({
    this.category,
    this.nextCursor,
    this.historyVersions,
  });

  factory HistoryVersionList.fromMap(Map<String, dynamic> map) {
    HistoryVersionList instance = HistoryVersionList(
      category: map['category'],
      nextCursor: map['nextCursor'],
    );
    if (map['historyVersions'] != null) {
      if (List<dynamic>.from(map['historyVersions']).isNotEmpty) {
        instance.historyVersions = List<HistoryVersion>.from(
          map['historyVersions']?.map(
            (dynamic x) => HistoryVersion.fromMap(x),
          ),
        );
      }
    }
    return instance;
  }

  factory HistoryVersionList.fromJson(String source) =>
      HistoryVersionList.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'nextCursor': nextCursor,
      'historyVersions':
          historyVersions?.map((HistoryVersion x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'HistoryVersionList(category: $category, nextCursor: $nextCursor, historyVersions: $historyVersions)';
}
