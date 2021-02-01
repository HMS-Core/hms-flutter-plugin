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
import 'dart:typed_data';

class Fido2RegistrationResponse {
  bool isSuccess;
  int fido2Status;
  int ctapStatus;
  String ctapStatusMessage;
  String fido2StatusMessage;
  AuthenticatorAttestationResponse authenticatorAttestationResponse;

  Fido2RegistrationResponse(
      {this.authenticatorAttestationResponse,
      this.isSuccess,
      this.ctapStatus,
      this.ctapStatusMessage,
      this.fido2Status,
      this.fido2StatusMessage});

  factory Fido2RegistrationResponse.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;
    return Fido2RegistrationResponse(
        isSuccess: map['isSuccess'] ?? null,
        fido2Status: map['fido2Status'] ?? null,
        ctapStatus: map['ctapStatus'] ?? null,
        ctapStatusMessage: map['ctapStatusMessage'] ?? null,
        fido2StatusMessage: map['fido2StatusMessage'] ?? null,
        authenticatorAttestationResponse:
            map['authenticatorAttestationResponse'] != null
                ? AuthenticatorAttestationResponse.fromMap(
                    map['authenticatorAttestationResponse'])
                : null);
  }
}

class AuthenticatorAttestationResponse {
  Uint8List attestationObject;
  Uint8List clientDataJson;
  Uint8List credentialId;

  AuthenticatorAttestationResponse(
      {this.attestationObject, this.clientDataJson, this.credentialId});

  factory AuthenticatorAttestationResponse.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;
    return AuthenticatorAttestationResponse(
        attestationObject: map['attestationObject'] ?? null,
        clientDataJson: map['clientDataJson'] ?? null,
        credentialId: map['credentialId'] ?? null);
  }

  String toJson() => json.encode(this);
}
