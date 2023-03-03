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

import 'package:huawei_drive/src/model/extra_parameter.dart';
import 'package:huawei_drive/src/model/quoted_content.dart';
import 'package:huawei_drive/src/model/drive_user.dart';

import 'package:huawei_drive/src/model/drive_reply.dart';

/// File comment model class.
class DriveComment with ExtraParameter {
  /// File position in JSON format.
  String? position;

  /// Information about the user who creates a comment.
  DriveUser? creator;

  /// Comment content.
  String? description;

  ///	Time when the comment is created.
  DateTime? createdTime;

  /// Whether a comment is deleted.
  bool? deleted;

  /// Comment in HTML format.
  String? htmlDescription;

  /// All replies to a comment.
  List<DriveReply>? replies;

  /// Comment ID.
  String? id;

  /// Resource type.
  String? category;

  /// Last modification time of a comment.
  DateTime? editedTime;

  /// Content of a commented file.
  QuotedContent? quotedComment;

  /// Whether a comment is resolved by one of its replies.
  bool? resolved;

  DriveComment({
    this.position,
    this.creator,
    this.description,
    this.createdTime,
    this.deleted,
    this.htmlDescription,
    this.replies,
    this.id,
    this.category,
    this.editedTime,
    this.quotedComment,
    this.resolved,
  });

  factory DriveComment.fromMap(Map<String, dynamic> map) {
    return DriveComment(
      position: map['position'],
      creator:
          map['creator'] == null ? null : DriveUser.fromMap(map['creator']),
      description: map['description'],
      createdTime: map['createdTime'] != null
          ? DateTime.parse(map['createdTime'])
          : null,
      deleted: map['deleted'],
      htmlDescription: map['htmlDescription'],
      replies: map['replies'] != null
          ? List<DriveReply>.from(
              map['replies']?.map(
                (Map<String, dynamic> x) => DriveReply.fromMap(x),
              ),
            )
          : null,
      id: map['id'],
      category: map['category'],
      editedTime:
          map['editedTime'] != null ? DateTime.parse(map['editedTime']) : null,
      quotedComment: map['quotedComment'] == null
          ? null
          : QuotedContent.fromMap(map['quotedComment']),
      resolved: map['resolved'],
    );
  }

  factory DriveComment.fromJson(String source) =>
      DriveComment.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'position': position,
      'creator': creator?.toMap(),
      'description': description,
      'createdTime': createdTime?.toIso8601String(),
      'deleted': deleted,
      'htmlDescription': htmlDescription,
      'replies': replies?.map((DriveReply x) => x.toMap()).toList(),
      'id': id,
      'category': category,
      'editedTime': editedTime?.toIso8601String(),
      'quotedComment': quotedComment?.toMap(),
      'resolved': resolved,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Comment(position: $position, creator: $creator, description: $description, createdTime: $createdTime, deleted: $deleted, htmlDescription: $htmlDescription, replies: $replies, id: $id, category: $category, editedTime: $editedTime, quotedComment: $quotedComment, resolved: $resolved)';
  }
}
