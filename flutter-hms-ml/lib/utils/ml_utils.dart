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

enum MLFrameType {
  fromBitmap,
  fromFilePath,
  fromByteArray,
  fromByteBuffer,
  fromMediaImage,
  fromCreator
}

enum MLCompositeAnalyzerOption {
  FACE_ANALYZER,
  HAND_ANALYZER,
  SKELETON_ANALYZER,
  TEXT_ANALYZER,
  OBJECT_ANALYZER,
  CLASSIFICATION_ANALYZER
}

enum LensEngineAnalyzerOptions {
  FACE,
  FACE_3D,
  MAX_SIZE_FACE,
  HAND,
  SKELETON,
  CLASSIFICATION,
  TEXT,
  OBJECT,
  SCENE
}
