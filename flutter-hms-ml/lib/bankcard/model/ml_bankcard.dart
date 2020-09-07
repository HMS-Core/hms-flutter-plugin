/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

class MlBankcard {
  String expire;
  String number;
  int retCode;
  int tipsCode;
  dynamic originalBitmap;
  dynamic numberBitmap;

  dynamic type;
  String issuer;

  MlBankcard(
      {this.expire,
      this.number,
      this.numberBitmap,
      this.originalBitmap,
      this.retCode,
      this.tipsCode,
      this.type,
      this.issuer});

  MlBankcard.fromJson(Map<String, dynamic> json) {
    expire = json['expire'] ?? null;
    number = json['number'] ?? null;
    retCode = json['retCode'] ?? null;
    tipsCode = json['tipsCode'] ?? null;
    originalBitmap = json['originalBitmap'] ?? null;
    numberBitmap = json['numberBitmap'] ?? null;
    type = json['type'] ?? null;
    issuer = json['issuer'] ?? null;
  }
}
