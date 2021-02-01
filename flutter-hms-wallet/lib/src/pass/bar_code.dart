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
import 'dart:convert';

class BarCode {
  static final String barcodeTypeCodebar = "codabar";
  static final String barcodeTypeQrCode = "qrCode";

  final String text;
  final String type;
  final String value;
  BarCode({
    this.text,
    this.type,
    this.value,
  });

  BarCode copyWith({
    String text,
    String type,
    String value,
  }) {
    return BarCode(
      text: text ?? this.text,
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'type': type,
      'value': value,
    };
  }

  factory BarCode.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return BarCode(
      text: map['text'],
      type: map['type'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BarCode.fromJson(String source) =>
      BarCode.fromMap(json.decode(source));

  @override
  String toString() => 'BarCode(text: $text, type: $type, value: $value)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BarCode && o.text == text && o.type == type && o.value == value;
  }

  @override
  int get hashCode => text.hashCode ^ type.hashCode ^ value.hashCode;
}
