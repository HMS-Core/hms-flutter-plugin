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

  Future<bool> isSupported() async {
    return await _channel.invokeMethod("isSupported");
  }

  Future<bool> hasPlatformAuthenticators() async {
    return await _channel.invokeMethod("hasPlatformAuthenticators");
  }

  Future<List<AuthenticatorMetadata>> getPlatformAuthenticators() async {
    var res =
        json.decode(await _channel.invokeMethod("getPlatformAuthenticators"));
    return (res as List).map((e) => AuthenticatorMetadata.fromMap(e)).toList();
  }

  Future<Fido2RegistrationResponse> getRegistrationIntent(
      PublicKeyCredentialCreationOptions options) async {
    return new Fido2RegistrationResponse.fromMap(
        await _channel.invokeMethod("getRegistrationIntent", options.toMap()));
  }

  Future<Fido2AuthenticationResponse> getAuthenticationIntent(
      PublicKeyCredentialRequestOptions options) async {
    return new Fido2AuthenticationResponse.fromMap(await _channel.invokeMethod(
        "getAuthenticationIntent", options.toMap()));
  }
}
