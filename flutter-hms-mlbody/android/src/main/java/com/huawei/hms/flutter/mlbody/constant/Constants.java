/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.huawei.hms.flutter.mlbody.constant;

public interface Constants {
    String BASE_CHANNEL = "huawei.hms.flutter.ml.body";
    String APP_CHANNEL = BASE_CHANNEL + ".app";
    String FACE_CHANNEL = BASE_CHANNEL + ".face";
    String FACE_3D_CHANNEL = BASE_CHANNEL + ".face3d";
    String HAND_CHANNEL = BASE_CHANNEL + ".hand";
    String GESTURE_CHANNEL = BASE_CHANNEL + ".gesture";
    String SKELETON_CHANNEL = BASE_CHANNEL + ".skeleton";
    String VERIFICATION_CHANNEL = BASE_CHANNEL + ".verification";
    String LIVENESS_CHANNEL = BASE_CHANNEL + ".liveness";
    String INTERACTIVE_LIVENESS_CHANNEL = BASE_CHANNEL + ".interactiveLiveness";
    String LENS_CHANNEL = BASE_CHANNEL + ".lens";
    String NOT_INITIALIZED = "ml-body-001";

    String CUSTOMIIZED_CHANNEL = BASE_CHANNEL + ".customizedView";

    String CHANNEL_REMOTE_KEY = "channelRemoteId";
}
