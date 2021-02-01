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
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:huawei_wallet/huawei_wallet.dart';

import 'channels.dart';

class HuaweiWallet {
  static const MethodChannel _channel = const MethodChannel(
    WALLET_METHOD_CHANNEL,
  );

  /// [content] is a JSON Web Encryption (JWE) data.
  /// It can be generated with a PassObject.
  static Future<CreateWalletPassResult> createWalletPassWithSdk({
    String content,
  }) async {
    int code = await _channel.invokeMethod('createWalletPassWithSdk', {
      'content': content,
    });
    return _createWalletPassResultFromCode(code);
  }

  static Future<CreateWalletPassResult> createWalletPassWithIntent({
    String content,
  }) async {
    int code = await _channel.invokeMethod('createWalletPassWithIntent', {
      'uri': "hms://www.huawei.com/payapp/{$content}",
    });
    return _createWalletPassResultFromCode(code);
  }

  static Future<dynamic> startActivityWithUriIntent({String uri}) async {
    return await _channel.invokeMethod('startActivityWithUriIntent', {
      'uri': uri,
    });
  }

  static Future<String> generateJwe({
    String appId,
    String dataJson,
    String jwePrivateKey,
    String sessionKeyPublicKey,
  }) async {
    Map<String, dynamic> data = jsonDecode(dataJson);
    data['iss'] = appId;
    data.removeWhere((key, value) => value == null);
    dataJson = jsonEncode(data);
    return await _channel.invokeMethod('generateJwe', {
      'dataJson': dataJson,
      'jwePrivateKey': jwePrivateKey,
      'sessionKeyPublicKey': sessionKeyPublicKey,
    });
  }

  static Future<bool> enableLogger() async {
    return await _channel.invokeMethod('enableLogger');
  }

  static Future<bool> disableLogger() async {
    return await _channel.invokeMethod('disableLogger');
  }

  static CreateWalletPassResult _createWalletPassResultFromCode(int code) {
    switch (code) {
      case 10000:
        return CreateWalletPassResult.resultOk;
      case 20000:
        return CreateWalletPassResult.resultCanceled;
      case 30000:
        return CreateWalletPassResult.noOwner;
      case 40000:
        return CreateWalletPassResult.hmsVersionCode;
      default:
        return CreateWalletPassResult.unknown;
    }
  }
}
