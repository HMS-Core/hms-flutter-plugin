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

typedef RefreshTokenCallback = Future<String?> Function();

/// Drive authentication class.
class DriveCredentials {
  static const MethodChannel _channel = driveMethodChannel;

  ///	UnionID obtained after a user signs in using a HUAWEI ID.
  String? unionId;

  /// Authentication information.
  String? accessToken;

  /// Sets the validity period of an access token.
  int? expiresInSeconds;

  /// User defined callback for obtaining a new access token.
  RefreshTokenCallback? callback;

  DriveCredentials({
    this.unionId,
    this.accessToken,
    this.callback,
    this.expiresInSeconds,
  }) {
    _channel.setMethodCallHandler(_onMethodCall);
  }

  /// Method call to handle the refreshToken callbacks from the native platform.
  Future<dynamic> _onMethodCall(MethodCall call) async {
    if (call.method == 'refreshToken') {
      return await callback?.call();
    } else {
      throw 'Method Not Implemented';
    }
  }

  /// Returns a map representation of the object.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'unionId': unionId,
      'accessToken': accessToken,
      'expiresInSeconds': expiresInSeconds
    }..removeWhere((String k, dynamic v) => v == null);
  }

  /// Copies the current object and updates the specified attributes.
  DriveCredentials clone({
    String? unionId,
    String? accessToken,
    int? expiresInSeconds,
    RefreshTokenCallback? callback,
  }) {
    return DriveCredentials(
      unionId: unionId,
      accessToken: accessToken,
      callback: callback,
      expiresInSeconds: expiresInSeconds,
    );
  }
}
