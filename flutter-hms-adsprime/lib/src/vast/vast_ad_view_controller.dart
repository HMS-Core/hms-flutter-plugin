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

class VastAdViewController {
  late MethodChannel _channel;
  final VastAdEventListener? eventListener;

  VastAdViewController._(int viewId, this.eventListener) {
    _channel = MethodChannel('$_VAST_VIEW/$viewId');
    _channel.setMethodCallHandler(
      (MethodCall call) async {
        switch (call.method) {
          case 'VastPlayerListener.onPlayStateChanged':
            eventListener?.onPlayStateChanged?.call(call.arguments);
            break;
          case 'VastPlayerListener.onVolumeChanged':
            eventListener?.onVolumeChanged?.call(call.arguments);
            break;
          case 'VastPlayerListener.onScreenViewChanged':
            eventListener?.onScreenViewChanged?.call(call.arguments);
            break;
          case 'VastPlayerListener.onProgressChanged':
            final List<int> progressList = call.arguments;
            eventListener?.onProgressChanged?.call(
              progressList[0],
              progressList[1],
              progressList[2],
            );
            break;
          case 'AdsRequestListener.onSuccess':
            eventListener?.onSuccess?.call(call.arguments);
            break;
          case 'AdsRequestListener.onFailed':
            eventListener?.onFailed?.call(call.arguments);
            break;
          case 'AdsRequestListener.playAdReady':
            eventListener?.playAdReady?.call();
            break;
          case 'AdsRequestListener.playAdFinish':
            eventListener?.playAdFinish?.call();
            break;
          case 'AdsRequestListener.playAdError':
            eventListener?.playAdError?.call(call.arguments);
            break;
          case 'AdsRequestListener.onBufferStart':
            eventListener?.onBufferStart?.call();
            break;
          case 'AdsRequestListener.onBufferEnd':
            eventListener?.onBufferEnd?.call();
            break;
          default:
            throw UnimplementedError;
        }
      },
    );
  }

  Future<bool> loadLinearAd() async {
    final bool? result = await _channel.invokeMethod(
      'loadLinearAd',
    );

    return result!;
  }

  Future<void> playLinearAds() async {
    return await _channel.invokeMethod(
      'playLinearAds',
    );
  }

  Future<void> startLinearAd() async {
    return await _channel.invokeMethod(
      'startLinearAd',
    );
  }

  Future<void> startAdPods() async {
    return await _channel.invokeMethod(
      'startAdPods',
    );
  }

  Future<void> changeLocalLanguage(
    String languageCode, [
    String? countryCode,
  ]) async {
    return await _channel.invokeMethod(
      'changeLocalLanguage',
      <String, dynamic>{
        'languageCode': languageCode,
        'countryCode': countryCode,
      },
    );
  }

  Future<void> resume() async {
    return await _channel.invokeMethod(
      'resume',
    );
  }

  Future<void> pause() async {
    return await _channel.invokeMethod(
      'pause',
    );
  }

  Future<void> release() async {
    return await _channel.invokeMethod(
      'release',
    );
  }

  Future<void> setConfig(PlayerConfig playerConfig) async {
    return await _channel.invokeMethod(
      'setConfig',
      <String, dynamic>{
        'playerConfig': playerConfig._toMap(),
      },
    );
  }

  Future<PlayerConfig> getConfig() async {
    final Map<dynamic, dynamic>? result = await _channel.invokeMethod(
      'getConfig',
    );
    return PlayerConfig._fromMap(result!);
  }

  Future<bool> isLinearAdShown() async {
    final bool? result = await _channel.invokeMethod(
      'isLinearAdShown',
    );
    return result!;
  }

  Future<bool> isLinearPlaying() async {
    final bool? result = await _channel.invokeMethod(
      'isLinearPlaying',
    );
    return result!;
  }

  Future<void> startOrPause() async {
    return await _channel.invokeMethod(
      'startOrPause',
    );
  }

  Future<void> toggleMuteState(bool isMute) async {
    return await _channel.invokeMethod(
      'toggleMuteState',
      <String, dynamic>{
        'isMute': isMute,
      },
    );
  }
}
