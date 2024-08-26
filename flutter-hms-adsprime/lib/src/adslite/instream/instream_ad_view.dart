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

part of '../../../huawei_adsprime.dart';

class InstreamAdView extends StatelessWidget {
  /// Roll ads to display.
  final List<InstreamAd> instreamAds;

  /// Controller for [InstreamAdView].
  final InstreamAdViewController? controller;

  const InstreamAdView({
    Key? key,
    required this.instreamAds,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AndroidView(
      viewType: _INSTREAM_VIEW,
      onPlatformViewCreated: controller?._init,
      creationParamsCodec: const StandardMessageCodec(),
      creationParams: <String, dynamic>{
        'instreamAdIds': instreamAds.map((InstreamAd ad) => ad.id).toList(),
      },
    );
  }
}

class InstreamAdViewController {
  late MethodChannel _channel;

  /// Called when a roll ad is clicked.
  final Function? onClick;

  /// Called when a roll ad is switched to another.
  final Function(InstreamAd?)? onSegmentMediaChange;

  /// Called when a roll ad is being played.
  final Function(int? per, int? playTime)? onMediaProgress;

  /// Called when a roll ad starts to play.
  final Function(int? playTime)? onMediaStart;

  /// Called when a roll ad is paused.
  final Function(int? playTime)? onMediaPause;

  /// Called when a roll ad is stopped.
  final Function(int? playTime)? onMediaStop;

  /// Called when the playback of a roll ad is complete.
  final Function(int? playTime)? onMediaCompletion;

  /// Called when a roll ad encounters an error during playback.
  final Function(int? playTime, int? errorCode, int? extra)? onMediaError;

  /// Called when a roll ad is muted.
  final Function? onMute;

  /// Called when a roll ad is unmuted.
  final Function? onUnMute;

  final Function(int adId)? onInstreamAdViewCreated;

  InstreamAdViewController({
    this.onClick,
    this.onSegmentMediaChange,
    this.onMediaProgress,
    this.onMediaStart,
    this.onMediaPause,
    this.onMediaStop,
    this.onMediaCompletion,
    this.onMediaError,
    this.onMute,
    this.onUnMute,
    this.onInstreamAdViewCreated,
  });

  void _init(int id) {
    _channel = MethodChannel('$_INSTREAM_VIEW/$id');
    _channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'onClick':
          onClick?.call();
          break;
        case 'onSegmentMediaChange':
          Map<String, dynamic> args = Map<String, dynamic>.from(call.arguments);
          onSegmentMediaChange?.call(
            args['adId'] != null ? InstreamAd(id: args['adId']) : null,
          );
          break;
        case 'onMediaProgress':
          onMediaProgress?.call(
            call.arguments['per'],
            call.arguments['playTime'],
          );
          break;
        case 'onMediaStart':
          onMediaStart?.call(
            call.arguments['playTime'],
          );
          break;
        case 'onMediaPause':
          onMediaPause?.call(
            call.arguments['playTime'],
          );
          break;
        case 'onMediaStop':
          onMediaStop?.call(
            call.arguments['playTime'],
          );
          break;
        case 'onMediaCompletion':
          onMediaCompletion?.call(
            call.arguments['playTime'],
          );
          break;
        case 'onMediaError':
          onMediaError?.call(
            call.arguments['playTime'],
            call.arguments['errorCode'],
            call.arguments['extra'],
          );
          break;
        case 'onMute':
          onMute?.call();
          break;
        case 'onUnMute':
          onUnMute?.call();
          break;
        default:
          throw UnimplementedError;
      }
      return;
    });
    onInstreamAdViewCreated?.call(id);
  }

  /// Destroys a roll ad.
  Future<bool?> destroy() async {
    return await _channel.invokeMethod(
      'destroy',
    );
  }

  /// Checks whether an ad is being played.
  Future<bool?> isPlaying() async {
    return await _channel.invokeMethod(
      'isPlaying',
    );
  }

  /// Mutes a roll ad.
  Future<bool?> mute() async {
    return await _channel.invokeMethod(
      'mute',
    );
  }

  /// Closes a roll ad.
  Future<bool?> onClose() async {
    return await _channel.invokeMethod(
      'onClose',
    );
  }

  /// Pauses a roll ad.
  Future<bool?> pause() async {
    return await _channel.invokeMethod(
      'pause',
    );
  }

  /// Plays a roll ad.
  Future<bool?> play() async {
    return await _channel.invokeMethod(
      'play',
    );
  }

  /// Removes [MediaChangeListener].
  ///
  ///  Media change related callbacks are not called after this execution.
  Future<bool?> removeInstreamMediaChangeListener() async {
    return await _channel.invokeMethod(
      'removeInstreamMediaChangeListener',
    );
  }

  /// Removes [MediaStateListener].
  ///
  ///  Media state related callbacks are not called after this execution.
  Future<bool?> removeInstreamMediaStateListener() async {
    return await _channel.invokeMethod(
      'removeInstreamMediaStateListener',
    );
  }

  /// Removes [MediaMuteListener].
  ///
  /// Media mute related callbacks are not called after this execution.
  Future<bool?> removeMediaMuteListener() async {
    return await _channel.invokeMethod(
      'removeMediaMuteListener',
    );
  }

  /// Stops a roll ad.
  Future<bool?> stop() async {
    return await _channel.invokeMethod(
      'stop',
    );
  }

  /// Unmutes a roll ad.
  Future<bool?> unmute() async {
    return await _channel.invokeMethod(
      'unmute',
    );
  }

  /// Shows advertiser info dialog.
  Future<void> showAdvertiserInfoDialog() async {
    return await _channel.invokeMethod(
      'showAdvertiserInfoDialog',
    );
  }

  /// Hides advertiser info dialog.
  Future<void> hideAdvertiserInfoDialog() async {
    return await _channel.invokeMethod(
      'hideAdvertiserInfoDialog',
    );
  }

  /// Shows the ad transparency dialog box.
  Future<void> showTransparencyDialog({List<int>? location}) async {
    return await _channel.invokeMethod(
      'showTransparencyDialog',
      location,
    );
  }

  /// Hides the ad transparency dialog box.
  Future<void> hideTransparencyDialog() async {
    return await _channel.invokeMethod(
      'hideTransparencyDialog',
    );
  }
}
