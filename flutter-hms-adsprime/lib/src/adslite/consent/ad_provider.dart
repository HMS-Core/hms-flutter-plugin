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

class AdProvider {
  /// Ad provider ID.
  String? id;

  /// Ad provider name.
  String? name;

  /// Service area information.
  String? serviceArea;

  /// Privacy policy URL.
  String? privacyPolicyUrl;

  AdProvider({
    this.id,
    this.name,
    this.serviceArea,
    this.privacyPolicyUrl,
  });

  /// Checks whether an ad provider object is valid.
  bool isValid() {
    return id != null &&
        id!.isNotEmpty &&
        name != null &&
        name!.isNotEmpty &&
        serviceArea != null &&
        serviceArea!.isNotEmpty &&
        privacyPolicyUrl != null &&
        privacyPolicyUrl!.isNotEmpty;
  }

  static List<AdProvider> buildList(List<dynamic>? args) {
    List<AdProvider> adProviders = <AdProvider>[];
    for (dynamic providerMap in (args ?? <dynamic>[])) {
      adProviders.add(build(providerMap));
    }
    return adProviders;
  }

  static AdProvider build(LinkedHashMap<dynamic, dynamic> args) {
    AdProvider provider = AdProvider();
    if (args['id'] != null) {
      provider.id = args['id'];
    }
    if (args['name'] != null) {
      provider.name = args['name'];
    }
    if (args['serviceArea'] != null) {
      provider.serviceArea = args['serviceArea'];
    }
    if (args['privacyPolicyUrl'] != null) {
      provider.privacyPolicyUrl = args['privacyPolicyUrl'];
    }
    return provider;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'serviceArea': serviceArea,
      'privacyPolicyUrl': privacyPolicyUrl,
    }..removeWhere((_, dynamic v) => v == null);
  }
}
