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

import 'drive_comment.dart';

class DriveCommentList {
  String category;
  List<DriveComment> comments;
  String nextCursor;

  DriveCommentList({
    this.category,
    this.comments,
    this.nextCursor,
  });

  DriveCommentList clone({
    String category,
    List<DriveComment> comments,
    String nextCursor,
  }) {
    return DriveCommentList(
      category: category ?? this.category,
      comments: comments ?? this.comments,
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'comments': comments?.map((x) => x?.toMap())?.toList(),
      'nextCursor': nextCursor,
    };
  }

  factory DriveCommentList.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DriveCommentList(
      category: map['category'],
      comments: map['comments'] != null
          ? List<DriveComment>.from(
              map['comments']?.map((x) => DriveComment.fromMap(x)))
          : null,
      nextCursor: map['nextCursor'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DriveCommentList.fromJson(String source) =>
      DriveCommentList.fromMap(json.decode(source));

  @override
  String toString() =>
      'CommentList(category: $category, comments: $comments, nextCursor: $nextCursor)';
}
