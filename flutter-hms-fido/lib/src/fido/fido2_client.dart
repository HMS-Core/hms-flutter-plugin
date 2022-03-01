/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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
import './response/fido2_authentication_response.dart';
import './response/fido2_registration_response.dart';
import './request/public_key_credential_creation_options.dart';
import './request/public_key_credential_request_options.dart';
import './response/authenticator_metadata.dart';

class HmsFido2Client {
  MethodChannel _channel =
      const MethodChannel("com.huawei.hms.flutter.fido/fido_client");

  Future<bool?> isSupported() async {
    return await _channel.invokeMethod("isSupported");
  }

  Future<bool?> hasPlatformAuthenticators() async {
    return await _channel.invokeMethod("hasPlatformAuthenticators");
  }

  Future<List<AuthenticatorMetadata?>?> getPlatformAuthenticators() async {
    var res = await _channel.invokeMethod("getPlatformAuthenticators");
    if (res == null) return null;
    var list = json.decode(res as String);
    return (list as List).map((e) {
      return e != null ? AuthenticatorMetadata.fromMap(e) : null;
    }).toList();
  }

  Future<Fido2RegistrationResponse?> getRegistrationIntent(
      PublicKeyCredentialCreationOptions options) async {
    var res =
        await _channel.invokeMethod("getRegistrationIntent", options.toMap());
    return res != null ? new Fido2RegistrationResponse.fromMap(res) : null;
  }

  Future<Fido2AuthenticationResponse?> getAuthenticationIntent(
      PublicKeyCredentialRequestOptions options) async {
    var res =
        await _channel.invokeMethod("getAuthenticationIntent", options.toMap());
    return res != null ? new Fido2AuthenticationResponse.fromMap(res) : null;
  }

  Future<void> isSupportedExAsync(
    Function({int? resultCode, String? errString}) callback,
  ) async {
    var res = await _channel.invokeMethod("isSupportedExAsync");
    if (res == null) return null;
    Map result = Map.from(res);
    callback(resultCode: result['resultCode'], errString: result['errString']);
  }

  Future<void> hasPlatformAuthenticatorsWithCb(
    Function({bool? result}) onSuccess,
    Function({int? errorCode, String? errString}) onFailure,
  ) async {
    var res = await _channel.invokeMethod("hasPlatformAuthenticatorsCb");
    if (res == null) return null;
    if (res.runtimeType == bool) {
      onSuccess(result: res);
    } else {
      Map result = Map.from(res);
      onFailure(
        errorCode: result['errorCode'],
        errString: result['errString'],
      );
    }
  }

  Future<void> getPlatformAuthenticatorsWithCb(
    Function({List<AuthenticatorMetadata?>? result}) onSuccess,
    Function({int? errorCode, String? errString}) onFailure,
  ) async {
    var res = await _channel.invokeMethod("getPlatformAuthenticatorsCb");
    if (res == null) return null;
    if (res.runtimeType == String) {
      var list = json.decode(res as String);
      onSuccess(
        result: (list as List).map((e) {
          return e != null ? AuthenticatorMetadata.fromMap(e) : null;
        }).toList(),
      );
    } else {
      Map result = Map.from(res);
      onFailure(
        errorCode: result['errorCode'],
        errString: result['errString'],
      );
    }
  }
}
