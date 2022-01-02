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

class AuthenticatorMetadata {
  static const int UVM_FINGERPRINT = 2;
  static const int UVM_FACEPRINT = 16;

  String? aaGuid;
  int? uVms;
  List<dynamic>? extensions;
  bool? isAvailable;

  AuthenticatorMetadata(
      {this.extensions, this.aaGuid, this.isAvailable, this.uVms});

  factory AuthenticatorMetadata.fromMap(Map<String, dynamic>? map) {
    if (map == null) return AuthenticatorMetadata();
    return AuthenticatorMetadata(
        aaGuid: map['aaGuid'] ?? null,
        uVms: map['uVms'] ?? null,
        extensions: map['extensions'] ?? null,
        isAvailable: map['isAvailable'] ?? null);
  }

  bool isSupportedUvm(int var1) {
    return uVms!=null &&  (this.uVms! & var1) != 0;
  }
}
