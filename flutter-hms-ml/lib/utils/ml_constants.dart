/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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

class MlConstants {
  /// Plugin error codes
  static const String CANCELLED = "1";
  static const String DENIED = "2";
  static const String ILLEGAL_PARAMETER = "5";
  static const String NULL_OBJECT = "4";
  static const String UNINITIALIZED_ANALYZER = "000";

  /// Common error codes
  static const int UNKNOWN = -1;
  static const int SUCCESS = 0;
  static const int DISCARDED = 1;
  static const int INNER = 2;
  static const int INACTIVE = 3;
  static const int NOT_SUPPORTED = 4;
  static const int OVERDUE = 6;
  static const int NO_FOUND = 7;
  static const int DUPLICATE_FOUND = 8;
  static const int NO_PERMISSION = 9;
  static const int INSUFFICIENT_RESOURCE = 10;
  static const int ANALYSIS_FAILURE = 11;
  static const int INTERRUPTED = 12;
  static const int EXCEED_RANGE = 13;
  static const int DATA_MISSING = 14;
  static const int AUTHENTICATION_REQUIRED = 15;
  static const int TFLITE_NOT_COMPATIBLE = 16;
  static const int INSUFFICIENT_SPACE = 17;
  static const int HASH_MISS = 18;
  static const int TOKEN_INVALID = 19;
}
