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

part of huawei_adsprime;

class InstreamAdView extends StatelessWidget {
  final List<InstreamAd> instreamAds;
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
  final Function? onClick;
  final Function(InstreamAd?)? onSegmentMediaChange;
  final Function(int? per, int? playTime)? onMediaProgress;
  final Function(int? playTime)? onMediaStart;
  final Function(int? playTime)? onMediaPause;
  final Function(int? playTime)? onMediaStop;
  final Function(int? playTime)? onMediaCompletion;
  final Function(int? playTime, int? errorCode, int? extra)? onMediaError;
  final Function? onMute;
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

  Future<bool?> destroy() async {
    return await _channel.invokeMethod(
      'destroy',
    );
  }

  Future<bool?> isPlaying() async {
    return await _channel.invokeMethod(
      'isPlaying',
    );
  }

  Future<bool?> mute() async {
    return await _channel.invokeMethod(
      'mute',
    );
  }

  Future<bool?> onClose() async {
    return await _channel.invokeMethod(
      'onClose',
    );
  }

  Future<bool?> pause() async {
    return await _channel.invokeMethod(
      'pause',
    );
  }

  Future<bool?> play() async {
    return await _channel.invokeMethod(
      'play',
    );
  }

  Future<bool?> removeInstreamMediaChangeListener() async {
    return await _channel.invokeMethod(
      'removeInstreamMediaChangeListener',
    );
  }

  Future<bool?> removeInstreamMediaStateListener() async {
    return await _channel.invokeMethod(
      'removeInstreamMediaStateListener',
    );
  }

  Future<bool?> removeMediaMuteListener() async {
    return await _channel.invokeMethod(
      'removeMediaMuteListener',
    );
  }

  Future<bool?> stop() async {
    return await _channel.invokeMethod(
      'stop',
    );
  }

  Future<bool?> unmute() async {
    return await _channel.invokeMethod(
      'unmute',
    );
  }

  Future<void> showTransparencyDialog({List<int>? location}) async {
    return await _channel.invokeMethod(
      'showTransparencyDialog',
      location,
    );
  }

  Future<void> hideTransparencyDialog() async {
    return await _channel.invokeMethod(
      'hideTransparencyDialog',
    );
  }
}
