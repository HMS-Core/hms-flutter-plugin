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

import 'package:huawei_drive/src/model/drive_reply.dart';

class DriveReplyList {
  String? category;
  List<DriveReply> replies;
  String? nextCursor;

  DriveReplyList({
    this.category,
    this.replies = const <DriveReply>[],
    this.nextCursor,
  });

  factory DriveReplyList.fromMap(Map<String, dynamic> map) {
    return DriveReplyList(
      category: map['category'],
      replies: map['replies'] == null
          ? <DriveReply>[]
          : List<DriveReply>.from(
              map['replies']?.map(
                (dynamic x) => DriveReply.fromMap(x),
              ),
            ),
      nextCursor: map['nextCursor'],
    );
  }

  factory DriveReplyList.fromJson(String source) =>
      DriveReplyList.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'replies': replies.map((DriveReply x) => x.toMap()).toList(),
      'nextCursor': nextCursor,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return '$DriveReplyList('
        'category: $category, '
        'replies: $replies, '
        'nextCursor: $nextCursor)';
  }
}
