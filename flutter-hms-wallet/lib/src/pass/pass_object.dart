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

import 'package:flutter/foundation.dart';
import 'package:huawei_wallet/huawei_wallet.dart';

class PassObject {
  String passTypeIdentifier;
  String passStyleIdentifier;
  String organizationPassId;
  String serialNumber;
  String currencyCode;
  PassStatus status;
  List<RelatedPassInfo> relatedPassIds;
  List<Location> locationList;
  BarCode barCode;
  List<CommonField> commonFields;
  List<AppendField> appendFields;
  List<AppendField> messageList;
  List<AppendField> imageList;
  List<AppendField> textList;
  List<AppendField> urlList;

  PassObject({
    this.passTypeIdentifier,
    this.currencyCode,
    this.urlList,
    this.passStyleIdentifier,
    this.organizationPassId,
    this.serialNumber,
    this.status,
    this.relatedPassIds,
    this.locationList,
    this.barCode,
    this.commonFields,
    this.appendFields,
    this.messageList,
    this.imageList,
    this.textList,
  });

  PassObject copyWith({
    String passTypeIdentifier,
    String currencyCode,
    List<AppendField> urlList,
    String passStyleIdentifier,
    String organizationPassId,
    String serialNumber,
    String status,
    List<RelatedPassInfo> relatedPassIds,
    List<Location> locationList,
    BarCode barCode,
    List<CommonField> commonField,
    List<AppendField> appendFields,
    List<AppendField> messageList,
    List<AppendField> imageList,
    List<AppendField> textList,
  }) {
    return PassObject(
      passTypeIdentifier: passTypeIdentifier ?? this.passTypeIdentifier,
      currencyCode: currencyCode ?? this.currencyCode,
      urlList: urlList ?? this.urlList,
      passStyleIdentifier: passStyleIdentifier ?? this.passStyleIdentifier,
      organizationPassId: organizationPassId ?? this.organizationPassId,
      serialNumber: serialNumber ?? this.serialNumber,
      status: status ?? this.status,
      relatedPassIds: relatedPassIds ?? this.relatedPassIds,
      locationList: locationList ?? this.locationList,
      barCode: barCode ?? this.barCode,
      commonFields: commonField ?? this.commonFields,
      appendFields: appendFields ?? this.appendFields,
      messageList: messageList ?? this.messageList,
      imageList: imageList ?? this.imageList,
      textList: textList ?? this.textList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'passTypeIdentifier': passTypeIdentifier,
      'passStyleIdentifier': passStyleIdentifier,
      'organizationPassId': organizationPassId,
      'serialNumber': serialNumber,
      // fields
      'fields': {
        'currencyCode': currencyCode,
        'urlList': urlList?.map((x) => x?.toMap())?.toList(),
        'status': status.toMap(),
        'relatedPassIds': relatedPassIds?.map((x) => x?.toMap())?.toList(),
        'locationList': locationList?.map((x) => x?.toMap())?.toList(),
        'barCode': barCode?.toMap(),
        'commonFields': commonFields?.map((x) => x?.toMap())?.toList(),
        'appendFields': appendFields?.map((x) => x?.toMap())?.toList(),
        'messageList': messageList?.map((x) => x?.toMap())?.toList(),
        'imageList': imageList?.map((x) => x?.toMap())?.toList(),
        'textList': textList?.map((x) => x?.toMap())?.toList(),
      },
      // additional items
      'formatVersion': '10.0',
    };
  }

  factory PassObject.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PassObject(
      passTypeIdentifier: map['passTypeIdentifier'],
      currencyCode: map['currencyCode'],
      urlList: List<AppendField>.from(
          map['urlList']?.map((x) => AppendField.fromMap(x)) ?? []),
      passStyleIdentifier: map['passStyleIdentifier'],
      organizationPassId: map['organizationPassId'],
      serialNumber: map['serialNumber'],
      status: PassStatus.fromMap(map['status']),
      relatedPassIds: List<RelatedPassInfo>.from(
          map['relatedPassIds']?.map((x) => RelatedPassInfo.fromMap(x)) ?? []),
      locationList: List<Location>.from(
          map['locationList']?.map((x) => Location.fromMap(x)) ?? []),
      barCode: BarCode.fromMap(map['barCode']),
      commonFields: List<CommonField>.from(
          map['commonFields']?.map((x) => CommonField.fromMap(x)) ?? []),
      appendFields: List<AppendField>.from(
          map['appendFields']?.map((x) => AppendField.fromMap(x)) ?? []),
      messageList: List<AppendField>.from(
          map['messageList']?.map((x) => AppendField.fromMap(x)) ?? []),
      imageList: List<AppendField>.from(
          map['imageList']?.map((x) => AppendField.fromMap(x)) ?? []),
      textList: List<AppendField>.from(
          map['textList']?.map((x) => AppendField.fromMap(x)) ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory PassObject.fromJson(String source) =>
      PassObject.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PassObject(passTypeIdentifier: $passTypeIdentifier, currencyCode: $currencyCode, urlList: $urlList, passStyleIdentifier: $passStyleIdentifier, organizationPassId: $organizationPassId, serialNumber: $serialNumber, status: $status, relatedPassIds: $relatedPassIds, locationList: $locationList, barCode: $barCode, commonField: $commonFields, appendFields: $appendFields, messageList: $messageList, imageList: $imageList, textList: $textList)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PassObject &&
        o.passTypeIdentifier == passTypeIdentifier &&
        o.currencyCode == currencyCode &&
        listEquals(o.urlList, urlList) &&
        o.passStyleIdentifier == passStyleIdentifier &&
        o.organizationPassId == organizationPassId &&
        o.serialNumber == serialNumber &&
        o.status == status &&
        listEquals(o.relatedPassIds, relatedPassIds) &&
        listEquals(o.locationList, locationList) &&
        o.barCode == barCode &&
        listEquals(o.commonFields, commonFields) &&
        listEquals(o.appendFields, appendFields) &&
        listEquals(o.messageList, messageList) &&
        listEquals(o.imageList, imageList) &&
        listEquals(o.textList, textList);
  }

  @override
  int get hashCode {
    return passTypeIdentifier.hashCode ^
        currencyCode.hashCode ^
        urlList.hashCode ^
        passStyleIdentifier.hashCode ^
        organizationPassId.hashCode ^
        serialNumber.hashCode ^
        status.hashCode ^
        relatedPassIds.hashCode ^
        locationList.hashCode ^
        barCode.hashCode ^
        commonFields.hashCode ^
        appendFields.hashCode ^
        messageList.hashCode ^
        imageList.hashCode ^
        textList.hashCode;
  }
}
