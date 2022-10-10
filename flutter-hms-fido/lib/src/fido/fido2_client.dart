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

part of huawei_fido;

class HmsFido2Client {
  final MethodChannel _channel =
      const MethodChannel('com.huawei.hms.flutter.fido/fido_client');

  Future<bool?> isSupported() async {
    return await _channel.invokeMethod('isSupported');
  }

  Future<bool?> hasPlatformAuthenticators() async {
    return await _channel.invokeMethod('hasPlatformAuthenticators');
  }

  Future<List<AuthenticatorMetadata?>?> getPlatformAuthenticators() async {
    dynamic res = await _channel.invokeMethod('getPlatformAuthenticators');
    if (res == null) {
      return null;
    }
    dynamic list = json.decode(res as String);
    return (list as List<dynamic>).map((dynamic e) {
      return e != null ? AuthenticatorMetadata.fromMap(e) : null;
    }).toList();
  }

  Future<Fido2RegistrationResponse?> getRegistrationIntent(
      PublicKeyCredentialCreationOptions options) async {
    dynamic res = await _channel.invokeMethod(
      'getRegistrationIntent',
      options.toMap(),
    );
    return res != null ? Fido2RegistrationResponse.fromMap(res) : null;
  }

  Future<Fido2AuthenticationResponse?> getAuthenticationIntent(
      PublicKeyCredentialRequestOptions options) async {
    dynamic res = await _channel.invokeMethod(
      'getAuthenticationIntent',
      options.toMap(),
    );
    return res != null ? Fido2AuthenticationResponse.fromMap(res) : null;
  }

  Future<void> isSupportedExAsync(
    Function({int? resultCode, String? errString}) callback,
  ) async {
    dynamic res = await _channel.invokeMethod('isSupportedExAsync');
    if (res == null) {
      return;
    }
    Map<dynamic, dynamic> result = Map<dynamic, dynamic>.from(res);
    callback(resultCode: result['resultCode'], errString: result['errString']);
  }

  Future<void> hasPlatformAuthenticatorsWithCb(
    Function({bool? result}) onSuccess,
    Function({int? errorCode, String? errString}) onFailure,
  ) async {
    dynamic res = await _channel.invokeMethod('hasPlatformAuthenticatorsCb');
    if (res == null) {
      return;
    }
    if (res.runtimeType == bool) {
      onSuccess(result: res);
    } else {
      Map<dynamic, dynamic> result = Map<dynamic, dynamic>.from(res);
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
    dynamic res = await _channel.invokeMethod('getPlatformAuthenticatorsCb');
    if (res == null) {
      return;
    }
    if (res.runtimeType == String) {
      dynamic list = json.decode(res as String);
      onSuccess(
        result: (list as List<dynamic>).map((dynamic e) {
          return e != null ? AuthenticatorMetadata.fromMap(e) : null;
        }).toList(),
      );
    } else {
      Map<dynamic, dynamic> result = Map<dynamic, dynamic>.from(res);
      onFailure(
        errorCode: result['errorCode'],
        errString: result['errString'],
      );
    }
  }
}
