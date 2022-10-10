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

class Fido2PluginUtil {
  static bool isEccAlgorithm(Algorithm a) {
    return a == Algorithm.ES256 ||
        a == Algorithm.ES384 ||
        a == Algorithm.ES512 ||
        a == Algorithm.ECDH;
  }

  static bool isRsaAlgorithm(Algorithm a) {
    return a == Algorithm.RS256 ||
        a == Algorithm.RS384 ||
        a == Algorithm.RS512 ||
        a == Algorithm.PS256 ||
        a == Algorithm.PS384 ||
        a == Algorithm.PS512;
  }

  static Algorithm getAlgorithmFromName(String s) {
    Algorithm? a;
    for (Algorithm element in Algorithm.values) {
      if (s == describeEnum(element)) {
        a = element;
      }
    }
    if (a == null) {
      throw IllegalParameterException('No enum constant Algorithm: $s');
    } else {
      return a;
    }
  }

  static Algorithm getAlgorithmFromCode(int i) {
    if (i != -25) {
      if (i != -7) {
        switch (i) {
          case -261:
            return Algorithm.ES512;
          case -260:
            return Algorithm.ES256;
          case -259:
            return Algorithm.RS512;
          case -258:
            return Algorithm.RS384;
          case -257:
            return Algorithm.RS256;
          default:
            switch (i) {
              case -39:
                return Algorithm.PS512;
              case -38:
                return Algorithm.PS384;
              case -37:
                return Algorithm.PS256;
              case -36:
                return Algorithm.ES512;
              case -35:
                return Algorithm.ES384;
              default:
                throw IllegalParameterException(
                    'No enum constant algorithm. code: $i');
            }
        }
      } else {
        return Algorithm.ES256;
      }
    } else {
      return Algorithm.ECDH;
    }
  }

  static int encodeAlgorithmToInt(Algorithm a) {
    switch (a) {
      case Algorithm.ECDH:
        return -25;
      case Algorithm.ES256:
        return -7;
      case Algorithm.ES384:
        return -35;
      case Algorithm.ES512:
        return -36;
      case Algorithm.PS256:
        return -37;
      case Algorithm.PS384:
        return -38;
      case Algorithm.PS512:
        return -39;
      case Algorithm.RS256:
        return -257;
      case Algorithm.RS384:
        return -258;
      case Algorithm.RS512:
        return -259;
      default:
        return -1;
    }
  }

  static Attachment attachmentFromValue(String s) {
    Attachment? attachment;
    for (Attachment element in Attachment.values) {
      if (s == describeEnum(element)) {
        attachment = element;
      }
    }
    if (attachment == null) {
      throw IllegalParameterException('No enum Attachment $s');
    } else {
      return attachment;
    }
  }

  static String getAttachmentValue(Attachment attachment) {
    return describeEnum(attachment);
  }

  static AttestationConveyancePreference preferenceFromValue(String s) {
    AttestationConveyancePreference? p;
    for (AttestationConveyancePreference element
        in AttestationConveyancePreference.values) {
      if (s == describeEnum(element)) {
        p = element;
      }
    }
    if (p == null) {
      throw IllegalParameterException(
          'No enum AttestationConveyancePreference $s');
    } else {
      return p;
    }
  }

  static String getAttestationConveyancePreferenceValue(
      AttestationConveyancePreference a) {
    return describeEnum(a);
  }

  static String getPublicKeyCredentialType(PublicKeyCredentialType p) {
    return describeEnum(p);
  }

  static TokenBindingStatus tokenBindingStatusFromValue(String s) {
    TokenBindingStatus? t;
    for (TokenBindingStatus element in TokenBindingStatus.values) {
      if (s == describeEnum(element)) {
        t = element;
      }
    }
    if (t == null) {
      throw IllegalParameterException('No enum TokenBindingStatus $s');
    } else {
      return t;
    }
  }

  static String getTokenBindingStatusValue(TokenBindingStatus t) {
    return describeEnum(t);
  }

  static UserVerificationRequirement userVerificationRequirementFromValue(
      String s) {
    UserVerificationRequirement? u;
    for (UserVerificationRequirement element
        in UserVerificationRequirement.values) {
      if (s == describeEnum(element)) {
        u = element;
      }
    }
    if (u == null) {
      throw IllegalParameterException('No enum UserVerificationRequirement $s');
    } else {
      return u;
    }
  }

  static String getUserVerificationRequirementValue(
      UserVerificationRequirement u) {
    return describeEnum(u);
  }

  static AuthenticatorTransport? authenticatorTransportFromValue(String s) {
    AuthenticatorTransport? a;
    for (AuthenticatorTransport element in AuthenticatorTransport.values) {
      if (s == describeEnum(element)) {
        a = element;
      }
    }
    if (a == null) {
      throw IllegalParameterException('No enum AuthenticatorTransport $s');
    } else {
      return a;
    }
  }

  static String getAuthenticatorTransportValue(AuthenticatorTransport t) {
    return describeEnum(t);
  }

  static BioAuthnEvent? toBioEvent(String? event) =>
      _eventMap.containsKey(event) ? _eventMap[event] : null;
  static const Map<String, BioAuthnEvent> _eventMap = <String, BioAuthnEvent>{
    'onAuthError': BioAuthnEvent.onAuthError,
    'onAuthSucceeded': BioAuthnEvent.onAuthSucceeded,
    'onAuthFailed': BioAuthnEvent.onAuthFailed,
    'onAuthHelp': BioAuthnEvent.onAuthHelp
  };
}

typedef BioAuthnCallback = void Function(BioAuthnEvent? event,
    {HmsBioAuthnResult? result, int? errCode});

enum BioAuthnEvent { onAuthError, onAuthSucceeded, onAuthFailed, onAuthHelp }

class IllegalParameterException implements Exception {
  String cause;

  IllegalParameterException(this.cause);
}
