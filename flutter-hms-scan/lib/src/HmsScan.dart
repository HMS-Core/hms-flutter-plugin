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

part of huawei_scan;

class HmsScan {
  late MethodChannel _scanUtilsChannel;
  late MethodChannel _multiProcessorChannel;
  late MethodChannel _customizedViewChannel;
  late MethodChannel _remoteViewChannel;

  HmsScan.private(
    MethodChannel scanUtilsChannel,
    MethodChannel multiProcessorChannel,
    MethodChannel customizedViewChannel,
    MethodChannel remoteViewChannel,
  ) {
    _scanUtilsChannel = scanUtilsChannel;
    _multiProcessorChannel = multiProcessorChannel;
    _multiProcessorChannel
        .setMethodCallHandler(HmsMultiProcessor.multiMethodCallHandler);
    _customizedViewChannel = customizedViewChannel;
    _customizedViewChannel
        .setMethodCallHandler(HmsCustomizedView.customizedMethodCallHandler);
    _remoteViewChannel = remoteViewChannel;
    _remoteViewChannel
        .setMethodCallHandler(HmsCustomizedView.listenCustomizedLifecycle);
  }

  static final HmsScan _instance = HmsScan.private(
    const MethodChannel('scanUtilsChannel'),
    const MethodChannel('multiProcessorChannel'),
    const MethodChannel('customizedViewChannel'),
    const MethodChannel('remoteViewChannel'),
  );

  static HmsScan get instance => _instance;

  MethodChannel get scanUtilsChannel => _scanUtilsChannel;

  MethodChannel get multiProcessorChannel => _multiProcessorChannel;

  MethodChannel get customizedViewChannel => _customizedViewChannel;

  MethodChannel get remoteViewChannel => _remoteViewChannel;
}
