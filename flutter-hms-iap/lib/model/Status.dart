/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/
class Status {
  int statusCode;
  String statusMessage;
  Status status;

  Status({
    this.statusCode,
    this.statusMessage,
    this.status,
  });

  Status.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage =
        json['statusMessage'] != null ? json['statusMessage'] : null;
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['statusMessage'] = this.statusMessage;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    return data;
  }
}
