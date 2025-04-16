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

class SplashAd {
  static final Map<int, SplashAd?> splashAds = <int, SplashAd?>{};

  /// Splash ad layout type.
  SplashAdType adType;

  /// Ad owner text.
  String? ownerText;

  /// Ad copyright text.
  String? footerText;

  /// Resource ID for a custom logo.
  String? logoResId;

  /// Resource ID for a custom background logo.
  String? logoBgResId;

  /// Resource ID for app text.
  String? mediaNameResId;

  /// Resource ID for a default app launch image in portrait orientation, which is displayed before a splash ad is displayed.
  String? sloganResId;

  /// Resource ID for a default app launch image in landscape orientation, which is displayed before a splash ad is displayed.
  String? wideSloganResId;

  /// `Audio focus type` for a splash video ad.
  AudioFocusType? audioFocusType;

  /// Listener for the splash ad display or click event.
  ///
  /// If a new listener is defined after the ad is loaded, the ad needs to be loaded again for the new listener function to take effect.
  SplashAdDisplayListener? displayListener;

  /// Listener for splash ad load events.
  ///
  /// If a new listener is defined after the ad is loaded, the ad needs to be loaded again for the new listener function to take effect.
  SplashAdLoadListener? loadListener;
  EventChannel? _streamSplash;
  StreamSubscription<dynamic>? _listenerSub;

  SplashAd({
    required this.adType,
    this.displayListener,
    this.loadListener,
    this.ownerText,
    this.footerText,
    this.logoResId,
    this.logoBgResId,
    this.mediaNameResId,
    this.sloganResId,
    this.wideSloganResId,
    this.audioFocusType,
  }) {
    splashAds[id] = this;
    _streamSplash = EventChannel('$_SPLASH_EVENT_CHANNEL/$id');
  }

  int get id => hashCode;

  static const String _adType = 'Splash';

  /// Preloads a splash ad.
  static Future<bool?> preloadAd({
    required String adSlotId,
    int? orientation,
    AdParam? adParam,
  }) {
    return Ads.instance.channelSplash.invokeMethod(
      'preloadSplashAd',
      <String, dynamic>{
        'adSlotId': adSlotId,
        'adParam': adParam?._toMap(),
      },
    );
  }

  /// Returns real-time bidding data.
  Future<BiddingInfo?> getBiddingInfo() async {
    return BiddingInfo.fromJson(await Ads.instance.channelBanner.invokeMethod(
      'getBiddingInfo',
    ));
  }

  /// Loads and displays a splash ad.
  Future<bool> loadAd({
    required String adSlotId,
    required int orientation,
    required AdParam adParam,
    double topMargin = 0.0,
  }) async {
    await Ads.instance.channelSplash.invokeMethod(
      'prepareSplashAd',
      <String, dynamic>{
        'id': id,
        'adSlotId': adSlotId,
        'adType': describeEnum(adType),
        'orientation': orientation,
        'adParam': adParam._toMap(),
        'resources': _resourcesToJson(),
        'audioFocusType': audioFocusType?.index,
        'topMargin': topMargin,
        'owner': ownerText,
        'footer': footerText,
      },
    );
    _startListening();
    await Ads.instance.channelSplash.invokeMethod(
      'loadSplashAd',
      <String, dynamic>{
        'id': id,
      },
    );
    return true;
  }

  /// Checks whether a splash ad is being loaded.
  Future<bool?> isLoading() {
    return Ads.instance.channelSplash.invokeMethod(
      'isAdLoading',
      <String, dynamic>{
        'id': id,
        'adType': _adType,
      },
    );
  }

  /// Checks whether ad loading is complete.
  Future<bool?> isLoaded() {
    return Ads.instance.channelSplash.invokeMethod(
      'isAdLoaded',
      <String, dynamic>{
        'id': id,
        'adType': _adType,
      },
    );
  }

  /// Pauses an ad.
  Future<bool?> pause() {
    return Ads.instance.channel.invokeMethod(
      'pauseAd',
      <String, dynamic>{
        'id': id,
        'adType': _adType,
      },
    );
  }

