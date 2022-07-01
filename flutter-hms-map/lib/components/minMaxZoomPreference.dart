/*
    Copyright 2020-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

class MinMaxZoomPreference {
  final double minZoom;
  final double maxZoom;

  const MinMaxZoomPreference(this.minZoom, this.maxZoom);

  static const MinMaxZoomPreference unbounded = MinMaxZoomPreference(3, 20);

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is MinMaxZoomPreference &&
        this.minZoom == other.minZoom &&
        this.maxZoom == other.maxZoom;
  }

  @override
  int get hashCode => Object.hash(minZoom, maxZoom);
}
