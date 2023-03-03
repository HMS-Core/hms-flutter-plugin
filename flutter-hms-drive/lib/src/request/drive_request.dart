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

class DriveRequest {
  String? fields;
  String? form;
  bool? prettyPrint;
  String? quotaId;
  Map<String, dynamic>? parameters;

  DriveRequest({
    this.fields,
    this.form,
    this.prettyPrint,
    this.quotaId,
    this.parameters,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fields': fields,
      'form': form,
      'prettyPrint': prettyPrint,
      'quotaId': quotaId,
      'parameters': parameters,
    }..removeWhere((String k, dynamic v) => v == null);
  }

  factory DriveRequest.fromMap(Map<String, dynamic> map) {
    return DriveRequest(
      fields: map['fields'],
      form: map['form'],
      prettyPrint: map['prettyPrint'],
      quotaId: map['quotaId'],
      parameters: map['paremeters'] != null
          ? Map<String, dynamic>.from(map['parameters'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DriveRequest.fromJson(String source) =>
      DriveRequest.fromMap(json.decode(source));
}
