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

class RepliesRequest extends Batchable implements DriveRequest {
  @override
  String? fields;

  @override
  String? form;

  @override
  Map<String, dynamic>? parameters;

  @override
  bool? prettyPrint;

  @override
  String? quotaId;

  bool? includeDeleted;

  int? pageSize;

  String? commentId;

  String? cursor;

  String? fileId;

  String? replyId;

  DriveReply? reply;

  RepliesRequest._({
    this.commentId,
    this.cursor,
    this.fields,
    this.fileId,
    this.form,
    this.includeDeleted,
    this.pageSize,
    this.parameters,
    this.prettyPrint,
    this.quotaId,
    this.replyId,
    this.reply,
  }) : super('Replies#Unknown');

  RepliesRequest.create(
    this.fileId,
    this.commentId,
    this.reply, {
    this.fields,
    this.form,
    this.parameters,
    this.prettyPrint,
    this.quotaId,
  }) : super('Replies#Create');

  RepliesRequest.delete(
    this.fileId,
    this.commentId,
    this.replyId, {
    this.parameters,
    this.fields,
    this.form,
    this.prettyPrint,
    this.quotaId,
  }) : super('Replies#Delete');

  RepliesRequest.getRequest(
    this.fileId,
    this.commentId,
    this.replyId, {
    this.includeDeleted,
    this.parameters,
    this.fields,
    this.form,
    this.prettyPrint,
    this.quotaId,
  }) : super('Replies#Get');

  RepliesRequest.list(
    this.fileId,
    this.commentId, {
    this.includeDeleted,
    this.parameters,
    this.cursor,
    this.fields,
    this.form,
    this.pageSize,
    this.prettyPrint,
    this.quotaId,
  }) : super('Replies#List');

  RepliesRequest.update(
    this.fileId,
    this.commentId,
    this.replyId,
    this.reply, {
    this.parameters,
    this.form,
    this.fields,
    this.prettyPrint,
    this.quotaId,
  }) : super('Replies#Update');

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestName': requestName,
      'commentId': commentId,
      'cursor': cursor,
      'fields': fields,
      'fileId': fileId,
      'form': form,
      'includeDeleted': includeDeleted,
      'pageSize': pageSize,
      'parameters': parameters,
      'prettyPrint': prettyPrint,
      'quotaId': quotaId,
      'replyId': replyId,
      'reply': reply?.toMap(),
    }..removeWhere((String k, dynamic v) => v == null);
  }

  factory RepliesRequest.fromMap(Map<String, dynamic> map) {
    return RepliesRequest._(
      commentId: map['commentId'],
      cursor: map['cursor'],
      fields: map['fields'],
      fileId: map['fileId'],
      form: map['form'],
      includeDeleted: map['includeDeleted'],
      pageSize: map['pageSize'],
      parameters: map['parameters'] == null
          ? null
          : Map<String, dynamic>.from(map['parameters']),
      prettyPrint: map['prettyPrint'],
      quotaId: map['quotaId'],
      replyId: map['replyId'],
      reply: map['reply'] == null ? null : DriveReply.fromMap(map['reply']),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory RepliesRequest.fromJson(String source) =>
      RepliesRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RepliesRequest(commentId: $commentId, cursor: $cursor, fields: $fields, fileId: $fileId, form: $form, includeDeleted: $includeDeleted, pageSize: $pageSize, parameters: $parameters, prettyPrint: $prettyPrint, quotaId: $quotaId, replyId: $replyId, reply: $reply)';
  }
}
