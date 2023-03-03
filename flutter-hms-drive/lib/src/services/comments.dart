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
import 'package:huawei_drive/src/request/comments_request.dart';

import 'package:huawei_drive/src/constants/constants.dart';
import 'package:huawei_drive/src/model/drive_comment.dart';
import 'package:huawei_drive/src/model/drive_comment_list.dart';

/// Defines the Comments API.
///
/// HUAWEI Drive Kit allows your app to provide file commenting functions for users,
/// including commenting on files in the cloud as well as viewing, updating, and
/// deleting comments.
class Comments {
  static const MethodChannel _channel = driveMethodChannel;

  /// Creates a comment on a file.
  Future<DriveComment> create(CommentsRequest request) async {
    final String result =
        await _channel.invokeMethod('Comments#Create', <dynamic, dynamic>{
      'request': request.toJson(),
      'comment': request.comment?.toJson(),
      'extraParams': request.comment?.paramsToSet,
    });
    return DriveComment.fromJson(result);
  }

  /// Deletes a comment on a file.
  Future<bool> delete(CommentsRequest request) async {
    return await _channel.invokeMethod('Comments#Delete', request.toJson());
  }

  /// Obtains a comment on a file.
  Future<DriveComment> getComment(CommentsRequest request) async {
    final String result =
        await _channel.invokeMethod('Comments#Get', request.toJson());
    return DriveComment.fromJson(result);
  }

  /// Obtains a file comment list.
  Future<DriveCommentList> list(CommentsRequest request) async {
    final String result =
        await _channel.invokeMethod('Comments#List', request.toJson());
    return DriveCommentList.fromJson(result);
  }

  /// Updates a file comment.
  Future<DriveComment> update(CommentsRequest request) async {
    final String result =
        await _channel.invokeMethod('Comments#Update', <dynamic, dynamic>{
      'request': request.toJson(),
      'comment': request.comment?.toJson(),
      'extraParams': request.comment?.paramsToSet,
    });
    return DriveComment.fromJson(result);
  }
}
