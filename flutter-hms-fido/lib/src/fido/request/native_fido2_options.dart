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

class NativeFido2Options {
  OriginFormat? originFormat;
  BiometricPromptInfo? info;

  NativeFido2Options({this.info, this.originFormat});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'originFormat': originFormat != null ? describeEnum(originFormat!) : null,
      'info': info != null ? info!.toMap() : null
    };
  }

  OriginFormat? get getOriginFormat => originFormat;

  BiometricPromptInfo? get getBiometricPromptInfo => info;
}
