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

class PublicKeyCredentialCreationOptions {
  Uint8List? challenge;
  NativeFido2Options? nativeFido2Options;
  TokenBinding? tokenBinding;
  PublicKeyCredentialRpEntity? rp;
  PublicKeyCredentialUserEntity? user;
  List<PublicKeyCredentialParameters>? pubKeyCredParams;
  List<PublicKeyCredentialDescriptor>? excludeList;
  Map<String, dynamic>? extensions;
  AuthenticatorSelectionCriteria? authenticatorSelection;
  AttestationConveyancePreference? attestation;
  double? timeoutSeconds;

  PublicKeyCredentialCreationOptions(
      {this.attestation,
      this.authenticatorSelection,
      this.challenge,
      this.excludeList,
      this.tokenBinding,
      this.extensions,
      this.pubKeyCredParams,
      this.rp,
      this.nativeFido2Options,
      this.timeoutSeconds,
      this.user});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'challenge': challenge,
      'extensions': extensions,
      'timeoutSeconds': timeoutSeconds,
      'rp': rp != null ? rp!.toMap() : null,
      'user': user != null ? user!.toMap() : null,
      'tokenBinding': tokenBinding != null ? tokenBinding!.toMap() : null,
      'options':
          nativeFido2Options != null ? nativeFido2Options!.toMap() : null,
      'excludeList': excludeList != null
          ? excludeList!
              .map((PublicKeyCredentialDescriptor e) => e.toMap())
              .toList()
          : null,
      'authenticatorSelection': authenticatorSelection != null
          ? authenticatorSelection!.toMap()
          : null,
      'pubKeyCredParams': pubKeyCredParams != null
          ? pubKeyCredParams!
              .map((PublicKeyCredentialParameters e) => e.toMap())
              .toList()
          : null,
      'attestation': attestation != null ? describeEnum(attestation!) : null
    };
  }

  Uint8List? get getChallenge => challenge;

  NativeFido2Options? get getNativeFido2Options => nativeFido2Options;

  TokenBinding? get getTokenBinding => tokenBinding;

  PublicKeyCredentialRpEntity? get getRp => rp;

  PublicKeyCredentialUserEntity? get getUser => user;

  List<PublicKeyCredentialParameters>? get getPubKeyCredParams =>
      pubKeyCredParams;

  List<PublicKeyCredentialDescriptor>? get getExcludeList => excludeList;

  Map<String, dynamic>? get getExtensions => extensions;

  AuthenticatorSelectionCriteria? get getAuthenticatorSelection =>
      authenticatorSelection;

  AttestationConveyancePreference? get getAttestation => attestation;

  double? get getTimeoutSeconds => timeoutSeconds;
}
