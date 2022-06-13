/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

class MLImageClassification {
  String? classificationIdentity;
  String? name;
  dynamic possibility;

  MLImageClassification({
    this.classificationIdentity,
    this.name,
    this.possibility,
  });

  factory MLImageClassification.fromJson(Map<String, dynamic> json) {
    return MLImageClassification(
      classificationIdentity: json['classificationIdentity'] ?? null,
      name: json['name'] ?? null,
      possibility: json['possibility'] ?? null,
    );
  }

  factory MLImageClassification.fromTransaction(Map<dynamic, dynamic> map) {
    return MLImageClassification(
      classificationIdentity: map['classificationIdentity'] ?? null,
      name: map['name'] ?? null,
      possibility: map['possibility'] ?? null,
    );
  }
}
