/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_contactshield;

@immutable
class CsApiException {
  final String? message;
  final int? code;

  const CsApiException(
    this.message,
    this.code,
  );

  factory CsApiException.fromException(PlatformException e) {
    return CsApiException(e.message, int.parse(e.code));
  }

  factory CsApiException.fromJson(String source) {
    return CsApiException.fromMap(json.decode(source));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory CsApiException.fromMap(Map<String, dynamic> map) {
    return CsApiException(
      map['message'],
      map['code'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'code': code,
    };
  }

  @override
  String toString() {
    return '$CsApiException('
        'message: $message, '
        'code: $code)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is CsApiException &&
        other.message == message &&
        other.code == code;
  }

  @override
  int get hashCode {
    return message.hashCode ^ code.hashCode;
  }
}
