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

class DriveChannel with ExtraParameter {
  String? url;
  String? id;
  String? category;
  String? resourceId;
  String? resourceUri;
  String? userToken;
  String? type;
  int? expirationTime;
  Map<String, String>? params;
  bool? payload;

  DriveChannel({
    this.url,
    this.id,
    this.category,
    this.resourceId,
    this.resourceUri,
    this.userToken,
    this.type,
    this.expirationTime,
    this.params,
    this.payload,
  });

  factory DriveChannel.fromMap(Map<String, dynamic> map) {
    return DriveChannel(
      url: map['url'],
      id: map['id'],
      category: map['category'],
      resourceId: map['resourceId'],
      resourceUri: map['resourceUri'],
      userToken: map['userToken'],
      type: map['type'],
      expirationTime: map['expirationTime'],
      params: map['params'] == null
          ? null
          : Map<String, String>.from(map['params']),
      payload: map['payload'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'id': id,
      'category': category,
      'resourceId': resourceId,
      'resourceUri': resourceUri,
      'userToken': userToken,
      'type': type,
      'expirationTime': expirationTime,
      'params': params,
      'payload': payload,
    };
  }

  factory DriveChannel.fromJson(String source) =>
      DriveChannel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'DriveChannel(url: $url, id: $id, category: $category, resourceId: $resourceId, resourceUri: $resourceUri, userToken: $userToken, type: $type, expirationTime: $expirationTime, params: $params, payload: $payload)';
  }
}
