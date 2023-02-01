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

part of huawei_wallet;

/// Links coupon information to a loyalty card object.
class RelatedPassInfo {
  /// Type of a coupon, which is indicated by passTypeIdentifier of PassObject.
  final String typeId;

  /// ID of a coupon, which is indicated by organizationPassId of PassObject.
  final String id;

  const RelatedPassInfo({
    required this.typeId,
    required this.id,
  });

  Map<String, dynamic> _toMap() {
    return <String, dynamic>{
      'typeId': typeId,
      'id': id,
    };
  }

  @override
  String toString() {
    return '$RelatedPassInfo('
        'typeId: $typeId, '
        'id: $id)';
  }
}
