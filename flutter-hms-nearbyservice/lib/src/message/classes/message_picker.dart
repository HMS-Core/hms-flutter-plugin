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

part of huawei_nearbyservice;

class MessagePicker {
  final bool includeAllTypes;
  final List<UidInstance> eddystoneUids;
  final List<IBeaconInfo> iBeaconIds;
  final List<NamespaceType> namespaceTypes;

  static final MessagePicker includeAll =
      MessagePickerBuilder().includeAll().build();

  bool equals(dynamic object) {
    return identical(this, object) ||
        object is MessagePickerBuilder &&
            _equalsEddystone(eddystoneUids, object._eddystoneUids) &&
            _equalsIBeacon(iBeaconIds, object._iBeaconIds) &&
            _equalsNamespace(namespaceTypes, object._namespaceTypes);
  }

  MessagePicker._builder(MessagePickerBuilder builder)
      : includeAllTypes = builder._includeAllTypes,
        eddystoneUids = builder._eddystoneUids,
        iBeaconIds = builder._iBeaconIds,
        namespaceTypes = builder._namespaceTypes;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['includeAllTypes'] = includeAllTypes;
    if (iBeaconIds.isNotEmpty) {
      map['iBeaconIds'] = iBeaconIds.map((IBeaconInfo e) => e.toMap()).toList();
    }
    if (eddystoneUids.isNotEmpty) {
      map['eddystoneUids'] =
          eddystoneUids.map((UidInstance e) => e.toMap()).toList();
    }
    if (namespaceTypes.isNotEmpty) {
      map['namespaceTypes'] =
          namespaceTypes.map((NamespaceType e) => e.toMap()).toList();
    }

    return map;
  }

  @override
  String toString() {
    List<NamespaceType> types = List<NamespaceType>.empty(growable: true);
    eddystoneUids.forEach((UidInstance element) {
      types.add(NamespaceType('_reserved_namespace', '_eddystone_uid'));
    });

    iBeaconIds.forEach((IBeaconInfo element) {
      types.add(NamespaceType('_reserved_namespace', '_ibeacon_id'));
    });

    types.addAll(namespaceTypes);
    String str = '';
    for (NamespaceType element in types) {
      str += element.toString();
    }

    return 'MessagePicker{includeAllTypes=$includeAllTypes, messageTypes=$str}';
  }

  bool _equalsEddystone(List<UidInstance> l1, List<UidInstance> l2) {
    bool equals = false;
    if (l1.length == l2.length) {
      for (int i = 0; i < l1.length; i++) {
        equals = l1[i].equals(l2[i]);
      }
    }
    return equals;
  }

  bool _equalsIBeacon(List<IBeaconInfo> l1, List<IBeaconInfo> l2) {
    bool equals = false;
    if (l1.length == l2.length) {
      for (int i = 0; i < l1.length; i++) {
        equals = l1[i].equals(l2[i]);
      }
    }
    return equals;
  }

  bool _equalsNamespace(List<NamespaceType> l1, List<NamespaceType> l2) {
    bool equals = false;
    if (l1.length == l2.length) {
      for (int i = 0; i < l1.length; i++) {
        equals = l1[i].equals(l2[i]);
      }
    }
    return equals;
  }
}

class MessagePickerBuilder {
  bool _includeAllTypes = false;
  final List<IBeaconInfo> _iBeaconIds = <IBeaconInfo>[];
  final List<UidInstance> _eddystoneUids = <UidInstance>[];
  final List<NamespaceType> _namespaceTypes = <NamespaceType>[];

  MessagePickerBuilder();

  MessagePickerBuilder includeAll() {
    _includeAllTypes = true;
    return this;
  }

  MessagePickerBuilder includeEddyStoneUids(List<UidInstance> eddystoneUids) {
    _eddystoneUids.addAll(eddystoneUids);
    return this;
  }

  MessagePickerBuilder includeIBeaconIds(List<IBeaconInfo> iBeaconIds) {
    _iBeaconIds.addAll(iBeaconIds);
    return this;
  }

  MessagePickerBuilder includeNamespaceType(
    List<NamespaceType> namespaceTypes,
  ) {
    _namespaceTypes.addAll(namespaceTypes);
    return this;
  }

  MessagePickerBuilder includePicker(MessagePicker picker) {
    _includeAllTypes |= picker.includeAllTypes;
    return includeEddyStoneUids(picker.eddystoneUids)
        .includeIBeaconIds(picker.iBeaconIds)
        .includeNamespaceType(picker.namespaceTypes);
  }

  MessagePicker build() {
    if (!_includeAllTypes &&
        _namespaceTypes.isEmpty &&
        _iBeaconIds.isEmpty &&
        _eddystoneUids.isEmpty) {
      throw UnsupportedError(
        'At least one of the include methods must be called before build.',
      );
    }
    return MessagePicker._builder(this);
  }
}
