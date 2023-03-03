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

import 'dart:convert';

import 'package:huawei_drive/huawei_drive.dart';

class DriveFile with ExtraParameter {
  String? category;
  String? id;
  String? fileName;
  int? size;
  String? mimeType;
  List<String>? parentFolder;
  DateTime? createdTime;
  DateTime? editedTime;
  String? description;
  List<DriveUser>? owners;
  bool? favorite;
  bool? recycled;
  Map<String, String>? appSettings;
  Map<String, String>? properties;
  DriveCapabilities? capabilities;
  ContentExtras? contentExtras;
  bool? writerHasCopyPermission;
  bool? directlyRecycled;
  String? fileSuffix;
  String? fullFileSuffix;
  bool? existThumbnail;
  String? iconDownloadLink;
  PictureMetadata? pictureMetadata;
  bool? isAppAuthorized;
  DriveUser? lastEditor;
  bool? editedByMe;
  DateTime? editedByMeTime;
  bool? ownedByMe;
  List<String>? permissionIds;
  List<DrivePermission>? permissions;
  int? occupiedSpace;
  String? sha256;
  bool? hasShared;
  DateTime? sharedWithMeTime;
  DriveUser? sharer;
  List<String>? containers;
  String? thumbnailDownloadLink;
  String? smallThumbnailDownloadLink;
  DateTime? recycledTime;
  DriveUser? recyclingUser;
  VideoMetadata? videoMetadata;
  String? contentDownloadLink;
  bool? writersHasSharePermission;
  String? contentVersion;
  String? lastHistoryVersionId;
  String? originalFilename;
  int? thumbnailVersion;
  int? version;
  String? onLineViewLink;

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

  factory DriveFile.fromMap(Map<String, dynamic> map) {
    return DriveFile(
      category: map['category'],
      id: map['id'],
      fileName: map['fileName'],
      size: map['size'],
      mimeType: map['mimeType'],
      parentFolder: map['parentFolder'] == null
          ? null
          : List<String>.from(map['parentFolder']),
      createdTime: map['createdTime'] == null
          ? null
          : DateTime.parse(map['createdTime']),
      editedTime:
          map['editedTime'] == null ? null : DateTime.parse(map['editedTime']),
      description: map['description'],
      owners: map['owners'] == null
          ? null
          : List<DriveUser>.from(
              map['owners']?.map(
                (dynamic x) => DriveUser.fromMap(x),
              ),
            ),
      favorite: map['favorite'],
      recycled: map['recycled'],
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
      writerHasCopyPermission: map['writerHasCopyPermission'],
      directlyRecycled: map['directlyRecycled'],
      fileSuffix: map['fileSuffix'],
      fullFileSuffix: map['fullFileSuffix'],
      existThumbnail: map['existThumbnail'],
      iconDownloadLink: map['iconDownloadLink'],
      pictureMetadata: map['pictureMetadata'] == null
          ? null
          : PictureMetadata.fromMap(map['pictureMetadata']),
      isAppAuthorized: map['isAppAuthorized'],
      lastEditor: map['lastEditor'] == null
          ? null
          : DriveUser.fromMap(map['lastEditor']),
      editedByMe: map['editedByMe'],
      editedByMeTime: map['editedByMeTime'] == null
          ? null
          : DateTime.parse(map['editedByMeTime']),
      ownedByMe: map['ownedByMe'],
      permissionIds: map['permissionIds'] == null
          ? null
          : List<String>.from(map['permissionIds']),
      permissions: map['permissions'] == null
          ? null
          : List<DrivePermission>.from(
              map['permissions']?.map(
                (Map<String, dynamic> x) => DrivePermission.fromMap(x),
              ),
            ),
      occupiedSpace: map['occupiedSpace'],
      sha256: map['sha256'],
      hasShared: map['hasShared'],
      sharedWithMeTime: map['sharedWithMeTime'] == null
          ? null
          : DateTime.parse(map['sharedWithMeTime']),
      sharer: map['sharer'] == null ? null : DriveUser.fromMap(map['sharer']),
      containers: map['containers'] == null
          ? null
          : List<String>.from(map['containers']),
      thumbnailDownloadLink: map['thumbnailDownloadLink'],
      smallThumbnailDownloadLink: map['smallThumbnailDownloadLink'],
      recycledTime: map['recycledTime'] == null
          ? null
          : DateTime.parse(map['recycledTime']),
      recyclingUser: map['recyclingUser'] == null
          ? null
          : DriveUser.fromMap(map['recyclingUser']),
      videoMetadata: map['videoMetadata'] == null
          ? null
          : VideoMetadata.fromMap(map['videoMetadata']),
      contentDownloadLink: map['contentDownloadLink'],
      writersHasSharePermission: map['writersHasSharePermission'],
      contentVersion: map['contentVersion'],
      lastHistoryVersionId: map['lastHistoryVersionId'],
      originalFilename: map['originalFilename'],
      thumbnailVersion: map['thumbnailVersion'],
      version: map['version'],
      onLineViewLink: map['onLineViewLink'],
    );
  }

  factory DriveFile.fromJson(String source) =>
      DriveFile.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'id': id,
      'fileName': fileName,
      'size': size,
      'mimeType': mimeType,
      'parentFolder': parentFolder,
      'createdTime': createdTime?.toIso8601String(),
      'editedTime': editedTime?.toIso8601String(),
      'description': description,
      'owners': owners?.map((DriveUser x) => x.toMap()).toList(),
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
      'permissions':
          permissions?.map((DrivePermission x) => x.toMap()).toList(),
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

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'File(category: $category, id: $id, fileName: $fileName, size: $size, mimeType: $mimeType, parentFolder: $parentFolder, createdTime: $createdTime, editedTime: $editedTime, description: $description, owners: $owners, favorite: $favorite, recycled: $recycled, appSettings: $appSettings, properties: $properties, capabilities: $capabilities, contentExtras: $contentExtras, writerHasCopyPermission: $writerHasCopyPermission, directlyRecycled: $directlyRecycled, fileSuffix: $fileSuffix, fullFileSuffix: $fullFileSuffix, existThumbnail: $existThumbnail, iconDownloadLink: $iconDownloadLink, pictureMetadata: $pictureMetadata, isAppAuthorized: $isAppAuthorized, lastEditor: $lastEditor, editedByMe: $editedByMe, editedByMeTime: $editedByMeTime, ownedByMe: $ownedByMe, permissionIds: $permissionIds, permissions: $permissions, occupiedSpace: $occupiedSpace, sha256: $sha256, hasShared: $hasShared, sharedWithMeTime: $sharedWithMeTime, sharer: $sharer, containers: $containers, thumbnailDownloadLink: $thumbnailDownloadLink, smallThumbnailDownloadLink: $smallThumbnailDownloadLink, recycledTime: $recycledTime, recyclingUser: $recyclingUser, videoMetadata: $videoMetadata, contentDownloadLink: $contentDownloadLink, writersHasSharePermission: $writersHasSharePermission, contentVersion: $contentVersion, lastHistoryVersionId: $lastHistoryVersionId, originalFilename: $originalFilename, thumbnailVersion: $thumbnailVersion, version: $version, onLineViewLink: $onLineViewLink)';
  }
}
