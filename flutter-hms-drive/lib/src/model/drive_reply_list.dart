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

import 'drive_reply.dart';

class DriveReplyList {
  String category;
  List<DriveReply> replies;
  String nextCursor;

  DriveReplyList({
    this.category,
    this.replies,
    this.nextCursor,
  });

  DriveReplyList clone({
    String category,
    List<DriveReply> replies,
    String nextCursor,
  }) {
    return DriveReplyList(
      category: category ?? this.category,
      replies: replies ?? this.replies,
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'replies': replies?.map((x) => x?.toMap())?.toList(),
      'nextCursor': nextCursor,
    };
  }

  factory DriveReplyList.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DriveReplyList(
      category: map['category'],
      replies: map['replies'] == null
          ? null
          : List<DriveReply>.from(
              map['replies']?.map((x) => DriveReply.fromMap(x))),
      nextCursor: map['nextCursor'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DriveReplyList.fromJson(String source) =>
      DriveReplyList.fromMap(json.decode(source));

  @override
  String toString() =>
      'ReplyList(category: $category, replies: $replies, nextCursor: $nextCursor)';
}
