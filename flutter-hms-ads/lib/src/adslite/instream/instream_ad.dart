/*
    Copyright 2020-2023. Huawei Technologies Co., Ltd. All rights reserved.

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

part of huawei_ads;

class InstreamAd {
  final int id;
  final MethodChannel _channel;

  InstreamAd({
    required this.id,
  }) : _channel = MethodChannel('$_INSTREAM_METHOD_CHANNEL/AD/$id');

  Future<String?> getAdSource() async {
    return await _channel.invokeMethod(
      'getAdSource',
    );
  }

  Future<String?> getCallToAction() async {
    return await _channel.invokeMethod(
      'getCallToAction',
    );
  }

  Future<int?> getDuration() async {
    return await _channel.invokeMethod(
      'getDuration',
    );
  }

  Future<String?> getWhyThisAd() async {
    return await _channel.invokeMethod(
      'getWhyThisAd',
    );
  }

  Future<String?> getAdSign() async {
    return await _channel.invokeMethod(
      'getAdSign',
    );
  }

  Future<bool?> isClicked() async {
    return await _channel.invokeMethod(
      'isClicked',
    );
  }

  Future<bool?> isExpired() async {
    return await _channel.invokeMethod(
      'isExpired',
    );
  }

  Future<bool?> isImageAd() async {
    return await _channel.invokeMethod(
      'isImageAd',
    );
  }

  Future<bool?> isShown() async {
    return await _channel.invokeMethod(
      'isShown',
    );
  }

  Future<bool?> isVideoAd() async {
    return await _channel.invokeMethod(
      'isVideoAd',
    );
  }

  Future<bool?> gotoWhyThisAdPage() async {
    return await _channel.invokeMethod(
      'gotoWhyThisAdPage',
    );
  }

  Future<bool> hasAdvertiserInfo() async {
    return await _channel.invokeMethod(
      'hasAdvertiserInfo',
    );
  }

  Future<List<AdvertiserInfo>> getAdvertiserInfo() async {
    final List<dynamic> result = await _channel.invokeMethod(
      'getAdvertiserInfo',
    );
    final List<AdvertiserInfo> list = <AdvertiserInfo>[];
    for (dynamic map in result) {
      list.add(AdvertiserInfo._fromMap(map as Map<dynamic, dynamic>));
    }
    return list;
  }

  Future<bool> isTransparencyOpen() async {
    return await _channel.invokeMethod(
      'isTransparencyOpen',
    );
  }

  Future<String> transparencyTplUrl() async {
    return await _channel.invokeMethod(
      'transparencyTplUrl',
    );
  }
}
