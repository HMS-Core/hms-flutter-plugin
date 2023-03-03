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

import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:huawei_drive/src/constants/channel.dart';
import 'package:huawei_drive/src/model/export.dart';
import 'package:huawei_drive/src/request/history_versions_request.dart';

/// Defines the HistoryVersions API.
///
/// HistoryVersions API Provides the functions of querying, viewing, updating, and deleting
/// historical versions of files for users.
class HistoryVersions {
  static const MethodChannel _channel = driveMethodChannel;

  /// Deletes a historical version of a file.
  Future<bool> delete(HistoryVersionsRequest request) async {
    return await _channel.invokeMethod(
      'HistoryVersions#Delete',
      request.toJson(),
    );
  }

  /// Obtains the metadata or content of a historical file version by file ID and
  /// ID of a historical file version.
  Future<HistoryVersion> getHistoryVersion(
    HistoryVersionsRequest request,
  ) async {
    final String result =
        await _channel.invokeMethod('HistoryVersions#Get', request.toJson());
    return HistoryVersion.fromJson(result);
  }

  /// Sends a media request to the server and returns media content.
  Future<ExecuteResponse> getContent(HistoryVersionsRequest request) async {
    return ExecuteResponse.fromJson(
      await _channel.invokeMethod(
        'HistoryVersions#ExecuteContent',
        request.toJson(),
      ),
    );
  }

  /// Sends a media request to the server and returns a media content input stream.
  Future<Int8List> getContentAsInputStream(
    HistoryVersionsRequest request,
  ) async {
    return Int8List.fromList(
      await _channel.invokeMethod(
        'HistoryVersions#ExecuteContentAsInputStream',
        request.toJson(),
      ),
    );
  }

  /// Sends a media request to the server and writes the input stream of returned
  /// media content into the specified destination output path.
  Future<bool> getContentAndDownloadTo(
    HistoryVersionsRequest request,
    String path,
  ) async {
    return await _channel.invokeMethod(
        'HistoryVersions#ExecuteContentAndDownloadTo', <dynamic, dynamic>{
      'requestOptions': request.toJson(),
      'path': path,
    });
  }

  /// Lists the historical versions of a file.
  Future<HistoryVersionList> list(HistoryVersionsRequest request) async {
    final String result =
        await _channel.invokeMethod('HistoryVersions#List', request.toJson());
    return HistoryVersionList.fromJson(result);
  }

  /// Updates a historical version of a file.
  Future<HistoryVersion> update(HistoryVersionsRequest request) async {
    final String result = await _channel
        .invokeMethod('HistoryVersions#Update', <dynamic, dynamic>{
      'requestOptions': request.toJson(),
      'historyVersion': request.historyVersion?.toJson(),
      'extraParams': request.historyVersion?.paramsToSet,
    });
    return HistoryVersion.fromJson(result);
  }
}