  /// Resumes an ad.
  Future<bool?> resume() {
    return Ads.instance.channelSplash.invokeMethod(
      'resumeAd',
      <String, dynamic>{
        'id': id,
        'adType': _adType,
      },
    );
  }

  /// Destroys an ad.
  Future<bool?> destroy() {
    splashAds[id] = null;
    _streamSplash = null;
    _listenerSub?.cancel();
    return Ads.instance.channelSplash.invokeMethod(
      'destroyAd',
      <String, dynamic>{
        'id': id,
      },
    );
  }

  Map<String, dynamic> _resourcesToJson() {
    return <String, dynamic>{
      'logoResId': logoResId,
      'logoBgResId': logoBgResId,
      'mediaNameResId': mediaNameResId,
      'sloganResId': sloganResId,
      'wideSloganResId': wideSloganResId,
      'ownerText': ownerText,
      'footerText': footerText,
    };
  }

  void _startListening() {
    _listenerSub?.cancel();
    _listenerSub = _streamSplash!.receiveBroadcastStream(id).listen(
      (dynamic channelEvent) {
        final Map<dynamic, dynamic> argumentsMap = channelEvent;
        final SplashAdLoadEvent? loadEvent = _toLoadEvent(
          argumentsMap['event'],
        );
        final SplashAdDisplayEvent? displayEvent = _toDisplayEvent(
          argumentsMap['event'],
        );
        if (displayEvent != null) {
          displayListener?.call(displayEvent);
        } else if (loadEvent != null) {
          loadEvent == SplashAdLoadEvent.failedToLoad
              ? loadListener?.call(
                  loadEvent,
                  errorCode: argumentsMap['errorCode'],
                )
              : loadListener?.call(loadEvent);
        }
      },
    );
  }

  SplashAdLoadEvent? _toLoadEvent(String? event) {
    return _loadEventMap[event!];
  }

  SplashAdDisplayEvent? _toDisplayEvent(String? event) {
    return _displayEventMap[event!];
  }

  static const Map<String, SplashAdLoadEvent> _loadEventMap =
      <String, SplashAdLoadEvent>{
    'onSplashAdLoaded': SplashAdLoadEvent.loaded,
    'onSplashAdDismissed': SplashAdLoadEvent.dismissed,
    'onSplashAdFailedToLoad': SplashAdLoadEvent.failedToLoad,
  };

  static const Map<String, SplashAdDisplayEvent> _displayEventMap =
      <String, SplashAdDisplayEvent>{
    'onSplashAdShowed': SplashAdDisplayEvent.showed,
    'onSplashAdClick': SplashAdDisplayEvent.click,
  };
}

/// Listens to splash ad load events.
typedef SplashAdLoadListener = void Function(
  SplashAdLoadEvent event, {
  int? errorCode,
});

/// A function type defined for listening to splash ad display events.
typedef SplashAdDisplayListener = void Function(
  SplashAdDisplayEvent event,
);

/// Enumerated object that represents the load events of splash ads.
enum SplashAdLoadEvent {
  /// A splash ad is loaded successfully.
  loaded,

  /// A splash ad disappears.
  dismissed,

  /// A splash ad fails to be loaded.
  failedToLoad,
}

/// Enumerated object that represents the display or click events of splash ads.
enum SplashAdDisplayEvent {
  /// A splash ad is displayed.
  showed,

  /// A splash ad is clicked.
  click,
}

/// Enumerated object that represents the layout types of splash ads.
enum SplashAdType {
  /// A splash ad is displayed above the rest of the content.
  ///
  /// A logo is displayed next to the ad owner and copyright information.
  above,

  /// A splash ad is displayed below the rest of the content.
  ///
  /// A logo is displayed next to the ad owner and copyright information.
  below,

  /// A splash ad is displayed above the rest of the content. No logo is displayed.
  aboveNoLogo,

  /// A splash ad is displayed below the rest of the content. No logo is displayed.
  belowNoLogo,
}
