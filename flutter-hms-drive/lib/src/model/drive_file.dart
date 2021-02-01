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

import 'package:huawei_drive/huawei_drive.dart';

class DriveFile with ExtraParameter {
  String category;
  String id;
  String fileName;
  int size;
  String mimeType;
  List<String> parentFolder;
  DateTime createdTime;
  DateTime editedTime;
  String description;
  List<DriveUser> owners;
  bool favorite;
  bool recycled;
  Map<String, String> appSettings;
  Map<String, String> properties;
  DriveCapabilities capabilities;
  ContentExtras contentExtras;
  bool writerHasCopyPermission;
  bool directlyRecycled;
  String fileSuffix;
  String fullFileSuffix;
  bool existThumbnail;
  String iconDownloadLink;
  PictureMetadata pictureMetadata;
  bool isAppAuthorized;
  DriveUser lastEditor;
  bool editedByMe;
  DateTime editedByMeTime;
  bool ownedByMe;
  List<String> permissionIds;
  List<DrivePermission> permissions;
  int occupiedSpace;
  String sha256;
  bool hasShared;
  DateTime sharedWithMeTime;
  DriveUser sharer;
  List<String> containers;
  String thumbnailDownloadLink;
  String smallThumbnailDownloadLink;
  DateTime recycledTime;
  DriveUser recyclingUser;
  VideoMetadata videoMetadata;
  String contentDownloadLink;
  bool writersHasSharePermission;
  String contentVersion;
  String lastHistoryVersionId;
  String originalFilename;
  int thumbnailVersion;
  int version;
  String onLineViewLink;

  DriveFile({
    this.category,
    this.id,
    this.fileName,
    this.size,
    this.mimeType,
    this.parentFolder,
    this.createdTime,
    this.editedTime,
    this.description,
    this.owners,
    this.favorite,
    this.recycled,
    this.appSettings,
    this.properties,
    this.capabilities,
    this.contentExtras,
    this.writerHasCopyPermission,
    this.directlyRecycled,
    this.fileSuffix,
    this.fullFileSuffix,
    this.existThumbnail,
    this.iconDownloadLink,
    this.pictureMetadata,
    this.isAppAuthorized,
    this.lastEditor,
    this.editedByMe,
    this.editedByMeTime,
    this.ownedByMe,
    this.permissionIds,
    this.permissions,
    this.occupiedSpace,
    this.sha256,
    this.hasShared,
    this.sharedWithMeTime,
    this.sharer,
    this.containers,
    this.thumbnailDownloadLink,
    this.smallThumbnailDownloadLink,
    this.recycledTime,
    this.recyclingUser,
    this.videoMetadata,
    this.contentDownloadLink,
    this.writersHasSharePermission,
    this.contentVersion,
    this.lastHistoryVersionId,
    this.originalFilename,
    this.thumbnailVersion,
    this.version,
    this.onLineViewLink,
  });

