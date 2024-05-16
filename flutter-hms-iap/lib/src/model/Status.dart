/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

part of huawei_iap;

class Status {
  int? statusCode;
  String? statusMessage;
  Status? status;

  Status({
    this.statusCode,
    this.statusMessage,
    this.status,
  });

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        statusCode: json['statusCode'],
        statusMessage:
            json['statusMessage'] == null ? null : json['statusMessage'],
        status:
            json['status'] == null ? null : new Status.fromMap(json['status']),
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['statusMessage'] = this.statusMessage;
    if (this.status != null) {
      data['status'] = this.status!.toMap();
    }
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is Status &&
        this.statusCode == other.statusCode &&
        this.statusMessage == other.statusMessage &&
        this.status == other.status;
  }

  @override
  int get hashCode => Object.hash(
        statusCode,
        statusMessage,
        status,
      );
}
