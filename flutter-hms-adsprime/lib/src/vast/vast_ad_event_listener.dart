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

part of '../../huawei_adsprime.dart';

class VastAdEventListener {
  void Function(int i)? onPlayStateChanged;
  void Function(double v)? onVolumeChanged;
  void Function(int i)? onScreenViewChanged;
  void Function(int l, int l1, int l2)? onProgressChanged;
  void Function(int i)? onSuccess;
  void Function(int i)? onFailed;
  void Function()? playAdReady;
  void Function()? playAdFinish;
  void Function(int errorCode)? playAdError;
  void Function()? onBufferStart;
  void Function()? onBufferEnd;

  VastAdEventListener({
    this.onPlayStateChanged,
    this.onVolumeChanged,
    this.onScreenViewChanged,
    this.onProgressChanged,
    this.onSuccess,
    this.onFailed,
    this.playAdReady,
    this.playAdFinish,
    this.playAdError,
    this.onBufferStart,
    this.onBufferEnd,
  });
}
