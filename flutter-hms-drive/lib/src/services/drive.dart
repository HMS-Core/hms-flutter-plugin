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
import 'package:huawei_drive/src/constants/channel.dart';
import 'package:huawei_drive/src/model/export.dart';
import 'package:huawei_drive/src/request/about_request.dart';
import 'package:huawei_drive/src/services/batch.dart';
import 'package:huawei_drive/src/services/export.dart';

import 'package:huawei_drive/src/services/changes.dart';

/// Defines the main enterence class of HUAWEI Drive Kit.
///
/// HUAWEI Drive Flutter Plugin implementation class, which manages files on drives,
/// including file upload, download, search, comment and change detection.
class Drive {
  static const MethodChannel _channel = driveMethodChannel;

  static final Drive _instance = Drive._();

  Drive._();

  /// Files API.
  Files files = Files();

  /// Comments API.
  Comments comments = Comments();

  /// Replies API.
  Replies replies = Replies();

  /// Channels API.
  Channels channels = Channels();

  /// Changes API.
  Changes changes = Changes();

  /// HistoryVersions API.
  HistoryVersions historyVersions = HistoryVersions();

  /// Batch API.
  Batch batch = Batch();

  /// Initializes the Drive instance for managing files.
  static Future<Drive> init(DriveCredentials driveCredentials) async {
    await _channel.invokeMethod('Drive#Init', driveCredentials.toMap());
    return _instance;
  }

  /// Obtains a user's Drive information, such as its storage quota limit
  /// and maximum size of a file that can be uploaded by the user.
  Future<DriveAbout> about(AboutRequest request) async {
    final String result =
        await _channel.invokeMethod('About#Get', request.toJson());
    return DriveAbout.fromJson(result);
  }

  /// This method enables the HMSLogger capability which is used for
  /// sending usage analytics of Drive SDK's methods to improve
  /// the service quality.
  Future<void> enableLogger() async {
    _channel.invokeMethod('Logger#Enable');
  }

  /// This method disables the HMSLogger capability which is used for
  /// sending usage analytics of Drive SDK's methods to improve
  /// the service quality.
  Future<void> disableLogger() async {
    _channel.invokeMethod('Logger#Disable');
  }
}
