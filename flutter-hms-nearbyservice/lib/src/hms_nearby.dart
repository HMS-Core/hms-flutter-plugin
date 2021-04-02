/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:huawei_nearbyservice/huawei_nearbyservice.dart';
import 'package:huawei_nearbyservice/src/utils/channels.dart';

class HMSNearby {
  final MethodChannel _channel;

  HMSNearby._(
    this._channel,
  );

  static final HMSNearby _instance = HMSNearby._(
    const MethodChannel(NEARBY_METHOD_CHANNEL),
  );

  static Future<String> getVersion() {
    return _instance._channel.invokeMethod("getVersion");
  }

  static Future<bool> equalsMessage(Message object, Message other) {
    ArgumentError.checkNotNull(object);
    ArgumentError.checkNotNull(other);
    return _instance._channel.invokeMethod("equalsMessage",
        <String, dynamic>{'object': object.toMap(), 'other': other.toMap()});
  }

  static Future<void> enableLogger() {
    return _instance._channel.invokeMethod("enableLogger");
  }

  static Future<void> disableLogger() {
    return _instance._channel.invokeMethod("disableLogger");
  }
}

class HMSNearbyApiContext {
  HMSNearbyApiContext._();
  static final HMSNearbyApiContext _instance = HMSNearbyApiContext._();
  static HMSNearbyApiContext get instance => _instance;

  Future<void> setApiKey(String apiKey) async {
    if (apiKey == null) {
      throw ArgumentError.notNull("apiKey");
    }
    return HMSNearby._instance._channel
        .invokeMethod("setApiKey", {"apiKey": apiKey});
  }

  Future<String> getApiKey() async {
    String apiKey =
        await HMSNearby._instance._channel.invokeMethod("getApiKey");
    return apiKey;
  }
}