  DriveFile clone({
    String category,
    String id,
    String fileName,
    int size,
    String mimeType,
    List<String> parentFolder,
    DateTime createdTime,
    DateTime editedTime,
    String description,
    List<DriveUser> owners,
    bool favorite,
    bool recycled,
    Map<String, String> appSettings,
    Map<String, String> properties,
    DriveCapabilities capabilities,
    ContentExtras contentExtras,
    bool writerHasCopyPermission,
    bool directlyRecycled,
    String fileSuffix,
    String fullFileSuffix,
    bool existThumbnail,
    String iconDownloadLink,
    PictureMetadata pictureMetadata,
    bool isAppAuthorized,
    DriveUser lastEditor,
    bool editedByMe,
    DateTime editedByMeTime,
    bool ownedByMe,
    List<String> permissionIds,
    List<DrivePermission> permissions,
    int occupiedSpace,
    String sha256,
    bool hasShared,
    DateTime sharedWithMeTime,
    DriveUser sharer,
    List<String> containers,
    String thumbnailDownloadLink,
    String smallThumbnailDownloadLink,
    DateTime recycledTime,
    DriveUser recyclingUser,
    VideoMetadata videoMetadata,
    String contentDownloadLink,
    bool writersHasSharePermission,
    String contentVersion,
    String lastHistoryVersionId,
    String originalFilename,
    int thumbnailVersion,
    int version,
    String onLineViewLink,
  }) {
    return DriveFile(
      category: category ?? this.category,
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      size: size ?? this.size,
      mimeType: mimeType ?? this.mimeType,
      parentFolder: parentFolder ?? this.parentFolder,
      createdTime: createdTime ?? this.createdTime,
      editedTime: editedTime ?? this.editedTime,
      description: description ?? this.description,
      owners: owners ?? this.owners,
      favorite: favorite ?? this.favorite,
      recycled: recycled ?? this.recycled,
      appSettings: appSettings ?? this.appSettings,
      properties: properties ?? this.properties,
      capabilities: capabilities ?? this.capabilities,
      contentExtras: contentExtras ?? this.contentExtras,
      writerHasCopyPermission:
          writerHasCopyPermission ?? this.writerHasCopyPermission,
      directlyRecycled: directlyRecycled ?? this.directlyRecycled,
      fileSuffix: fileSuffix ?? this.fileSuffix,
      fullFileSuffix: fullFileSuffix ?? this.fullFileSuffix,
      existThumbnail: existThumbnail ?? this.existThumbnail,
      iconDownloadLink: iconDownloadLink ?? this.iconDownloadLink,
      pictureMetadata: pictureMetadata ?? this.pictureMetadata,
      isAppAuthorized: isAppAuthorized ?? this.isAppAuthorized,
      lastEditor: lastEditor ?? this.lastEditor,
      editedByMe: editedByMe ?? this.editedByMe,
      editedByMeTime: editedByMeTime ?? this.editedByMeTime,
      ownedByMe: ownedByMe ?? this.ownedByMe,
      permissionIds: permissionIds ?? this.permissionIds,
      permissions: permissions ?? this.permissions,
      occupiedSpace: occupiedSpace ?? this.occupiedSpace,
      sha256: sha256 ?? this.sha256,
      hasShared: hasShared ?? this.hasShared,
      sharedWithMeTime: sharedWithMeTime ?? this.sharedWithMeTime,
      sharer: sharer ?? this.sharer,
      containers: containers ?? this.containers,
      thumbnailDownloadLink:
          thumbnailDownloadLink ?? this.thumbnailDownloadLink,
      smallThumbnailDownloadLink:
          smallThumbnailDownloadLink ?? this.smallThumbnailDownloadLink,
      recycledTime: recycledTime ?? this.recycledTime,
      recyclingUser: recyclingUser ?? this.recyclingUser,
      videoMetadata: videoMetadata ?? this.videoMetadata,
      contentDownloadLink: contentDownloadLink ?? this.contentDownloadLink,
      writersHasSharePermission:
          writersHasSharePermission ?? this.writersHasSharePermission,
      contentVersion: contentVersion ?? this.contentVersion,
      lastHistoryVersionId: lastHistoryVersionId ?? this.lastHistoryVersionId,
      originalFilename: originalFilename ?? this.originalFilename,
      thumbnailVersion: thumbnailVersion ?? this.thumbnailVersion,
      version: version ?? this.version,
      onLineViewLink: onLineViewLink ?? this.onLineViewLink,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'id': id,
      'fileName': fileName,
      'size': size,
      'mimeType': mimeType,
      'parentFolder': parentFolder,
      'createdTime': createdTime?.toIso8601String(),
      'editedTime': editedTime?.toIso8601String(),
      'description': description,
      'owners': owners?.map((x) => x?.toMap())?.toList(),
      'favorite': favorite,
      'recycled': recycled,
      'appSettings': appSettings,
      'properties': properties,
      'capabilities': capabilities?.toMap(),
      'contentExtras': contentExtras?.toMap(),
      'writerHasCopyPermission': writerHasCopyPermission,
      'directlyRecycled': directlyRecycled,
      'fileSuffix': fileSuffix,
      'fullFileSuffix': fullFileSuffix,
      'existThumbnail': existThumbnail,
      'iconDownloadLink': iconDownloadLink,
      'pictureMetadata': pictureMetadata?.toMap(),
      'isAppAuthorized': isAppAuthorized,
      'lastEditor': lastEditor?.toMap(),
      'editedByMe': editedByMe,
      'editedByMeTime': editedByMeTime?.toIso8601String(),
      'ownedByMe': ownedByMe,
      'permissionIds': permissionIds,
      'permissions': permissions?.map((x) => x?.toMap())?.toList(),
      'occupiedSpace': occupiedSpace,
      'sha256': sha256,
      'hasShared': hasShared,
      'sharedWithMeTime': sharedWithMeTime?.toIso8601String(),
      'sharer': sharer?.toMap(),
      'containers': containers,
      'thumbnailDownloadLink': thumbnailDownloadLink,
      'smallThumbnailDownloadLink': smallThumbnailDownloadLink,
      'recycledTime': recycledTime?.toIso8601String(),
      'recyclingUser': recyclingUser?.toMap(),
      'videoMetadata': videoMetadata?.toMap(),
      'contentDownloadLink': contentDownloadLink,
      'writersHasSharePermission': writersHasSharePermission,
      'contentVersion': contentVersion,
      'lastHistoryVersionId': lastHistoryVersionId,
      'originalFilename': originalFilename,
      'thumbnailVersion': thumbnailVersion,
      'version': version,
      'onLineViewLink': onLineViewLink,
    };
  }

