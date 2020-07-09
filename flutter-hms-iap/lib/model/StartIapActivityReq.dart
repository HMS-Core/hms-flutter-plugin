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
class StartIapActivityReq {
  static const int TYPE_SUBSCRIBE_MANAGER_ACTIVITY = 2;
  static const int TYPE_SUBSCRIBE_EDIT_ACTIVITY = 3;

  int type;
  String productId;

  StartIapActivityReq({
    this.type,
    this.productId,
  });

  StartIapActivityReq.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['productId'] = this.productId != null ? this.productId : null;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {"type": type, "productId": productId};
  }
}
