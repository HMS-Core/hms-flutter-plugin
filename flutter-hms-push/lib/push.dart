/*
Copyright (c) Huawei Technologies Co., Ltd. 2012-2020. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'dart:async';

import 'package:flutter/services.dart';

import './constants/method.dart' as Method;
import './constants/channel.dart' as Channel;
import 'constants/code.dart';

class Push {
  static const MethodChannel mChannel =
      const MethodChannel(Channel.METHOD_CHANNEL);

  static Future<String> turnOnPush() async {
    final String result = await mChannel.invokeMethod(Method.turnOnPush);
    return Code[result];
  }

  static Future<String> turnOffPush() async {
    final String result = await mChannel.invokeMethod(Method.turnOffPush);
    return Code[result];
  }

  static Future<String> getId() async {
    final String result = await mChannel.invokeMethod(Method.getId);
    return result;
  }

  static Future<String> getAAID() async {
    final String result = await mChannel.invokeMethod(Method.getAAID);
    return result;
  }

  static Future<String> getAppId() async {
    final String result = await mChannel.invokeMethod(Method.getAppId);
    return result;
  }

  static Future<String> getToken() async {
    final String result = await mChannel.invokeMethod<String>(Method.getToken);
    return result;
  }

  static Future<String> getCreationTime() async {
    final String result = await mChannel.invokeMethod(Method.getCreationTime);
    return result;
  }

  static Future<String> deleteAAID() async {
    final String result = await mChannel.invokeMethod(Method.deleteAAID);
    return Code[result];
  }

  static Future<String> deleteToken() async {
    final String result = await mChannel.invokeMethod(Method.deleteToken);
    return result;
  }

  static Future<String> subscribe(String topic) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("topic", () => topic);

    final String result = await mChannel.invokeMethod(Method.subscribe, args);
    return Code[result];
  }

  static Future<String> unsubscribe(String topic) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("topic", () => topic);

    final String result = await mChannel.invokeMethod(Method.unsubscribe, args);
    return Code[result];
  }

  static Future<String> setAutoInitEnabled(bool enabled) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("enabled", () => enabled);

    final String result =
        await mChannel.invokeMethod(Method.setAutoInitEnabled, args);
    return Code[result];
  }

  static Future<bool> isAutoInitEnabled() async {
    final bool result = await mChannel.invokeMethod(Method.isAutoInitEnabled);
    return result;
  }

  static Future<String> getAgConnectValues() async {
    final String result =
        await mChannel.invokeMethod<String>(Method.getAgConnectValues);
    return result;
  }

  static Future<Null> showToast(String msg) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("msg", () => msg);

    await mChannel.invokeMethod(Method.showToast, args);
    return null;
  }
}
