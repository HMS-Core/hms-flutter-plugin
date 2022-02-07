/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

class MLTtsSpeaker {
  String? language;
  String? name;
  String? modelSize;
  String? speakerDesc;

  MLTtsSpeaker({
    this.language,
    this.name,
    this.modelSize,
    this.speakerDesc,
  });

  factory MLTtsSpeaker.fromMap(Map<dynamic, dynamic> map) {
    return MLTtsSpeaker(
      language: map['language'] ?? null,
      name: map['name'] ?? null,
      modelSize: map['modelSize'] ?? null,
      speakerDesc: map['speakerDesc'] ?? null,
    );
  }
}