  factory DriveFile.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DriveFile(
      category: map['category'] == null ? null : map['category'],
      id: map['id'] == null ? null : map['id'],
      fileName: map['fileName'] == null ? null : map['fileName'],
      size: map['size'] == null ? null : map['size'],
      mimeType: map['mimeType'] == null ? null : map['mimeType'],
      parentFolder: map['parentFolder'] == null
          ? null
          : List<String>.from(map['parentFolder']),
      createdTime: map['createdTime'] == null
          ? null
          : DateTime.parse(map['createdTime']),
      editedTime:
          map['editedTime'] == null ? null : DateTime.parse(map['editedTime']),
      description: map['description'] == null ? null : map['description'],
      owners: map['owners'] == null
          ? null
          : List<DriveUser>.from(
              map['owners']?.map((x) => DriveUser.fromMap(x))),
      favorite: map['favorite'] == null ? null : map['favorite'],
      recycled: map['recycled'] == null ? null : map['recycled'],
      appSettings: map['appSettings'] == null
          ? null
          : Map<String, String>.from(map['appSettings']),
      properties: map['properties'] == null
          ? null
          : Map<String, String>.from(map['properties']),
      capabilities: map['capabilities'] == null
          ? null
          : DriveCapabilities.fromMap(map['capabilities']),
      contentExtras: map['contentExtras'] == null
          ? null
          : ContentExtras.fromMap(map['contentExtras']),
      writerHasCopyPermission: map['writerHasCopyPermission'] == null
          ? null
          : map['writerHasCopyPermission'],
      directlyRecycled:
          map['directlyRecycled'] == null ? null : map['directlyRecycled'],
      fileSuffix: map['fileSuffix'] == null ? null : map['fileSuffix'],
      fullFileSuffix:
          map['fullFileSuffix'] == null ? null : map['fullFileSuffix'],
      existThumbnail:
          map['existThumbnail'] == null ? null : map['existThumbnail'],
      iconDownloadLink:
          map['iconDownloadLink'] == null ? null : map['iconDownloadLink'],
      pictureMetadata: map['pictureMetadata'] == null
          ? null
          : PictureMetadata.fromMap(map['pictureMetadata']),
      isAppAuthorized:
          map['isAppAuthorized'] == null ? null : map['isAppAuthorized'],
      lastEditor: map['lastEditor'] == null
          ? null
          : DriveUser.fromMap(map['lastEditor']),
      editedByMe: map['editedByMe'] == null ? null : map['editedByMe'],
      editedByMeTime: map['editedByMeTime'] == null
          ? null
          : DateTime.parse(map['editedByMeTime']),
      ownedByMe: map['ownedByMe'] == null ? null : map['ownedByMe'],
      permissionIds: map['permissionIds'] == null
          ? null
          : List<String>.from(map['permissionIds']),
      permissions: map['permissions'] == null
          ? null
          : List<DrivePermission>.from(
              map['permissions']?.map((x) => DrivePermission.fromMap(x))),
      occupiedSpace: map['occupiedSpace'] == null ? null : map['occupiedSpace'],
      sha256: map['sha256'] == null ? null : map['sha256'],
      hasShared: map['hasShared'] == null ? null : map['hasShared'],
      sharedWithMeTime: map['sharedWithMeTime'] == null
          ? null
          : DateTime.parse(map['sharedWithMeTime']),
      sharer: map['sharer'] == null ? null : DriveUser.fromMap(map['sharer']),
      containers: map['containers'] == null
          ? null
          : List<String>.from(map['containers']),
      thumbnailDownloadLink: map['thumbnailDownloadLink'] == null
          ? null
          : map['thumbnailDownloadLink'],
      smallThumbnailDownloadLink: map['smallThumbnailDownloadLink'] == null
          ? null
          : map['smallThumbnailDownloadLink'],
      recycledTime: map['recycledTime'] == null
          ? null
          : DateTime.parse(map['recycledTime']),
      recyclingUser: map['recyclingUser'] == null
          ? null
          : DriveUser.fromMap(map['recyclingUser']),
      videoMetadata: map['videoMetadata'] == null
          ? null
          : VideoMetadata.fromMap(map['videoMetadata']),
      contentDownloadLink: map['contentDownloadLink'] == null
          ? null
          : map['contentDownloadLink'],
      writersHasSharePermission: map['writersHasSharePermission'] == null
          ? null
          : map['writersHasSharePermission'],
      contentVersion:
          map['contentVersion'] == null ? null : map['contentVersion'],
      lastHistoryVersionId: map['lastHistoryVersionId'] == null
          ? null
          : map['lastHistoryVersionId'],
      originalFilename:
          map['originalFilename'] == null ? null : map['originalFilename'],
      thumbnailVersion:
          map['thumbnailVersion'] == null ? null : map['thumbnailVersion'],
      version: map['version'] == null ? null : map['version'],
      onLineViewLink:
          map['onLineViewLink'] == null ? null : map['onLineViewLink'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DriveFile.fromJson(String source) =>
      DriveFile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'File(category: $category, id: $id, fileName: $fileName, size: $size, mimeType: $mimeType, parentFolder: $parentFolder, createdTime: $createdTime, editedTime: $editedTime, description: $description, owners: $owners, favorite: $favorite, recycled: $recycled, appSettings: $appSettings, properties: $properties, capabilities: $capabilities, contentExtras: $contentExtras, writerHasCopyPermission: $writerHasCopyPermission, directlyRecycled: $directlyRecycled, fileSuffix: $fileSuffix, fullFileSuffix: $fullFileSuffix, existThumbnail: $existThumbnail, iconDownloadLink: $iconDownloadLink, pictureMetadata: $pictureMetadata, isAppAuthorized: $isAppAuthorized, lastEditor: $lastEditor, editedByMe: $editedByMe, editedByMeTime: $editedByMeTime, ownedByMe: $ownedByMe, permissionIds: $permissionIds, permissions: $permissions, occupiedSpace: $occupiedSpace, sha256: $sha256, hasShared: $hasShared, sharedWithMeTime: $sharedWithMeTime, sharer: $sharer, containers: $containers, thumbnailDownloadLink: $thumbnailDownloadLink, smallThumbnailDownloadLink: $smallThumbnailDownloadLink, recycledTime: $recycledTime, recyclingUser: $recyclingUser, videoMetadata: $videoMetadata, contentDownloadLink: $contentDownloadLink, writersHasSharePermission: $writersHasSharePermission, contentVersion: $contentVersion, lastHistoryVersionId: $lastHistoryVersionId, originalFilename: $originalFilename, thumbnailVersion: $thumbnailVersion, version: $version, onLineViewLink: $onLineViewLink)';
  }
}
