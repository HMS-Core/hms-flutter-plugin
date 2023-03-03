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
import 'package:huawei_drive/src/constants/channel.dart';
import 'package:huawei_drive/src/model/export.dart';
import 'package:huawei_drive/src/request/changes_request.dart';

/// Defines the Changes API.
///
/// HUAWEI Drive Kit allows your app to send file change notifications to users
/// so that they can synchronize files in the cloud and those stored locally.
///
/// To use the Changes API, you need a server that can receive changes and push
/// them to your app in real time. After receiving the changes, the app can update
/// local files at the request of the user.
class Changes {
  static const MethodChannel _channel = driveMethodChannel;

  /// Obtains a cursor.
  ///
  /// After the cursor is obtained, file change notification is enabled.
  Future<StartCursor> getStartCursor({
    required ChangesRequest changesRequest,
  }) async {
    final String result = await _channel.invokeMethod(
      'Changes#GetStartCursor',
      changesRequest.toJson(),
    );
    return StartCursor.fromJson(result);
  }

  /// Subscribes to changes of all files and folders.
  ///
  /// If any change is detected, a callback notification is sent to the API caller.
  Future<DriveChannel> subscribe(ChangesRequest changesRequest) async {
    if (changesRequest.channel == null) {
      throw 'Please provide a channel';
    } else if (changesRequest.cursor == null ||
        (changesRequest.cursor?.isEmpty ?? true)) {
      throw 'Please provide a cursor';
    }

    final String result =
        await _channel.invokeMethod('Changes#Subscribe', <dynamic, dynamic>{
      'channel': changesRequest.channel?.toJson(),
      'request': changesRequest.toJson(),
      'extraParams': changesRequest.channel?.paramsToSet
    });
    return DriveChannel.fromJson(result);
  }

  /// Lists changes.
  Future<ChangeList> list(ChangesRequest changesRequest) async {
    if (changesRequest.cursor?.isEmpty ?? true) {
      throw 'Please provide a cursor';
    }

    final String result =
        await _channel.invokeMethod('Changes#List', changesRequest.toJson());
    return ChangeList.fromMap(json.decode(result));
  }
}
