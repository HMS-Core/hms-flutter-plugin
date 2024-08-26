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

library huawei_adsprime;

import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'src/adslite/ad_param.dart';
part 'src/adslite/ad_size.dart';
part 'src/adslite/bidding_info.dart';
part 'src/adslite/bidding_param.dart';
part 'src/adslite/banner/banner_ad.dart';
part 'src/adslite/banner/banner_ad_size.dart';
part 'src/adslite/banner/banner_view.dart';
part 'src/adslite/consent/ad_provider.dart';
part 'src/adslite/consent/consent.dart';
part 'src/adslite/hw_ads.dart';
part 'src/adslite/instream/instream_ad.dart';
part 'src/adslite/instream/instream_ad_loader.dart';
part 'src/adslite/instream/instream_ad_view.dart';
part 'src/adslite/instream/instream_ad_view_elements.dart';
part 'src/adslite/interstitial/interstitial_ad.dart';
part 'src/adslite/nativead/detailed_creative_type.dart';
part 'src/adslite/nativead/dislike_ad_reason.dart';
part 'src/adslite/nativead/native_ad.dart';
part 'src/adslite/nativead/native_ad_configuration.dart';
part 'src/adslite/nativead/native_ad_controller.dart';
part 'src/adslite/nativead/native_styles.dart';
part 'src/adslite/nativead/app_info.dart';
part 'src/adslite/nativead/promote_info.dart';
part 'src/adslite/request_options.dart';
part 'src/adslite/reward/reward_ad.dart';
part 'src/adslite/reward/reward_verify_config.dart';
part 'src/adslite/splash/splash_ad.dart';
part 'src/adslite/video_configuration.dart';
part 'src/adslite/video_operator.dart';
part 'src/huawei_adsprime.dart';
part 'src/identifier/advertising_id_client.dart';
part 'src/installreferrer/install_referrer_client.dart';
part 'src/installreferrer/referrer_details.dart';
part 'src/utils/bundle.dart';
part 'src/utils/channels.dart';
part 'src/utils/constants.dart';
part 'src/utils/view_types.dart';
part 'src/vast/models/base_ad_slot.dart';
part 'src/vast/models/linear_ad_slot.dart';
part 'src/vast/models/player_config.dart';
part 'src/vast/models/vast_request_options.dart';
part 'src/vast/models/vast_sdk_configuration.dart';
part 'src/vast/vast_ad_event_listener.dart';
part 'src/vast/vast_ad_view.dart';
part 'src/vast/vast_ad_view_controller.dart';
part 'src/vast/vast_sdk_factory.dart';
