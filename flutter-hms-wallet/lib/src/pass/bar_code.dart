/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

part of huawei_wallet;

class BarCode {
  /// 1D barcode if this constant is assigned a value.
  static const String barcodeTypeCodabar = 'codabar';

  /// 2D barcode if this constant is assigned a value.
  static const String barcodeTypeQrCode = 'qrCode';

  /// Barcode text, an additional description displayed under the barcode.
  /// Currently, a barcode can be a QR code or codabar.
  final String text;

  /// Barcode type, which can be qrCode or codabar.
  final String type;

  /// Barcode value.
  /// If no barcode value is specified, the cardNumber value will be used.
  /// If the cardNumber value is not specified, the organizationPassId value will be used.
  final String? value;

  const BarCode({
    required this.text,
    required this.type,
    required this.value,
  });

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'text': text,
      'type': type,
      'value': value,
    };
  }

  @override
  String toString() {
    return '$BarCode('
        'text: $text, '
        'type: $type, '
        'value: $value)';
  }
}
