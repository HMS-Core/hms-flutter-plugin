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

import 'package:huawei_nearbyservice/src/message/classes/ibeacon_info.dart';
import 'package:huawei_nearbyservice/src/message/classes/namespace_type.dart';
import 'package:huawei_nearbyservice/src/message/classes/uid_instance.dart';

class MessagePicker {
  final bool includeAllTypes;
  final List<UidInstance> eddystoneUids;
  final List<IBeaconInfo> iBeaconIds;
  final List<NamespaceType> namespaceTypes;

  static final MessagePicker includeAll =
      MessagePickerBuilder().includeAll().build();

  bool equals(object) =>
      identical(this, object) ||
      object is MessagePickerBuilder &&
          _equalsEddystone(this.eddystoneUids, object._eddystoneUids) &&
          _equalsIBeacon(this.iBeaconIds, object._iBeaconIds) &&
          _equalsNamespace(this.namespaceTypes, object._namespaceTypes);

  MessagePicker._builder(MessagePickerBuilder builder)
      : this.includeAllTypes = builder._includeAllTypes,
        this.eddystoneUids = builder._eddystoneUids,
        this.iBeaconIds = builder._iBeaconIds,
        this.namespaceTypes = builder._namespaceTypes;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['includeAllTypes'] = includeAllTypes;
    if (iBeaconIds.isNotEmpty)
      map['iBeaconIds'] = iBeaconIds.map((e) => e.toMap()).toList();
    if (eddystoneUids.isNotEmpty)
      map['eddystoneUids'] = eddystoneUids.map((e) => e.toMap()).toList();
    if (namespaceTypes.isNotEmpty)
      map['namespaceTypes'] = namespaceTypes.map((e) => e.toMap()).toList();

    return map;
  }

  @override
  String toString() {
    List<NamespaceType> types = List<NamespaceType>();
    eddystoneUids.forEach((element) {
      types.add(NamespaceType('_reserved_namespace', '_eddystone_uid'));
    });

    iBeaconIds.forEach((element) {
      types.add(NamespaceType('_reserved_namespace', '_ibeacon_id'));
    });

    types.addAll(namespaceTypes);
    String str = '';
    types.forEach((element) {
      str += element.toString();
    });

    return 'MessagePicker{includeAllTypes=$includeAllTypes, messageTypes=$str}';
  }

  bool _equalsEddystone(List<UidInstance> l1, List<UidInstance> l2) {
    bool equals = false;
    if (l1.length == l2.length) {
      for (int i = 0; i < l1.length; i++) equals = l1[i].equals(l2[i]);
    }
    return equals;
  }

  bool _equalsIBeacon(List<IBeaconInfo> l1, List<IBeaconInfo> l2) {
    bool equals = false;
    if (l1.length == l2.length) {
      for (int i = 0; i < l1.length; i++) equals = l1[i].equals(l2[i]);
    }
    return equals;
  }

  bool _equalsNamespace(List<NamespaceType> l1, List<NamespaceType> l2) {
    bool equals = false;
    if (l1.length == l2.length) {
      for (int i = 0; i < l1.length; i++) equals = l1[i].equals(l2[i]);
    }
    return equals;
  }
}

class MessagePickerBuilder {
  bool _includeAllTypes = false;
  List<IBeaconInfo> _iBeaconIds = List<IBeaconInfo>();
  List<UidInstance> _eddystoneUids = List<UidInstance>();
  List<NamespaceType> _namespaceTypes = List<NamespaceType>();

  MessagePickerBuilder();

  MessagePickerBuilder includeAll() {
    this._includeAllTypes = true;
    return this;
  }

  MessagePickerBuilder includeEddyStoneUids(List<UidInstance> eddystoneUids) {
    if (eddystoneUids == null) throw ArgumentError.notNull("eddystoneUids");
    _eddystoneUids.addAll(eddystoneUids);
    return this;
  }

  MessagePickerBuilder includeIBeaconIds(List<IBeaconInfo> iBeaconIds) {
    if (iBeaconIds == null) throw ArgumentError.notNull("iBeaconIds");
    _iBeaconIds.addAll(iBeaconIds);
    return this;
  }

  MessagePickerBuilder includeNamespaceType(
      List<NamespaceType> namespaceTypes) {
    if (namespaceTypes == null) throw ArgumentError.notNull("namespaceTypes");
    _namespaceTypes.addAll(namespaceTypes);
    return this;
  }

  MessagePickerBuilder includePicker(MessagePicker picker) {
    this._includeAllTypes |= picker.includeAllTypes;
    return this
        .includeEddyStoneUids(picker.eddystoneUids)
        .includeIBeaconIds(picker.iBeaconIds)
        .includeNamespaceType(picker.namespaceTypes);
  }

  MessagePicker build() {
    if (!_includeAllTypes &&
        _namespaceTypes.isEmpty &&
        _iBeaconIds.isEmpty &&
        _eddystoneUids.isEmpty)
      throw UnsupportedError(
          'At least one of the include methods must be called before build.');

    return MessagePicker._builder(this);
  }
}
