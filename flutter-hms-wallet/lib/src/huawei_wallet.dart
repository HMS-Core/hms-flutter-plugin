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

part of huawei_wallet;

abstract class HuaweiWallet {
  static const MethodChannel _channel = MethodChannel(
    'com.huawei.hms.flutter.wallet/method',
  );

  /// [content] is a JSON Web Encryption (JWE) data.
  /// It can be generated with a PassObject.
  static Future<CreateWalletPassResult> createWalletPassWithSdk({
    required String content,
  }) async {
    final int? code = await _channel.invokeMethod(
      'createWalletPassWithSdk',
      <String, dynamic>{
        'content': content,
      },
    );
    return _createWalletPassResultFromCode(code);
  }

  static Future<CreateWalletPassResult> createWalletPassWithIntent({
    required String content,
  }) async {
    final int? code = await _channel.invokeMethod(
      'createWalletPassWithIntent',
      <String, dynamic>{
        'uri': 'hms://www.huawei.com/payapp/{$content}',
      },
    );
    return _createWalletPassResultFromCode(code);
  }

  static Future<void> startActivityWithUriIntent({
    required String uri,
  }) async {
    return await _channel.invokeMethod(
      'startActivityWithUriIntent',
      <String, dynamic>{
        'uri': uri,
      },
    );
  }

  static Future<String> generateJwe({
    required String appId,
    required PassObject passObject,
    required String jwePrivateKey,
    required String sessionKeyPublicKey,
  }) async {
    return await _channel.invokeMethod(
      'generateJwe',
      <String, dynamic>{
        'appId': appId,
        'passObject': passObject._toMap(),
        'jwePrivateKey': jwePrivateKey,
        'sessionKeyPublicKey': sessionKeyPublicKey,
      },
    );
  }

  static Future<void> enableLogger() async {
    return await _channel.invokeMethod(
      'enableLogger',
    );
  }

  static Future<void> disableLogger() async {
    return await _channel.invokeMethod(
      'disableLogger',
    );
  }

  static CreateWalletPassResult _createWalletPassResultFromCode(int? code) {
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

enum CreateWalletPassResult {
  resultOk,
  resultCanceled,
  noOwner,
  hmsVersionCode,
  unknown,
}
