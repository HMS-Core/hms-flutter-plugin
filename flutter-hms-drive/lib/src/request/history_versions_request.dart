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

class HistoryVersionsRequest extends Batchable implements DriveRequest {
  String? historyVersionId;
  String? fileId;
  String? cursor;
  int? pageSize;
  bool? acknowledgeDownloadRisk;
  HistoryVersion? historyVersion;

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

  HistoryVersionsRequest._({
    this.historyVersionId,
    this.fileId,
    this.cursor,
    this.pageSize,
    this.acknowledgeDownloadRisk,
    this.fields,
    this.form,
    this.parameters,
    this.prettyPrint,
    this.quotaId,
  }) : super('HistoryVersions#Unknown');

  HistoryVersionsRequest.getRequest(
    this.fileId,
    this.historyVersionId, {
    this.acknowledgeDownloadRisk,
    this.fields,
    this.form,
    this.parameters,
    this.prettyPrint,
    this.quotaId,
  }) : super('HistoryVersions#Get');

  HistoryVersionsRequest.delete(
    this.fileId,
    this.historyVersionId, {
    this.fields,
    this.form,
    this.parameters,
    this.prettyPrint,
    this.quotaId,
  }) : super('HistoryVersions#Delete');

  HistoryVersionsRequest.update(
    this.fileId,
    this.historyVersionId,
    this.historyVersion, {
    this.fields,
    this.form,
    this.parameters,
    this.prettyPrint,
    this.quotaId,
  }) : super('HistoryVersions#Update');

  HistoryVersionsRequest.list(
    this.fileId, {
    this.pageSize,
    this.cursor,
    this.fields,
    this.form,
    this.parameters,
    this.prettyPrint,
    this.quotaId,
  }) : super('HistoryVersions#List');

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestName': requestName,
      'historyVersionId': historyVersionId,
      'fileId': fileId,
      'cursor': cursor,
      'pageSize': pageSize,
      'acknowledgeDownloadRisk': acknowledgeDownloadRisk,
      'fields': fields,
      'form': form,
      'parameters': parameters,
      'prettyPrint': prettyPrint,
      'quotaId': quotaId,
      'historyVersion': historyVersion?.toMap()
    }..removeWhere((String k, dynamic v) => v == null);
  }

  factory HistoryVersionsRequest.fromMap(Map<String, dynamic> map) {
    return HistoryVersionsRequest._(
      historyVersionId: map['historyVersionId'],
      fileId: map['fileId'],
      cursor: map['cursor'],
      pageSize: map['pageSize'],
      acknowledgeDownloadRisk: map['acknowledgeDownloadRisk'],
      fields: map['fields'],
      form: map['form'],
      parameters: map['parameters'] == null
          ? null
          : Map<String, dynamic>.from(map['parameters']),
      prettyPrint: map['prettyPrint'],
      quotaId: map['quotaId'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory HistoryVersionsRequest.fromJson(String source) =>
      HistoryVersionsRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HistoryVersionsRequest(historyVersionId: $historyVersionId, fileId: $fileId, cursor: $cursor, pageSize: $pageSize, acknowledgeDownloadRisk: $acknowledgeDownloadRisk, fields: $fields, form: $form, parameters: $parameters, prettyPrint: $prettyPrint, quotaId: $quotaId)';
  }
}
