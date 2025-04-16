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

class VideoOperator {
  // This has to be a method channel of a native ad controller.
  final MethodChannel? _nativeChannel;
  VideoLifecycleListener? _listener;

  VideoOperator(this._nativeChannel);

  VideoLifecycleListener? get getVideoLifecycleListener => _listener;

  set setVideoLifecycleListener(VideoLifecycleListener listener) {
    _listener = listener;
  }

  Future<double?> getAspectRatio() async {
    if (_nativeChannel == null) {
      debugPrint('ERROR: MethodChannel is null');
      return -1;
    }
    double? aspectRatio = await _nativeChannel!.invokeMethod(
      'getAspectRatio',
    );
    return aspectRatio;
  }

  Future<bool?> hasVideo() async {
    if (_nativeChannel == null) {
      debugPrint('ERROR: MethodChannel is null');
      return false;
    }
    bool? hasVideo = await _nativeChannel!.invokeMethod(
      'hasVideo',
    );
    return hasVideo;
  }

  Future<bool?> isCustomizeOperateEnabled() async {
    if (_nativeChannel == null) {
      debugPrint('ERROR: MethodChannel is null');
      return false;
    }
    bool? customEnabled = await _nativeChannel!.invokeMethod(
      'isCustomOperateEnabled',
    );
    return customEnabled;
  }

  Future<bool?> isMuted() async {
    if (_nativeChannel == null) {
      debugPrint('ERROR: MethodChannel is null');
      return false;
    }
    bool? isMuted = await _nativeChannel!.invokeMethod(
      'isMuted',
    );
    return isMuted;
  }

  Future<bool?> mute(bool mute) async {
    if (_nativeChannel == null) {
      debugPrint('ERROR: MethodChannel is null');
      return false;
    }
    bool? muted = await _nativeChannel!.invokeMethod(
      'mute',
      <String, dynamic>{
        'mute': mute,
      },
    );
    return muted;
  }

  Future<bool?> pause() async {
    if (_nativeChannel == null) {
      debugPrint('ERROR: MethodChannel is null');
      return false;
    }
    bool? paused = await _nativeChannel!.invokeMethod(
      'pause',
    );
    return paused;
  }

  Future<bool?> play() async {
    if (_nativeChannel == null) {
      debugPrint('ERROR: MethodChannel is null');
      return false;
    }
    bool? played = await _nativeChannel!.invokeMethod(
      'play',
    );
    return played;
  }

  Future<bool?> stop() async {
    if (_nativeChannel == null) {
      debugPrint('ERROR: MethodChannel is null');
      return false;
    }
    bool? stopped = await _nativeChannel!.invokeMethod(
      'stop',
    );
    return stopped;
  }

  static VideoLifecycleEvent? toVideoLifeCycleEvent(String event) {
    return _videoLifecycleEventMap[event];
  }

  static const Map<String, VideoLifecycleEvent> _videoLifecycleEventMap =
      <String, VideoLifecycleEvent>{
    'onVideoEnd': VideoLifecycleEvent.end,
    'onVideoMute': VideoLifecycleEvent.mute,
    'onVideoPause': VideoLifecycleEvent.pause,
    'onVideoPlay': VideoLifecycleEvent.play,
    'onVideoStart': VideoLifecycleEvent.start,
  };
}

typedef VideoLifecycleListener = void Function(
  VideoLifecycleEvent event, {
  bool? isMuted,
});

enum VideoLifecycleEvent {
  start,
  play,
  pause,
  end,
  mute,
}
