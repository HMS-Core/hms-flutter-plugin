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

import 'package:flutter/services.dart';
import 'package:huawei_drive/huawei_drive.dart';

import 'package:huawei_drive/src/constants/constants.dart';

/// Defines the Replies API.
///
/// HUAWEI Drive Kit allows your app to provide the reply function for users,
/// including adding, viewing, updating, and deleting replies to comments on files in the cloud.
class Replies {
  static const MethodChannel _channel = driveMethodChannel;

  /// Replies to a comment.
  Future<DriveReply> create(RepliesRequest request) async {
    final String result =
        await _channel.invokeMethod('Replies#Create', <dynamic, dynamic>{
      'request': request.toJson(),
      'reply': request.reply?.toJson(),
      'extraParams': request.reply?.paramsToSet,
    });
    return DriveReply.fromJson(result);
  }

  /// Deletes a reply to a comment.
  Future<bool> delete(RepliesRequest request) async {
    return await _channel.invokeMethod('Replies#Delete', request.toJson());
  }

  /// Obtains a reply by ID.
  Future<DriveReply> getReply(RepliesRequest request) async {
    final String result =
        await _channel.invokeMethod('Replies#Get', request.toJson());
    return DriveReply.fromJson(result);
  }

  /// Lists all replies to a comment.
  Future<DriveReplyList> list(RepliesRequest request) async {
    final String result =
        await _channel.invokeMethod('Replies#List', request.toJson());
    return DriveReplyList.fromJson(result);
  }

  /// Updates a reply to a comment.
  Future<DriveReply> update(RepliesRequest request) async {
    final String result =
        await _channel.invokeMethod('Replies#Update', <dynamic, dynamic>{
      'request': request.toJson(),
      'reply': request.reply?.toJson(),
      'extraParams': request.reply?.paramsToSet,
    });
    return DriveReply.fromJson(result);
  }
}
