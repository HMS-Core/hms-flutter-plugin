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

part of materialgen;

/// Result codes related to material generation.
abstract class Modeling3dTextureErrors {
  /// Invalid parameter.
  static const int ERR_ILLEGAL_PARAMETER = 1200;

  /// Authentication failed.
  static const int ERR_AUTHORIZE_FAILED = 1201;

  /// The access token is invalid or has expired.
  static const int ERR_ILLEGAL_TOKEN = 1202;

  /// The data processing location is not set.
  static const int ERR_DATA_PROCESSING_LOCATION_NOT_SET = 1203;

  /// The task does not exist.
  static const int ERR_TASKID_NOT_EXISTED = 1204;

  /// Invalid task status.
  static const int ERR_ILLEGAL_TASK_STATUS = 1205;

  /// Server error.
  static const int ERR_SERVICE_EXCEPTION = 1206;

  /// The period for storing the generated texture maps has expired.
  static const int ERR_TASK_EXPIRED = 1207;

  /// The number of API calls exceeds the maximum.
  static const int ERR_RET_OVER_MAX_LIMIT = 1208;

  /// The task is restricted.
  static const int ERR_TASK_RESTRICTED = 1209;

  /// Unsupported image format.
  static const int ERR_IMAGE_FILE_NOTSUPPORTED = 1210;

  /// The number of images exceeds the maximum.
  static const int ERR_FILE_NUM_OVERFLOW = 1211;

  /// The total image file size is too large.
  static const int ERR_FILE_SIZE_OVERFLOW = 1212;

  /// The image file does not exist.
  static const int ERR_FILE_NOT_FOUND = 1213;

  /// Unsupported input image resolution.
  static const int ERR_IMAGE_RESOLUTION_NOTSUPPORTED = 1214;

  /// The generation engine is busy.
  static const int ERR_ENGINE_BUSY = 1220;

  /// Network connection error.
  static const int ERR_NETCONNECT_FAILED = 1221;

  /// Task initialization failed.
  static const int ERR_TASK_INIT_FAILED = 1222;

  /// The task is being executed and cannot be submitted again.
  static const int ERR_TASKID_ALREADY_INPROGRESS = 1223;

  /// File upload failed.
  static const int ERR_UPLOAD_FILE_FAILED = 1224;

  /// Query failed.
  static const int ERR_QUERY_FAILED = 1225;

  /// Insufficient device storage space.
  static const int ERR_INSUFFICIENT_SPACE = 1226;

  /// Download failed.
  static const int ERR_DOWNLOAD_FAILED = 1227;

  /// Failed to cancel the upload.
  static const int ERR_UPLOAD_CANCEL_FAILED = 1228;

  /// Failed to cancel the download.
  static const int ERR_DOWNLOAD_CANCEL_FAILED = 1229;

  /// Failed to preview the generated texture maps.
  static const int ERR_MODEL_PREVIEW_FAILED = 1230;

  /// Failed to delete the uploaded files from the cloud.
  static const int ERR_DELETE_REMOTE_TASK_FAILED = 1231;

  /// Internal error.
  static const int ERR_INTERNAL = 1298;

  /// Unknown error.
  static const int ERR_UNKNOWN = 1299;
}
