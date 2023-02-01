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

class PassObject {
  /// Type of a wallet pass.
  final String passTypeIdentifier;

  /// Style of a wallet pass, which can be a loyalty card, gift card, or coupon.
  final String passStyleIdentifier;

  /// ID of a wallet pass.
  final String organizationPassId;

  /// Serial number (SN) of a wallet pass, which uniquely identifies the pass on the server.
  /// Its value can be the same as passId.
  final String serialNumber;

  /// Currency code of a wallet pass.
  final String? currencyCode;

  /// Barcode or QR code.
  final BarCode barCode;

  /// Status of a wallet pass.
  final PassStatus status;

  /// Coupons linked to the wallet pass.
  final List<RelatedPassInfo> relatedPassIds;

  /// Geofence locations.
  final List<Location> locationList;

  /// CommonField objects for constructing a wallet pass.
  final List<CommonField> commonFields;

  /// AppendField objects for constructing a wallet pass.
  final List<AppendField> appendFields;

  /// Message objects for constructing a wallet pass.
  final List<AppendField> messageList;

  /// Images for ad rotation.
  final List<AppendField> imageList;

  /// List of text information.
  final List<AppendField> textList;

  /// URLs of a wallet pass.
  final List<AppendField> urlList;

  const PassObject({
    required this.passTypeIdentifier,
    required this.passStyleIdentifier,
    required this.organizationPassId,
    required this.serialNumber,
    required this.status,
    required this.barCode,
    this.currencyCode,
    this.urlList = const <AppendField>[],
    this.relatedPassIds = const <RelatedPassInfo>[],
    this.locationList = const <Location>[],
    this.commonFields = const <CommonField>[],
    this.appendFields = const <AppendField>[],
    this.messageList = const <AppendField>[],
    this.imageList = const <AppendField>[],
    this.textList = const <AppendField>[],
  });

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'passTypeIdentifier': passTypeIdentifier,
      'passStyleIdentifier': passStyleIdentifier,
      'organizationPassId': organizationPassId,
      'serialNumber': serialNumber,
      'currencyCode': currencyCode,
      'barCode': barCode._toMap(),
      'status': status._toMap(),
      'relatedPassIds': relatedPassIds.map((_) => _._toMap()).toList(),
      'locationList': locationList.map((_) => _._toMap()).toList(),
      'commonFields': commonFields.map((_) => _._toMap()).toList(),
      'appendFields': appendFields.map((_) => _._toMap()).toList(),
      'messageList': messageList.map((_) => _._toMap()).toList(),
      'imageList': imageList.map((_) => _._toMap()).toList(),
      'textList': textList.map((_) => _._toMap()).toList(),
      'urlList': urlList.map((_) => _._toMap()).toList(),
    };
  }

  @override
  String toString() {
    return '$PassObject('
        'passTypeIdentifier: $passTypeIdentifier, '
        'currencyCode: $currencyCode, '
        'urlList: $urlList, '
        'passStyleIdentifier: $passStyleIdentifier, '
        'organizationPassId: $organizationPassId, '
        'serialNumber: $serialNumber, '
        'status: $status, '
        'relatedPassIds: $relatedPassIds, '
        'locationList: $locationList, '
        'barCode: $barCode, '
        'commonField: $commonFields, '
        'appendFields: $appendFields, '
        'messageList: $messageList, '
        'imageList: $imageList, '
        'textList: $textList)';
  }
}
