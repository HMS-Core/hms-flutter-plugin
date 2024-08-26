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

part of '../../huawei_ads.dart';

class VideoConfiguration {
  /// Audio focus type.
  AudioFocusType? audioFocusType;

  /// Indicates whether to use a custom video control for a video ad.
  ///
  /// After the setting, you can check the value of the `customizeOperationRequested` field for verification. Then, using the [VideoOperator] class, you can call `play()`, `pause()`, and `mute(bool)` methods to control video ad playback.
  bool? customizeOperationRequested;

  /// Indicates whether to mute a video initially.
  ///
  /// `True` is returned if a video is initially muted; `false` otherwise.
  bool? startMuted;

  /// Type of the network allowed for automatic video playback.
  AutoPlayNetwork? autoPlayNetwork;

  VideoConfiguration({
    this.audioFocusType,
    this.customizeOperationRequested,
    this.startMuted,
    this.autoPlayNetwork,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'audioFocusType': audioFocusType?.index,
      'customizeOperationRequested': customizeOperationRequested,
      'startMuted': startMuted,
      'autoPlayNetwork': autoPlayNetwork?.index,
    }..removeWhere((_, dynamic v) => v == null);
  }
}

enum AutoPlayNetwork {
  /// Allowed only on Wi-Fi
  wifiOnly,

  /// Allowed on both Wi-Fi and mobile data
  bothWifiAndData,

  /// Forbidden regardless of the network type
  forbidAutoPlay,
}

enum AudioFocusType {
  /// Obtains the audio focus when a video is played, no matter whether the video is muted
  gainAudioFocusAll,

  /// Does not obtain the audio focus when a video is played, no matter whether the video is muted.
  notGainAudioFocusWhenMute,

  /// Obtains the audio focus only when a video is played without being muted.
  notGainAudioFocusAll,
}
