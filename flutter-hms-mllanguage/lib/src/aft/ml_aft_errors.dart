/*
    Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.

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

part of '../../huawei_ml_language.dart';

abstract class MLAftErrors {
  /// Audio file format unsupported.
  static const int ERR_AUDIO_FILE_NOTSUPPORTED = 11101;

  /// Too large audio file size.
  static const int ERR_AUDIO_FILE_SIZE_OVERFLOW = 11103;

  /// Audio file initialization failed.
  static const int ERR_AUDIO_INIT_FAILED = 11112;

  /// Too long audio duration.
  static const int ERR_AUDIO_LENGTH_OVERFLOW = 11104;

  /// Failed to transcript the audio file.
  static const int ERR_AUDIO_TRANSCRIPT_FAILED = 11111;

  /// Failed to upload the audio file.
  static const int ERR_AUDIO_UPLOAD_FAILED = 11113;

  /// Authentication failed.
  static const int ERR_AUTHORIZE_FAILED = 11119;

  /// The transcription engine is busy.
  static const int ERR_ENGINE_BUSY = 11107;

  /// The audio file does not exist.
  static const int ERR_FILE_NOT_FOUND = 11105;

  /// Invalid parameter.
  static const int ERR_ILLEGAL_PARAMETER = 11106;

  /// Internal error.
  static const int ERR_INTERNAL = 11198;

  /// Unsupported language.
  static const int ERR_LANGUAGE_CODE_NOTSUPPORTED = 11102;

  /// Abnormal network connection.
  static const int ERR_NETCONNECT_FAILED = 11108;

  /// Insufficient device storage space.
  static const int ERR_NO_ENOUGH_STORAGE = 11115;

  /// The transcription result cannot be obtained during upload.
  static const int ERR_RESULT_WHEN_UPLOADING = 11109;

  /// A subscribed service is in arrears.
  static const int ERR_SERVICE_CREDIT = 11122;

  /// You have not subscribed to the service.
  static const int ERR_SERVICE_UNSUBSCRIBED = 11123;

  /// Free quota of a service is used up.
  static const int ERR_SERVICE_FREE_USED_UP = 11124;

  /// The task is being executed and cannot be submitted.
  static const int ERR_TASK_ALREADY_INPROGRESS = 11114;

  /// The transcription task does not exist.
  static const int ERR_TASK_NOT_EXISTED = 11110;

  /// Unknown error.
  static const int ERR_UNKNOWN = 11199;
}
