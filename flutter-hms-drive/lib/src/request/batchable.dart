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

/// The abstract class that defines a Batchable Drive Request.
abstract class Batchable {
  /// Request type that describes a DriveRequest with its service name and method name
  /// concatenated with a `#`.
  String requestName;

  /// Returns the map representation of a Batchable instance.
  Map<String, dynamic> toMap();

  /// Returns a json representation of a Batchable instance.
  String toJson();

  /// Default constructor.
  Batchable(this.requestName);
}
