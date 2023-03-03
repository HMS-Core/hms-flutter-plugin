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

import 'package:huawei_drive/huawei_drive.dart';

/// File reply class.
class DriveReply with ExtraParameter {
  /// Operation of replying to a parent comment.
  String? operate;

  /// User who creates a reply.
  DriveUser? creator;

  /// Reply in plain text format.
  String? description;

  /// Reply creation time.
  DateTime? createdTime;

  /// Whether a reply is deleted.
  bool? deleted;

  /// Reply in HTML format.
  String? htmlDescription;

  /// Reply ID.
  String? id;

  /// Resource type.
  String? resourceType;

  /// Last modification time of a reply.
  DateTime? editedTime;

  DriveReply({
    this.operate,
    this.creator,
    this.description,
    this.createdTime,
    this.deleted,
    this.htmlDescription,
    this.id,
    this.resourceType,
    this.editedTime,
  });

  factory DriveReply.fromMap(Map<String, dynamic> map) {
    return DriveReply(
      operate: map['operate'],
      creator:
          map['creator'] == null ? null : DriveUser.fromMap(map['creator']),
      description: map['description'],
      createdTime: map['createdTime'] != null
          ? DateTime.parse(map['createdTime'])
          : null,
      deleted: map['deleted'],
      htmlDescription: map['htmlDescription'],
      id: map['id'],
      resourceType: map['resourceType'],
      editedTime:
          map['editedTime'] != null ? DateTime.parse(map['editedTime']) : null,
    );
  }

  factory DriveReply.fromJson(String source) =>
      DriveReply.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'operate': operate,
      'creator': creator?.toMap(),
      'description': description,
      'createdTime': createdTime?.toIso8601String(),
      'deleted': deleted,
      'htmlDescription': htmlDescription,
      'id': id,
      'resourceType': resourceType,
      'editedTime': editedTime?.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());
  @override
  String toString() {
    return 'Reply(operate: $operate, creator: $creator, description: $description, createdTime: $createdTime, deleted: $deleted, htmlDescription: $htmlDescription, replyID: $id, resourceType: $resourceType, editedTime: $editedTime)';
  }
}
