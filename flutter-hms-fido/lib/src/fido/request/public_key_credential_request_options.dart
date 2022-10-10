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

class PublicKeyCredentialRequestOptions {
  String? rpId;
  Uint8List? challenge;
  List<PublicKeyCredentialDescriptor>? allowList;
  NativeFido2Options? nativeFido2Options;
  Map<String, dynamic>? extensions;
  double? timeoutSeconds;

  PublicKeyCredentialRequestOptions(
      {this.timeoutSeconds,
      this.extensions,
      this.nativeFido2Options,
      this.challenge,
      this.allowList,
      this.rpId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rpId': rpId,
      'challenge': challenge,
      'options':
          nativeFido2Options != null ? nativeFido2Options!.toMap() : null,
      'allowList': allowList != null
          ? allowList!
              .map((PublicKeyCredentialDescriptor e) => e.toMap())
              .toList()
          : null,
      'extensions': extensions,
      'timeoutSeconds': timeoutSeconds
    };
  }

  String? get getRpId => rpId;

  Uint8List? get getChallenge => challenge;

  List<PublicKeyCredentialDescriptor>? get getAllowList => allowList;

  Map<String, dynamic>? get getExtensions => extensions;

  double? get getTimeoutSeconds => timeoutSeconds;
}
