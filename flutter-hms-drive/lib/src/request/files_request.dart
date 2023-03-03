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

class FilesRequest extends Batchable implements DriveRequest {
  // Common
  String? fileId;
  DriveFile? file;
  DriveFileContent? fileContent;
  String? containers;

  // Get request
  bool? acknowledgeDownloadRisk;

  // List request
  String? orderBy;
  String? queryParam;
  int? pageSize;
  String? cursor;

  // Subscribe request
  DriveChannel? channel;

  // Update Request
  String? addParentFolder;
  String? removeParentFolder;

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

  FilesRequest._({
    this.fileId,
    this.file,
    this.fileContent,
    this.containers,
    this.acknowledgeDownloadRisk,
    this.orderBy,
    this.queryParam,
    this.pageSize,
    this.cursor,
    this.channel,
    this.addParentFolder,
    this.removeParentFolder,
    this.fields,
    this.form,
    this.parameters,
    this.prettyPrint,
    this.quotaId,
  }) : super('Files#Unknown');

  FilesRequest.copy(
    this.fileId,
    this.file, {
    this.form,
    this.fields,
    this.prettyPrint,
    this.quotaId,
    this.parameters,
  }) : super('Files#Copy');

  FilesRequest.create(
    this.file, {
    this.fileContent,
    this.form,
    this.fields,
    this.prettyPrint,
    this.quotaId,
    this.parameters,
  }) : super('Files#Create');

  FilesRequest.delete(
    this.fileId, {
    this.form,
    this.fields,
    this.prettyPrint,
    this.quotaId,
    this.parameters,
  }) : super('Files#Delete');

  FilesRequest.emptyRecycle({
    this.containers,
    this.form,
    this.fields,
    this.prettyPrint,
    this.quotaId,
    this.parameters,
  }) : super('Files#EmptyRecycle');

  FilesRequest.getRequest(
    this.fileId, {
    this.acknowledgeDownloadRisk,
    this.form,
    this.fields,
    this.prettyPrint,
    this.quotaId,
    this.parameters,
  }) : super('Files#Get');

  FilesRequest.list({
    this.queryParam,
    this.orderBy,
    this.cursor,
    this.pageSize,
    this.containers,
    this.form,
    this.fields,
    this.prettyPrint,
    this.quotaId,
    this.parameters,
  }) : super('Files#List');

  FilesRequest.update(
    this.fileId,
    this.file, {
    this.fileContent,
    this.addParentFolder,
    this.removeParentFolder,
    this.form,
    this.fields,
    this.prettyPrint,
    this.quotaId,
    this.parameters,
  }) : super('Files#Update');

  FilesRequest.subscribe(
    this.fileId,
    this.channel, {
    this.form,
    this.fields,
    this.prettyPrint,
    this.quotaId,
    this.parameters,
  }) : super('Files#Subscribe');

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestName': requestName,
      'fileId': fileId,
      'file': file?.toMap(),
      'fileContent': fileContent?.toMap(),
      'containers': containers,
      'acknowledgeDownloadRisk': acknowledgeDownloadRisk,
      'orderBy': orderBy,
      'queryParam': queryParam,
      'pageSize': pageSize,
      'cursor': cursor,
      'channel': channel?.toMap(),
      'addParentFolder': addParentFolder,
      'removeParentFolder': removeParentFolder,
      'fields': fields,
      'form': form,
      'parameters': parameters,
      'prettyPrint': prettyPrint,
      'quotaId': quotaId,
    }..removeWhere((String k, dynamic v) => v == null);
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'FilesRequest(fileId: $fileId, file: $file, fileContent: $fileContent, containers: $containers, acknowledgeDownloadRisk: $acknowledgeDownloadRisk, orderBy: $orderBy, queryParam: $queryParam, pageSize: $pageSize, cursor: $cursor, channel: $channel, addParentFolder: $addParentFolder, removeParentFolder: $removeParentFolder, fields: $fields, form: $form, parameters: $parameters, prettyPrint: $prettyPrint, quotaId: $quotaId)';
  }

  factory FilesRequest.fromMap(Map<String, dynamic> map) {
    return FilesRequest._(
      fileId: map['fileId'],
      file: map['file'] == null ? null : DriveFile.fromMap(map['file']),
      fileContent: map['fileContent'] == null
          ? null
          : DriveFileContent.fromMap(map['fileContent']),
      containers: map['containers'],
      acknowledgeDownloadRisk: map['acknowledgeDownloadRisk'],
      orderBy: map['orderBy'],
      queryParam: map['queryParam'],
      pageSize: map['pageSize'],
      cursor: map['cursor'],
      channel:
          map['channel'] == null ? null : DriveChannel.fromMap(map['channel']),
      addParentFolder: map['addParentFolder'],
      removeParentFolder: map['removeParentFolder'],
      fields: map['fields'],
      form: map['form'],
      parameters: map['parameters'],
      prettyPrint: map['prettyPrint'],
      quotaId: map['quotaId'],
    );
  }

  factory FilesRequest.fromJson(String source) =>
      FilesRequest.fromMap(json.decode(source));
}
