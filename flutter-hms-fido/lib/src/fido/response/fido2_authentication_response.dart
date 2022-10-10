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

class Fido2AuthenticationResponse {
  bool? isSuccess;
  int? ctapStatus;
  String? ctapStatusMessage;
  int? fido2Status;
  String? fido2StatusMessage;
  AuthenticatorAssertionResponse? assertionResponse;

  Fido2AuthenticationResponse(
      {this.assertionResponse,
      this.fido2StatusMessage,
      this.fido2Status,
      this.ctapStatusMessage,
      this.ctapStatus,
      this.isSuccess});

  factory Fido2AuthenticationResponse.fromMap(Map<dynamic, dynamic> map) {
    return Fido2AuthenticationResponse(
        isSuccess: map['isSuccess'],
        ctapStatus: map['ctapStatus'],
        ctapStatusMessage: map['ctapStatusMessage'],
        fido2Status: map['fido2Status'],
        fido2StatusMessage: map['fido2StatusMessage'],
        assertionResponse: map['assertionResponse'] != null
            ? AuthenticatorAssertionResponse.fromMap(map['assertionResponse'])
            : null);
  }
}

class AuthenticatorAssertionResponse {
  Uint8List? authenticatorData;
  Uint8List? clientDataJson;
  Uint8List? credentialId;
  Uint8List? signature;

  AuthenticatorAssertionResponse(
      {this.credentialId,
      this.clientDataJson,
      this.signature,
      this.authenticatorData});

  factory AuthenticatorAssertionResponse.fromMap(Map<dynamic, dynamic> map) {
    return AuthenticatorAssertionResponse(
        authenticatorData: map['authenticatorData'],
        clientDataJson: map['clientDataJson'],
        credentialId: map['credentialId'],
        signature: map['signature']);
  }

  String toJson() => json.encode(this);
}
