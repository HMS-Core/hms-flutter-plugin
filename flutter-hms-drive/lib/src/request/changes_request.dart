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

class ChangesRequest extends Batchable implements DriveRequest {
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

  String? cursor;
  String? containers;
  int? pageSize;
  bool? includeDeleted;
  DriveChannel? channel;

  ChangesRequest.getStartCursor({
    this.fields,
    this.form,
    this.parameters,
    this.prettyPrint,
    this.quotaId,
  }) : super('Changes#GetStartCursor');

  ChangesRequest.list(
    this.cursor, {
    this.fields,
    this.form,
    this.parameters,
    this.prettyPrint,
    this.quotaId,
    this.containers,
    this.pageSize,
    this.includeDeleted,
  }) : super('Changes#List');

  ChangesRequest.subscribe(
    this.cursor,
    this.channel, {
    this.fields,
    this.form,
    this.parameters,
    this.prettyPrint,
    this.quotaId,
    this.containers,
    this.pageSize,
    this.includeDeleted,
  }) : super('Changes#Subscribe');

  ChangesRequest._({
    this.cursor,
    this.pageSize,
    this.includeDeleted,
    this.containers,
    this.fields,
    this.form,
    this.parameters,
    this.prettyPrint,
    this.quotaId,
  }) : super('Changes#Unknown');

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestName': requestName,
      'fields': fields,
      'form': form,
      'parameters': parameters,
      'prettyPrint': prettyPrint,
      'quotaId': quotaId,
      'cursor': cursor,
      'containers': containers,
      'pageSize': pageSize,
      'includeDeleted': includeDeleted,
      'channel': channel?.toMap()
    }..removeWhere((String k, dynamic v) => v == null);
  }

  factory ChangesRequest.fromMap(Map<String, dynamic> map) {
    return ChangesRequest._(
      fields: map['fields'],
      form: map['form'],
      parameters: map['parameters'] == null
          ? null
          : Map<String, dynamic>.from(map['parameters']),
      prettyPrint: map['prettyPrint'],
      quotaId: map['quotaId'],
      cursor: map['cursor'],
      containers: map['containers'],
      pageSize: map['pageSize'],
      includeDeleted: map['includeDeleted'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ChangesRequest.fromJson(String source) =>
      ChangesRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChangesRequest(fields: $fields, form: $form, parameters: $parameters, prettyPrint: $prettyPrint, quotaId: $quotaId, cursor: $cursor, containers: $containers, pageSize: $pageSize, includeDeleted: $includeDeleted)';
  }
}
