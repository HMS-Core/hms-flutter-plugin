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

abstract class WalletPassApi {
  static const MethodChannel _channel = MethodChannel(
    'com.huawei.hms.flutter.passsdk/method',
  );

  /// Checks whether this type of pass can be added.
  static Future<WalletPassApiResponse> canAddPass({
    required String appid,
    required String passTypeId,
  }) async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      'canAddPass',
      <String, dynamic>{
        'appid': appid,
        'passTypeId': passTypeId,
      },
    );
    return WalletPassApiResponse._fromMap(result);
  }

  /// Adds a pass to Huawei Wallet, which will verify the signature of the pass.
  static Future<WalletPassApiResponse> addPass({
    required String hwPassData,
  }) async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      'addPass',
      <String, dynamic>{
        'hwPassData': hwPassData,
      },
    );
    return WalletPassApiResponse._fromMap(result);
  }

  /// Requests to modify the token of a pass (NFC pass only).
  /// Upon successful request, a one-time token with a validity period will be returned.
  static Future<WalletPassApiResponse> requireAccessToken({
    required String passTypeId,
  }) async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      'requireAccessToken',
      <String, dynamic>{
        'passTypeId': passTypeId,
      },
    );
    return WalletPassApiResponse._fromMap(result);
  }

  /// Requests a temporary public key for communicating with the NFC pass.
  ///
  /// Before making the request, obtain the token for interacting with the NFC pass.
  /// Then, include the token in the signature for request verification.
  static Future<WalletPassApiResponse> requireAccessCardSec({
    required String passTypeId,
    required String passId,
    required String sign,
  }) async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      'requireAccessCardSec',
      <String, dynamic>{
        'passTypeId': passTypeId,
        'passId': passId,
        'sign': sign,
      },
    );
    return WalletPassApiResponse._fromMap(result);
  }

  /// Modifies parameters of a pass (NFC pass only).
  ///
  /// Before calling this API, obtain the temporary public key for communicating
  /// with the NFC pass and encrypt the request parameters.
  static Future<WalletPassApiResponse> modifyNFCCard({
    required String passTypeId,
    required String passId,
    required String cardParams,
    required String reason,
    required String sign,
  }) async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      'modifyNFCCard',
      <String, dynamic>{
        'passTypeId': passTypeId,
        'passId': passId,
        'cardParams': cardParams,
        'reason': reason,
        'sign': sign,
      },
    );
    return WalletPassApiResponse._fromMap(result);
  }

  /// Queries designated parameters of a pass (NFC pass only).
  /// The request should contain the specified temporary public key for encrypting the query result.
  static Future<WalletPassApiResponse> readNFCCard({
    required String passTypeId,
    required String passId,
    required String cardParams,
    required String reason,
    required String sign,
  }) async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      'readNFCCard',
      <String, dynamic>{
        'passTypeId': passTypeId,
        'passId': passId,
        'cardParams': cardParams,
        'reason': reason,
        'sign': sign,
      },
    );
    return WalletPassApiResponse._fromMap(result);
  }

  /// Deletes a pass based on passId.
  static Future<WalletPassApiResponse> deletePass({
    required String passTypeId,
    required String passId,
    required String sign,
  }) async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      'deletePass',
      <String, dynamic>{
        'passTypeId': passTypeId,
        'passId': passId,
        'sign': sign,
      },
    );
    return WalletPassApiResponse._fromMap(result);
  }

  /// Queries the status of a pass based on passId.
  static Future<WalletPassApiResponse> queryPassStatus({
    required String passTypeId,
    required String passId,
  }) async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      'queryPassStatus',
      <String, dynamic>{
        'passTypeId': passTypeId,
        'passId': passId,
      },
    );
    return WalletPassApiResponse._fromMap(result);
  }

  /// Queries the device ID.
  static Future<WalletPassApiResponse> requirePassDeviceId({
    required String passTypeId,
  }) async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      'requirePassDeviceId',
      <String, dynamic>{
        'passTypeId': passTypeId,
      },
    );
    return WalletPassApiResponse._fromMap(result);
  }

  /// Queries pass information.
  static Future<WalletPassApiResponse> queryPass({
    required String requestBody,
  }) async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      'queryPass',
      <String, dynamic>{
        'requestBody': requestBody,
      },
    );
    return WalletPassApiResponse._fromMap(result);
  }

  /// Obtains the applet public key and authentication request information.
  static Future<WalletPassApiResponse> requestRegister({
    required String registerRequestBody,
  }) async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      'requestRegister',
      <String, dynamic>{
        'registerRequestBody': registerRequestBody,
      },
    );
    return WalletPassApiResponse._fromMap(result);
  }

  /// Imports applet authentication information.
  static Future<WalletPassApiResponse> confirmRegister({
    required String registerConfirmBody,
  }) async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      'confirmRegister',
      <String, dynamic>{
        'registerConfirmBody': registerConfirmBody,
      },
    );
    return WalletPassApiResponse._fromMap(result);
  }

  /// Applies for personalized data of an applet.
  static Future<WalletPassApiResponse> requestPersonalize({
    required String personalizeRequestBody,
  }) async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      'requestPersonalize',
      <String, dynamic>{
        'personalizeRequestBody': personalizeRequestBody,
      },
    );
    return WalletPassApiResponse._fromMap(result);
  }

  /// Imports the personalized data of an applet.
  static Future<WalletPassApiResponse> confirmPersonalize({
    required String personalizeConfirmBody,
  }) async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      'confirmPersonalize',
      <String, dynamic>{
        'personalizeConfirmBody': personalizeConfirmBody,
      },
    );
    return WalletPassApiResponse._fromMap(result);
  }

  /// Applies for transaction.
  static Future<WalletPassApiResponse> requestTransaction({
    required String requestTransBody,
  }) async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      'requestTransaction',
      <String, dynamic>{
        'requestTransBody': requestTransBody,
      },
    );
    return WalletPassApiResponse._fromMap(result);
  }

  /// Sends transaction information.
  static Future<WalletPassApiResponse> confirmTransaction({
    required String confirmTransBody,
  }) async {
    final Map<dynamic, dynamic> result = await _channel.invokeMethod(
      'confirmTransaction',
      <String, dynamic>{
        'confirmTransBody': confirmTransBody,
      },
    );
    return WalletPassApiResponse._fromMap(result);
  }
}
