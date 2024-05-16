/*
    Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_awareness;

abstract class _Channel {
  static const String awarenessCaptureChannel =
      'com.huawei.hms.flutter.awareness/capture';
  static const String awarenessBarrierChannel =
      'com.huawei.hms.flutter.awareness/barrier';
  static const String awarenessBarrierEventChannel =
      'com.huawei.hms.flutter.awareness/barrierListener';
  static const String awarenessUtilsChannel =
      'com.huawei.hms.flutter.awareness/utils';
}
