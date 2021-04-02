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
import 'dart:collection';

class AdProvider {
  String id;
  String name;
  String serviceArea;
  String privacyPolicyUrl;

  AdProvider({this.id, this.name, this.serviceArea, this.privacyPolicyUrl});

  bool isValid() {
    return (id != null && id.isNotEmpty) &&
        (name != null && name.isNotEmpty) &&
        (serviceArea != null && serviceArea.isNotEmpty) &&
        (privacyPolicyUrl != null && privacyPolicyUrl.isNotEmpty);
  }

  static List<AdProvider> buildList(List<dynamic> args) {
    List<AdProvider> adProviders = new List<AdProvider>();
    if (args != null)
      args.forEach((dynamic providerMap) {
        adProviders.add(build(providerMap));
      });
    return adProviders;
  }

  static AdProvider build(LinkedHashMap<dynamic, dynamic> args) {
    AdProvider provider = new AdProvider();

    if (args['id'] != null) provider.id = args['id'];
    if (args['name'] != null) provider.name = args['name'];
    if (args['serviceArea'] != null) provider.serviceArea = args['serviceArea'];
    if (args['privacyPolicyUrl'] != null)
      provider.privacyPolicyUrl = args['privacyPolicyUrl'];

    return provider;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    if (id != null) json['id'] = id;
    if (name != null) json['name'] = name;
    if (serviceArea != null) json['serviceArea'] = serviceArea;
    if (privacyPolicyUrl != null) json['privacyPolicyUrl'] = privacyPolicyUrl;

    return json;
  }
}
