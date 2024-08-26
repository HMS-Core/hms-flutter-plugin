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

part of '../../../huawei_ads.dart';

class InstreamAdViewElements extends StatelessWidget {
  final Function? onSkip;
  final Function? onInfo;
  final String? callToActionText;
  final String? countdown;

  final String? skipText;
  final String? adFlagText;

  const InstreamAdViewElements({
    Key? key,
    this.onSkip,
    this.onInfo,
    this.callToActionText,
    this.countdown,
    this.skipText,
    this.adFlagText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                shape: Border.all(color: Colors.white30),
                onPressed: onSkip as void Function()?,
                child: Text(
                  skipText ?? 'Skip',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Text(
                countdown ?? '',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const SizedBox(width: 8),
                  Text(
                    adFlagText ?? 'Ad',
                    style: const TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                    onPressed: onInfo as void Function()?,
                  )
                ],
              ),
              IgnorePointer(
                child: Text(
                  callToActionText ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
