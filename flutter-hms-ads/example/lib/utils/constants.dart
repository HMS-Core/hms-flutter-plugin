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

import 'package:flutter/material.dart';

class Styles {
  static const TextStyle menuButtonStyle = TextStyle(
    fontSize: 17,
  );
  static const TextStyle adControlButtonStyle = TextStyle(
    fontSize: 17,
  );
  static const TextStyle warningTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );
  static const TextStyle textContentStyle = TextStyle(
    fontSize: 15,
  );
}

const String consentExample =
    'The Ads in HUAWEI X is provided in collaboration with our partners.\n\n In order to provide you with personalized advertisements, we need to share the following information with our partners:\n\n • User information, including advertising ID, city of residence, country, and language.\n\n • Device information, including device name and model, operating system version, screen size, and network type.\n\n • Service usage information, including news ID and records of views, clicks, dislikes, shares, and comments for news content and advertisements.\n\n With your consent, the above information will be shared with our partners so that they can provide you with personalized advertisements on behalf of their customers, based on interests and preferences identified or predicted through analysis of your personal information.\n\n You can withdraw your consent at any time by going to app settings.\n\n Without your consent, no data will be shared with our partners and you will not see personalized content.';
const String privacyExample =
    '1.Privacy description\n The Huawei ads_example is a software providing a code demo for the HUAWEI Ads Plugin for Flutter. Connecting to the network, the software collects and processes information to identify devices, providing customized services or ads. If you do not agree to collect the preceding information or do not agree to call related permissions or functions of your mobile phones, the software cannot run properly. You can stop data collection and uploading by uninstalling or exiting this software.\n\n 2.Demo description\n This demo is for reference only. Modify the content based on the user protocol specifications. \n\n 3.Advertising and marketing\n We will create a user group based on your personal information, collect your device information, usage information, and ad interaction information in this app, and display more relevant personalized ads and other promotion content. In this process, we will strictly protect your privacy. You can learn more about how we collect and use your personal information in personalized ads based on Ads and Privacy. If you want to restrict personalized ads, you can do so in the ad setting page and enable the function of restricting personalized ads. After the function is enabled, you will still receive equivalent number of ads. However, the ad relevance will be reduced.';
