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

/// Contains the request methods about Comments.
class CommentsRequest extends Batchable implements DriveRequest {
  /// File ID.
  String? fileId;

  /// Response data format.
  ///
  /// The default data format is json, and only this format is supported currently.
  @override
  String? form;

  /// Fields to be contained in a response.
  ///
  /// By default an asterisk (`*`) is used to match all related fields.
  @override
  String? fields;

  /// Indicates whether to return a response containing indentations and newline characters.
  @override
  bool? prettyPrint;

  ///A string of less than 40 characters to identify a user.
  ///
  ///The string is used by the server to restrict the user's API calls.
  @override
  String? quotaId;

  /// Parameters for the request.
  @override
  Map<String, dynamic>? parameters;

  /// Page Size for list request.
  int? pageSize;

  /// Cursor for the current page, which is obtained from nextCursor in the previous response.
  ///
  /// The server returns a maximum of 100 comments for each query request.
  /// If there are more than 100 comments, the cursor needs to be set to nextCursor
  /// for a new file notification.
  ///
  /// This process repeats until nextCursor in the response is empty, which indicates that
  /// all comments have been returned.
  String? cursor;

  /// Comment ID.
  String? commentId;

  /// Comment instance to specify on the create request.
  DriveComment? comment;

  /// Whether to return deleted comments on a get request.
  bool? includeDeleted;

  /// Earliest modification time of a comment.
  DateTime? startEditedTime;

  CommentsRequest._({
    this.fileId,
    this.form,
    this.fields,
    this.prettyPrint,
    this.quotaId,
    this.parameters,
    this.pageSize,
    this.cursor,
    this.commentId,
    this.comment,
    this.includeDeleted,
    this.startEditedTime,
  }) : super('Comments#Unknown');

  /// Constructor for a create request.
  CommentsRequest.create(
    this.fileId,
    this.comment, {
    this.form,
    this.fields,
    this.prettyPrint,
    this.quotaId,
    this.parameters,
  }) : super('Comments#Create');

  /// Constructor for a delete request.
  CommentsRequest.delete(
    this.fileId,
    this.commentId, {
    this.form,
    this.fields,
    this.prettyPrint,
    this.quotaId,
    this.parameters,
  }) : super('Comments#Delete');

  /// Constructor for a get request.
  CommentsRequest.getRequest(
    this.fileId,
    this.commentId, {
    this.includeDeleted,
    this.form,
    this.fields,
    this.prettyPrint,
    this.quotaId,
    this.parameters,
  }) : super('Comments#Get');

  /// Constructor for a list request.
  CommentsRequest.list(
    this.fileId, {
    this.pageSize,
    this.includeDeleted,
    this.cursor,
    this.startEditedTime,
    this.form,
    this.fields,
    this.prettyPrint,
    this.quotaId,
    this.parameters,
  }) : super('Comments#List');

  /// Constructor for a update request.
  CommentsRequest.update(
    this.fileId,
    this.commentId,
    this.comment, {
    this.form,
    this.fields,
    this.prettyPrint,
    this.quotaId,
  }) : super('Comments#Update');

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestName': requestName,
      'fileId': fileId,
      'form': form,
      'fields': fields,
      'prettyPrint': prettyPrint,
      'quotaId': quotaId,
      'parameters': parameters,
      'pageSize': pageSize,
      'cursor': cursor,
      'commentId': commentId,
      'comment': comment?.toMap(),
      'includeDeleted': includeDeleted,
      'startEditedTime': startEditedTime?.toIso8601String()
    }..removeWhere((String k, dynamic v) => v == null);
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CommentsRequest(fileId: $fileId, form: $form, fields: $fields, prettyPrint: $prettyPrint, quotaId: $quotaId, pageSize: $pageSize, cursor: $cursor, commentId: $commentId, comment: $comment, includeDeleted: $includeDeleted, startEditedTime: $startEditedTime)';
  }

  factory CommentsRequest.fromMap(Map<String, dynamic> map) {
    return CommentsRequest._(
      fileId: map['fileId'],
      form: map['form'],
      fields: map['fields'],
      prettyPrint: map['prettyPrint'],
      quotaId: map['quotaId'],
      parameters: map['parameters'],
      pageSize: map['pageSize'],
      cursor: map['cursor'],
      commentId: map['commentId'],
      comment:
          map['comment'] == null ? null : DriveComment.fromMap(map['comment']),
      includeDeleted: map['includeDeleted'],
      startEditedTime: map['startEditedTime'] != null
          ? DateTime.parse(map['startEditedTime'])
          : null,
    );
  }

  factory CommentsRequest.fromJson(String source) =>
      CommentsRequest.fromMap(json.decode(source));
}
