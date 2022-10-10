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

enum PublicKeyCredentialType { PUBLIC_KEY }

enum Algorithm {
  ES256,
  ES384,
  ES512,
  RS256,
  RS384,
  RS512,
  PS256,
  PS384,
  PS512,
  ECDH
}

enum Attachment { PLATFORM, CROSS_PLATFORM }

enum UserVerificationRequirement { REQUIRED, PREFERRED, DISCOURAGED }

enum AttestationConveyancePreference { NONE, INDIRECT, DIRECT }

enum TokenBindingStatus { PRESENT, SUPPORTED }

enum OriginFormat { HTML, ANDROID }

enum AuthenticatorTransport { USB, NFC, BLE }
