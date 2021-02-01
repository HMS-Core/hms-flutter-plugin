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

class DrivePermission {
  bool canDiscoverFile;
  bool deleted;
  String displayName;
  DateTime expirationTime;
  String id;
  String category;
  String profilePhotoLink;
  String role;
  String type;
  String userAccount;
  String accountType;

  DrivePermission({
    this.canDiscoverFile,
    this.deleted,
    this.displayName,
    this.expirationTime,
    this.id,
    this.category,
    this.profilePhotoLink,
    this.role,
    this.type,
    this.userAccount,
    this.accountType,
  });

  DrivePermission clone({
    bool canDiscoverFile,
    bool deleted,
    String displayName,
    DateTime expirationTime,
    String id,
    String category,
    String profilePhotoLink,
    String role,
    String type,
    String userAccount,
    String accountType,
  }) {
    return DrivePermission(
      canDiscoverFile: canDiscoverFile ?? this.canDiscoverFile,
      deleted: deleted ?? this.deleted,
      displayName: displayName ?? this.displayName,
      expirationTime: expirationTime ?? this.expirationTime,
      id: id ?? this.id,
      category: category ?? this.category,
      profilePhotoLink: profilePhotoLink ?? this.profilePhotoLink,
      role: role ?? this.role,
      type: type ?? this.type,
      userAccount: userAccount ?? this.userAccount,
      accountType: accountType ?? this.accountType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'canDiscoverFile': canDiscoverFile,
      'deleted': deleted,
      'displayName': displayName,
      'expirationTime': expirationTime?.toIso8601String(),
      'id': id,
      'category': category,
      'profilePhotoLink': profilePhotoLink,
      'role': role,
      'type': type,
      'userAccount': userAccount,
      'accountType': accountType,
    };
  }

  factory DrivePermission.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DrivePermission(
      canDiscoverFile: map['canDiscoverFile'],
      deleted: map['deleted'],
      displayName: map['displayName'],
      expirationTime: map['expirationTime'] == null
          ? null
          : DateTime.parse(map['expirationTime']),
      id: map['id'],
      category: map['category'],
      profilePhotoLink: map['profilePhotoLink'],
      role: map['role'],
      type: map['type'],
      userAccount: map['userAccount'],
      accountType: map['accountType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DrivePermission.fromJson(String source) =>
      DrivePermission.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Permission(canDiscoverFile: $canDiscoverFile, deleted: $deleted, displayName: $displayName, expirationTime: $expirationTime, id: $id, category: $category, profilePhotoLink: $profilePhotoLink, role: $role, type: $type, userAccount: $userAccount, accountType: $accountType)';
  }
}
