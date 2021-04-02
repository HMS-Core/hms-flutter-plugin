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

import 'dart:convert' show json;
import 'dart:ui' show hashValues;

import 'TelPhoneNumber.dart';
import 'AddressInfo.dart';
import 'PeopleName.dart';
import 'EmailContent.dart';

class ContactDetail {
  ContactDetail({
    this.addressesInfos,
    this.company,
    this.contactLinks,
    this.eMailContents,
    this.note,
    this.peopleName,
    this.telPhoneNumbers,
    this.title,
  });

  List<AddressInfo> addressesInfos;
  String company;
  List<String> contactLinks;
  List<EmailContent> eMailContents;
  String note;
  PeopleName peopleName;
  List<TelPhoneNumber> telPhoneNumbers;
  String title;

  factory ContactDetail.fromJson(String str) =>
      ContactDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContactDetail.fromMap(Map<String, dynamic> json) => ContactDetail(
        addressesInfos: json["addressesInfos"] == null
            ? null
            : List<AddressInfo>.from(
                json["addressesInfos"].map((x) => AddressInfo.fromMap(x))),
        company: json["company"] == null ? null : json["company"],
        contactLinks: json["contactLinks"] == null
            ? null
            : List<String>.from(json["contactLinks"].map((x) => x)),
        eMailContents: json["eMailContents"] == null
            ? null
            : List<EmailContent>.from(
                json["eMailContents"].map((x) => EmailContent.fromMap(x))),
        note: json["note"] == null ? null : json["note"],
        peopleName: json["peopleName"] == null
            ? null
            : PeopleName.fromMap(json["peopleName"]),
        telPhoneNumbers: json["telPhoneNumbers"] == null
            ? null
            : List<TelPhoneNumber>.from(
                json["telPhoneNumbers"].map((x) => TelPhoneNumber.fromMap(x))),
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toMap() => {
        "addressesInfos": addressesInfos == null
            ? null
            : List<dynamic>.from(addressesInfos.map((x) => x.toMap())),
        "company": company == null ? null : company,
        "contactLinks": contactLinks == null
            ? null
            : List<dynamic>.from(contactLinks.map((x) => x)),
        "eMailContents": eMailContents == null
            ? null
            : List<dynamic>.from(eMailContents.map((x) => x.toMap())),
        "note": note == null ? null : note,
        "peopleName": peopleName == null ? null : peopleName.toMap(),
        "telPhoneNumbers": telPhoneNumbers == null
            ? null
            : List<dynamic>.from(telPhoneNumbers.map((x) => x.toMap())),
        "title": title == null ? null : title,
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    if (runtimeType != o.runtimeType) return false;
    final ContactDetail check = o;
    return o is ContactDetail &&
        check.addressesInfos == addressesInfos &&
        check.company == company &&
        check.contactLinks == contactLinks &&
        check.eMailContents == eMailContents &&
        check.note == note &&
        check.peopleName == peopleName &&
        check.telPhoneNumbers == telPhoneNumbers &&
        check.title == title;
  }

  @override
  int get hashCode => hashValues(
        addressesInfos,
        company,
        contactLinks,
        eMailContents,
        note,
        peopleName,
        telPhoneNumbers,
        title,
      );
}
