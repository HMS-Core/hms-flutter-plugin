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

import 'package:flutter/services.dart';
import 'package:huawei_drive/huawei_drive.dart';
import 'package:huawei_drive/src/constants/channel.dart';

/// The class for performing batch operations.
class Batch {
  static const MethodChannel _channel = driveMethodChannel;
  static const EventChannel _batchChannel = batchEventChannel;

  /// Executes the given batch request.
  ///
  /// The result for each batched request will be returned to the stream of [onBatchResult].
  Future<void> execute(BatchRequest batchRequest) async {
    return await _channel.invokeMethod(
      'Batch#Execute',
      batchRequest.toMap(),
    );
  }

  /// Obtains the stream that emits the batch request results.
  ///
  /// If a batch request is successful, the object type returned will be the same
  /// as the object type returned when that request was called normally.
  /// If the return type for a regular request is bool or void the returned result
  /// will be in json format as with errors.
  ///
  /// The errors of this stream can be listened from the onError callback.
  Stream<dynamic> get onBatchResult =>
      _batchChannel.receiveBroadcastStream().map(
            (dynamic event) => toDriveModel(event),
          );

  /// Converts json string events from [onBatchResult] stream to their corresponding
  /// drive model objects.
  dynamic toDriveModel(dynamic event) {
    Map<String, dynamic> result = Map<String, dynamic>.from(jsonDecode(event));
    if (result.containsKey('category')) {
      switch (result['category']) {
        case 'drive#historyVersion':
          return HistoryVersion.fromMap(result);
        case 'drive#historyVersionList':
          return HistoryVersionList.fromMap(result);
        case 'drive#file':
          return DriveFile.fromMap(result);
        case 'drive#fileList':
          return DriveFileList.fromMap(result);
        case 'drive#change':
          return Change.fromMap(result);
        case 'drive#changeList':
          return ChangeList.fromMap(result);
        case 'drive#startCursor':
          return StartCursor.fromMap(result);
        case 'drive#comment':
          return DriveComment.fromMap(result);
        case 'drive#commentList':
          return DriveCommentList.fromMap(result);
        case 'drive#reply':
          return DriveReply.fromMap(result);
        case 'drive#replyList':
          return DriveReplyList.fromMap(result);
        case 'drive#about':
          return DriveAbout.fromMap(result);
        case 'api#channel':
          return DriveChannel.fromMap(result);
      }
    }
    return event;
  }
}
