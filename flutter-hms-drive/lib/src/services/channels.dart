/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:huawei_drive/src/request/channels_request.dart';

import '../constants/channel.dart';

/// Defines the Channels API for disabling the function of sending file change notifications through
/// the designated channel.
class Channels {
  /// Unsubscribes from a channel.
  ///
  /// Note that the `id` and `resourceId` in the constructed [DriveChannel] object
  /// in the [request] must be the same as those in the [DriveChannel]
  /// object subscribed through the [Changes.subscribe] API.
  Future<bool> stop(ChannelsRequest request) async {
    return await driveMethodChannel.invokeMethod(
        "Channels#Stop",
        {
          "channel": request.channel?.toJson(),
          "request": request?.toJson(),
          "extraParams": request.channel?.paramsToSet
        }..removeWhere((k, v) => v == null));
  }
}
