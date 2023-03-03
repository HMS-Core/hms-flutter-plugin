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

import 'package:huawei_drive/src/request/batchable.dart';

class BatchRequest {
  List<Batchable> driveRequests;

  BatchRequest(
    this.driveRequests,
  );

  BatchRequest clone({
    required List<Batchable> driveRequests,
  }) {
    return BatchRequest(
      driveRequests,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'driveRequests': driveRequests.map((Batchable x) => x.toMap()).toList(),
    }..removeWhere((String k, dynamic v) => v == null);
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'BatchRequest(driveRequests: $driveRequests)';
}
