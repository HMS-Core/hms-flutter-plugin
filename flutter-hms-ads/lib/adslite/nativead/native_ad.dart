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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:huawei_ads/adslite/nativead/native_ad_controller.dart';
import 'package:huawei_ads/adslite/nativead/native_styles.dart';
import 'package:huawei_ads/utils/view_types.dart';

class NativeAd extends StatefulWidget {
  final String adSlotId;
  final NativeAdType type;
  final NativeStyles styles;
  final NativeAdController controller;

  NativeAd({
    @required this.adSlotId,
    this.type = NativeAdType.banner,
    this.styles,
    this.controller,
  });

  @override
  _NativeAdState createState() => _NativeAdState();
}

class _NativeAdState extends State<NativeAd> {
  NativeAdController _nativeAdController;
  NativeStyles get _nativeStyles => widget.styles;
  NativeAdType get _type => widget.type;
  NativeAdLoadState _state = NativeAdLoadState.loading;

  @override
  void initState() {
    super.initState();
    _nativeAdController = widget.controller ?? NativeAdController();
    _nativeAdController.setup(widget.adSlotId);
    _nativeAdController.loadListener = (NativeAdLoadState state) {
      setState(() {
        _state = state;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _state == NativeAdLoadState.failed
          ? Container(
              child: Icon(
                Icons.error,
                color: Colors.redAccent,
                size: 40,
              ),
            )
          : _state == NativeAdLoadState.loading
              ? Center(child: CircularProgressIndicator())
              : _createNativePlatformView(),
    );
  }

  Widget _createNativePlatformView() => AndroidView(
        viewType: NATIVE_VIEW,
        creationParamsCodec: StandardMessageCodec(),
        creationParams: {
          "id": _nativeAdController.id,
          "nativeStyles": _nativeStyles?.toJson(),
          "type": describeEnum(_type),
        },
      );

  @override
  void dispose() {
    super.dispose();
    _nativeAdController?.destroy();
  }
}

enum NativeAdType { banner, small, full, video }
