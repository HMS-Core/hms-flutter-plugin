/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

@immutable
class CsApiException {
  final String message;
  final int code;

  CsApiException(
    this.message,
    this.code,
  );

  factory CsApiException.fromException(PlatformException e) =>
      CsApiException(e.message, int.parse(e.code));

  factory CsApiException.fromJson(String source) =>
      CsApiException.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  factory CsApiException.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CsApiException(
      map['message'] == null ? null : map['message'],
      map['code'] == null ? null : map['code'],
    );
  }

  Map<String, dynamic> toMap() => {
        'message': message == null ? null : message,
        'code': code == null ? null : code,
      };

  @override
  String toString() => 'CsApiException(message: $message, code: $code)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CsApiException && o.message == message && o.code == code;
  }

  @override
  int get hashCode => message.hashCode ^ code.hashCode;
}
