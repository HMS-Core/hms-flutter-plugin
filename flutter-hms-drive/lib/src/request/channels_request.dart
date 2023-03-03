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

class ChannelsRequest extends Batchable implements DriveRequest {
  @override
  String? fields;

  @override
  String? form;

  @override
  Map<String, dynamic>? parameters;

  @override
  bool? prettyPrint;

  @override
  String? quotaId;

  DriveChannel? channel;

  ChannelsRequest._({
    this.channel,
    this.fields,
    this.form,
    this.parameters,
    this.prettyPrint,
    this.quotaId,
  }) : super('Channels#Unknown');

  ChannelsRequest.stop(
    this.channel, {
    this.fields,
    this.form,
    this.parameters,
    this.prettyPrint,
    this.quotaId,
  }) : super('Channels#Stop');

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestName': requestName,
      'fields': fields,
      'form': form,
      'parameters': parameters,
      'prettyPrint': prettyPrint,
      'quotaId': quotaId,
      'channel': channel?.toMap(),
    };
  }

  factory ChannelsRequest.fromMap(Map<String, dynamic> map) {
    return ChannelsRequest._(
      fields: map['fields'],
      form: map['form'],
      parameters: Map<String, dynamic>.from(map['parameters']),
      prettyPrint: map['prettyPrint'],
      quotaId: map['quotaId'],
      channel: DriveChannel.fromMap(map['channel']),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ChannelsRequest.fromJson(String source) =>
      ChannelsRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Channels(fields: $fields, form: $form, parameters: $parameters, prettyPrint: $prettyPrint, quotaId: $quotaId, channel: $channel)';
  }
}
