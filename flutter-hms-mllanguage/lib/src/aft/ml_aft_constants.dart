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

class MLAftConstants {
  const MLAftConstants();

  /// Audio file transcription progress status.
  static ProgressStatus progressStatus = const ProgressStatus();

  /// Status of the transcription task, including the task ID and progress.
  static TaskMetadata metadata = const TaskMetadata();

  /// Mandarin Chinese.
  static const String LANGUAGE_ZH = 'zh';

  /// English (US).
  static const String LANGUAGE_EN_US = 'en-US';
}

class ProgressStatus {
  const ProgressStatus();

  /// Task initialization is complete.
  final int inited = 1;

  /// The transcription task has been completed.
  final int resulted = 4;

  /// The transcription task fails.
  final int transcriptFailed = 5;

  /// The transcription task is processing.
  final int transcripting = 3;

  /// A file is uploading.
  final int uploading = 2;
}

class TaskMetadata {
  const TaskMetadata();

  /// ID of the audio transcription task on the cloud.
  final String remoteTaskId = 'remoteTaskId';

  /// Audio transcription task progress status.
  final String taskStatus = 'taskStatus';
}
