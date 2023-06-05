/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_scan;

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

  List<AddressInfo?>? addressesInfos;
  String? company;
  List<String?>? contactLinks;
  List<EmailContent?>? eMailContents;
  String? note;
  PeopleName? peopleName;
  List<TelPhoneNumber?>? telPhoneNumbers;
  String? title;

  factory ContactDetail.fromJson(String str) {
    return ContactDetail.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory ContactDetail.fromMap(Map<String, dynamic> json) {
    return ContactDetail(
      addressesInfos: json['addressesInfos'] == null
          ? null
          : List<AddressInfo?>.from(
              json['addressesInfos'].map(
                (dynamic x) => x == null ? null : AddressInfo.fromMap(x),
              ),
            ),
      company: json['company'],
      contactLinks: json['contactLinks'] == null
          ? null
          : List<String?>.from(
              json['contactLinks'].map((dynamic x) => x),
            ),
      eMailContents: json['eMailContents'] == null
          ? null
          : List<EmailContent?>.from(
              json['eMailContents'].map(
                (dynamic x) => x == null ? null : EmailContent.fromMap(x),
              ),
            ),
      note: json['note'],
      peopleName: json['peopleName'] == null
          ? null
          : PeopleName.fromMap(json['peopleName']),
      telPhoneNumbers: json['telPhoneNumbers'] == null
          ? null
          : List<TelPhoneNumber?>.from(
              json['telPhoneNumbers'].map(
                (dynamic x) => x == null ? null : TelPhoneNumber.fromMap(x),
              ),
            ),
      title: json['title'],
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'addressesInfos': addressesInfos == null
            ? null
            : List<dynamic>.from(
                addressesInfos!.map((AddressInfo? x) => x?.toMap()),
              ),
        'company': company,
        'contactLinks': contactLinks == null
            ? null
            : List<dynamic>.from(contactLinks!.map((String? x) => x)),
        'eMailContents': eMailContents == null
            ? null
            : List<dynamic>.from(
                eMailContents!.map((EmailContent? x) => x?.toMap()),
              ),
        'note': note,
        'peopleName': peopleName == null ? null : peopleName!.toMap(),
        'telPhoneNumbers': telPhoneNumbers == null
            ? null
            : List<dynamic>.from(
                telPhoneNumbers!.map((TelPhoneNumber? x) => x?.toMap()),
              ),
        'title': title,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is ContactDetail &&
        listEquals(other.addressesInfos, addressesInfos) &&
        other.company == company &&
        listEquals(other.contactLinks, contactLinks) &&
        listEquals(other.eMailContents, eMailContents) &&
        other.note == note &&
        other.peopleName == peopleName &&
        listEquals(other.telPhoneNumbers, telPhoneNumbers) &&
        other.title == title;
  }

  @override
  int get hashCode {
    return Object.hash(
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
}
