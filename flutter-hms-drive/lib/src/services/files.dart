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
import 'package:huawei_drive/huawei_drive.dart';
import 'package:huawei_drive/src/constants/channel.dart';

/// Defines the Files API.
///
/// HUAWEI Drive Kit allows your app to provide file managing functions for users,
/// including viewing, updating, and uploading.
class Files {
  static const MethodChannel _channel = driveMethodChannel;
  static const EventChannel _progressChannel = progressEventChannel;

  /// Creates a copy of a file.
  Future<DriveFile> copy(FilesRequest request) async {
    return DriveFile.fromJson(
      await _channel.invokeMethod('Files#Copy', <dynamic, dynamic>{
        'request': request.toJson(),
        'file': request.file?.toJson(),
        'extraParams': request.file?.paramsToSet,
      }),
    );
  }

  /// Creates a folder or file.
  Future<DriveFile> create(FilesRequest request) async {
    return DriveFile.fromJson(
      await _channel.invokeMethod('Files#Create', <dynamic, dynamic>{
        'request': request.toJson(),
        'file': request.file?.toJson(),
        'extraParams': request.file?.paramsToSet,
        'fileContent': request.fileContent?.toMap(),
      }),
    );
  }

  /// Permanently deletes a file or folder.
  Future<bool> delete(FilesRequest request) async {
    return await _channel.invokeMethod('Files#Delete', request.toJson());
  }

  /// Clears the recycle bin.
  Future<bool> emptyRecycle(FilesRequest request) async {
    return await _channel.invokeMethod('Files#EmptyRecycle', request.toJson());
  }

  /// Obtains file metadata.
  Future<DriveFile> getFile(FilesRequest request) async {
    return DriveFile.fromJson(
      await _channel.invokeMethod('Files#Get', request.toJson()),
    );
  }

  /// Obtains file metadata.
  Future<DriveFileList> list(FilesRequest request) async {
    return DriveFileList.fromJson(
      await _channel.invokeMethod(
        'Files#List',
        request.toJson(),
      ),
    );
  }

  /// Updates file content or metadata.
  Future<DriveFile> update(FilesRequest request) async {
    return DriveFile.fromJson(
      await _channel.invokeMethod('Files#Update', <dynamic, dynamic>{
        'request': request.toJson(),
        'file': request.file?.toJson(),
        'extraParams': request.file?.paramsToSet,
        'fileContent': request.fileContent?.toMap(),
      }),
    );
  }

  /// Subscribes to changes of files and folders.
  Future<DriveChannel> subscribe(FilesRequest request) async {
    return DriveChannel.fromJson(
      await _channel.invokeMethod('Files#Subscribe', <dynamic, dynamic>{
        'request': request.toJson(),
        'channel': request.channel?.toJson(),
        'extraParams': request.channel?.paramsToSet,
      }),
    );
  }

  /// Sends a media request to the server and returns media content.
  Future<ExecuteResponse> getContent(FilesRequest request) async {
    return ExecuteResponse.fromJson(
      await _channel.invokeMethod(
        'Files#ExecuteContent',
        request.toJson(),
      ),
    );
  }

  /// Sends a media request to the server and returns a media content input as
  /// input stream.
  Future<Int8List> getContentAsInputStream(FilesRequest request) async {
    return Int8List.fromList(
      await _channel.invokeMethod(
        'Files#ExecuteContentAsInputStream',
        request.toJson(),
      ),
    );
  }

  /// Sends a media request to the server and writes the input stream of
  /// returned media content into the specified destination.
  Future<bool> getContentAndDownloadTo(
    FilesRequest request,
    String path,
  ) async {
    return await _channel
        .invokeMethod('Files#ExecuteContentAndDownloadTo', <dynamic, dynamic>{
      'request': request.toJson(),
      'path': path,
    });
  }

  ///Stream that emits the progress of download and upload processes.
  ///The errors of this stream can be listened from the onError callback.
  Stream<DriveProgress> get onProgressChanged =>
      _progressChannel.receiveBroadcastStream().map(
            (dynamic event) => DriveProgress.fromMap(
              Map<String, dynamic>.from(event),
            ),
          );
}
