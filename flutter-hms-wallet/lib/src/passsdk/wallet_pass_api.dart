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
import 'package:flutter/services.dart';
import 'package:huawei_wallet/src/channels.dart';
import 'package:huawei_wallet/src/service/wallet_pass_api_response.dart';

class WalletPassApi {
  static const MethodChannel _channel = const MethodChannel(
    WALLET_API_METHOD_CHANNEL,
  );

  Future<WalletPassApiResponse> canAddPass({
    String appid,
    String passTypeId,
  }) async {
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await _channel.invokeMethod('canAddPass', {
        'appid': appid,
        'passTypeId': passTypeId,
      }),
    );
    return WalletPassApiResponse.fromMap(result);
  }

  Future<WalletPassApiResponse> addPass({String hwPassData}) async {
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await _channel.invokeMethod('addPass', {
        'hwPassData': hwPassData,
      }),
    );
    return WalletPassApiResponse.fromMap(result);
  }

  Future<WalletPassApiResponse> requireAccessToken({String passTypeId}) async {
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await _channel.invokeMethod('requireAccessToken', {
        'passTypeId': passTypeId,
      }),
    );
    return WalletPassApiResponse.fromMap(result);
  }

  Future<WalletPassApiResponse> requireAccessCardSec({
    String passTypeId,
    String passId,
    String sign,
  }) async {
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await _channel.invokeMethod('requireAccessCardSec', {
        'passTypeId': passTypeId,
        'passId': passId,
        'sign': sign,
      }),
    );
    return WalletPassApiResponse.fromMap(result);
  }

  Future<WalletPassApiResponse> modifyNFCCard({
    String passTypeId,
    String passId,
    String cardParams,
    String reason,
    String sign,
  }) async {
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await _channel.invokeMethod('modifyNFCCard', {
        'passTypeId': passTypeId,
        'passId': passId,
        'cardParams': cardParams,
        'reason': reason,
        'sign': sign,
      }),
    );
    return WalletPassApiResponse.fromMap(result);
  }

  Future<WalletPassApiResponse> readNFCCard({
    String passTypeId,
    String passId,
    String cardParams,
    String reason,
    String sign,
  }) async {
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await _channel.invokeMethod('readNFCCard', {
        'passTypeId': passTypeId,
        'passId': passId,
        'cardParams': cardParams,
        'reason': reason,
        'sign': sign,
      }),
    );
    return WalletPassApiResponse.fromMap(result);
  }

  Future<WalletPassApiResponse> deletePass({
    String passTypeId,
    String passId,
    String sign,
  }) async {
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await _channel.invokeMethod('deletePass', {
        'passTypeId': passTypeId,
        'passId': passId,
        'sign': sign,
      }),
    );
    return WalletPassApiResponse.fromMap(result);
  }

  Future<WalletPassApiResponse> queryPassStatus({
    String passTypeId,
    String passId,
  }) async {
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await _channel.invokeMethod('queryPassStatus', {
        'passTypeId': passTypeId,
        'passId': passId,
      }),
    );
    return WalletPassApiResponse.fromMap(result);
  }

  Future<WalletPassApiResponse> requirePassDeviceId({String passTypeId}) async {
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await _channel.invokeMethod('requirePassDeviceId', {
        'passTypeId': passTypeId,
      }),
    );
    return WalletPassApiResponse.fromMap(result);
  }

  Future<WalletPassApiResponse> queryPass({String requestBody}) async {
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await _channel.invokeMethod('queryPass', {
        'requestBody': requestBody,
      }),
    );
    return WalletPassApiResponse.fromMap(result);
  }

  Future<WalletPassApiResponse> requestRegister({
    String registerRequestBody,
  }) async {
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await _channel.invokeMethod('requestRegister', {
        'registerRequestBody': registerRequestBody,
      }),
    );
    return WalletPassApiResponse.fromMap(result);
  }

  Future<WalletPassApiResponse> confirmRegister({
    String registerConfirmBody,
  }) async {
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await _channel.invokeMethod('confirmRegister', {
        'registerConfirmBody': registerConfirmBody,
      }),
    );
    return WalletPassApiResponse.fromMap(result);
  }

  Future<WalletPassApiResponse> requestPersonalize({
    String personalizeRequestBody,
  }) async {
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await _channel.invokeMethod('requestPersonalize', {
        'personalizeRequestBody': personalizeRequestBody,
      }),
    );
    return WalletPassApiResponse.fromMap(result);
  }

  Future<WalletPassApiResponse> confirmPersonalize({
    String personalizeConfirmBody,
  }) async {
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await _channel.invokeMethod('confirmPersonalize', {
        'personalizeConfirmBody': personalizeConfirmBody,
      }),
    );
    return WalletPassApiResponse.fromMap(result);
  }

  Future<WalletPassApiResponse> requestTransaction({
    String requestTransBody,
  }) async {
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await _channel.invokeMethod('requestTransaction', {
        'requestTransBody': requestTransBody,
      }),
    );
    return WalletPassApiResponse.fromMap(result);
  }

  Future<WalletPassApiResponse> confirmTransaction({
    String confirmTransBody,
  }) async {
    Map<String, dynamic> result = Map<String, dynamic>.from(
      await _channel.invokeMethod('confirmTransaction', {
        'confirmTransBody': confirmTransBody,
      }),
    );
    return WalletPassApiResponse.fromMap(result);
  }
}
