/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

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
import 'package:huawei_ads/adslite/ad_size.dart';
import 'package:huawei_ads/adslite/video_configuration.dart';

class NativeAdConfiguration {
  AdSize adSize;
  int choicesPosition;
  int mediaDirection;
  int mediaAspect;
  bool requestCustomDislikeAd;
  bool requestMultiImages;
  bool returnUrlsForImages;
  VideoConfiguration videoConfiguration;

  NativeAdConfiguration(
      {this.adSize,
      this.choicesPosition,
      this.mediaDirection,
      this.mediaAspect,
      this.requestCustomDislikeAd,
      this.requestMultiImages,
      this.returnUrlsForImages,
      VideoConfiguration configuration}) {
    videoConfiguration = configuration ?? VideoConfiguration();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (adSize != null) json['adSize'] = adSize.toJson();
    if (choicesPosition != null) json['choicesPosition'] = choicesPosition;
    if (mediaDirection != null) json['direction'] = mediaDirection;
    if (mediaAspect != null) json['aspect'] = mediaAspect;
    if (requestCustomDislikeAd != null)
      json['requestCustomDislikeAd'] = requestCustomDislikeAd;
    if (requestMultiImages != null)
      json['requestMultiImages'] = requestMultiImages;
    if (returnUrlsForImages != null)
      json['returnUrlsForImages'] = returnUrlsForImages;
    if (videoConfiguration != null)
      json['videoConfiguration'] = videoConfiguration.toJson();

    return json;
  }
}
