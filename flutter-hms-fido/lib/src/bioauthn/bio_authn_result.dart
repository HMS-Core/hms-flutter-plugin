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

class HmsBioAuthnResult {
  HmsCryptoObject? cryptoObject;

  HmsBioAuthnResult({this.cryptoObject});

  factory HmsBioAuthnResult.fromMap(Map<dynamic, dynamic> map) {
    return HmsBioAuthnResult(
        cryptoObject: map['cryptoObject'] != null
            ? HmsCryptoObject.fromMap(map['cryptoObject'])
            : null);
  }
}

class HmsCryptoObject {
  HmsCipher? cipher;
  HmsMac? mac;
  HmsSignature? signature;

  HmsCryptoObject({this.cipher, this.mac, this.signature});

  factory HmsCryptoObject.fromMap(Map<dynamic, dynamic> map) {
    return HmsCryptoObject(
        cipher: map['cipher'] != null ? HmsCipher.fromMap(map['cipher']) : null,
        mac: map['mac'] != null ? HmsMac.fromMap(map['mac']) : null,
        signature: map['signature'] != null
            ? HmsSignature.fromMap(map['signature'])
            : null);
  }
}

class HmsCipher {
  String? algorithm;
  int? blockSize;
  Uint8List? iv;
  HmsAlgorithmParameters? algorithmParameters;

  HmsCipher(
      {this.algorithmParameters, this.algorithm, this.blockSize, this.iv});

  factory HmsCipher.fromMap(Map<dynamic, dynamic> map) {
    return HmsCipher(
        algorithm: map['algorithm'],
        blockSize: map['blockSize'],
        iv: map['iv'],
        algorithmParameters: map['algorithmParameters'] != null
            ? HmsAlgorithmParameters.fromMap(map['algorithmParameters'])
            : null);
  }
}

class HmsAlgorithmParameters {
  String? algorithm;
  Uint8List? encoded;
  HmsBioAuthnProvider? provider;

  HmsAlgorithmParameters({this.algorithm, this.encoded, this.provider});

  factory HmsAlgorithmParameters.fromMap(Map<dynamic, dynamic> map) {
    return HmsAlgorithmParameters(
        algorithm: map['algorithm'],
        encoded: map['encoded'],
        provider: map['provider'] != null
            ? HmsBioAuthnProvider.fromMap(map['provider'])
            : null);
  }
}

class HmsBioAuthnProvider {
  String? info;
  String? name;
  double? version;

  HmsBioAuthnProvider({this.info, this.name, this.version});

  factory HmsBioAuthnProvider.fromMap(Map<dynamic, dynamic> map) {
    return HmsBioAuthnProvider(
      info: map['info'],
      name: map['name'],
      version: map['version'],
    );
  }
}

class HmsSignature {
  String? algorithm;
  HmsAlgorithmParameters? algorithmParameters;
  HmsBioAuthnProvider? provider;

  HmsSignature({this.algorithmParameters, this.provider, this.algorithm});

  factory HmsSignature.fromMap(Map<dynamic, dynamic> map) {
    return HmsSignature(
        algorithm: map['algorithm'],
        algorithmParameters: map['algorithmParameters'] != null
            ? HmsAlgorithmParameters.fromMap(map['algorithmParameters'])
            : null,
        provider: map['provider'] != null
            ? HmsBioAuthnProvider.fromMap(map['provider'])
            : null);
  }
}

class HmsMac {
  String? algorithm;
  HmsBioAuthnProvider? provider;
  int? length;

  HmsMac({this.algorithm, this.provider, this.length});

  factory HmsMac.fromMap(Map<dynamic, dynamic> map) {
    return HmsMac(
        algorithm: map['algorithm'],
        provider: map['provider'] != null
            ? HmsBioAuthnProvider.fromMap(map['provider'])
            : null,
        length: map['length']);
  }
}
