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

class MessageGetOption {
  MessagePolicy? policy;
  MessagePicker? messagePicker;
  MessageGetCallback? getCallback;

  MessageGetOption({
    MessagePolicy? policy,
    MessagePicker? messagePicker,
    this.getCallback,
  }) {
    this.policy = policy ?? MessagePolicyBuilder().build();
    this.messagePicker = messagePicker ?? MessagePicker.includeAll;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'policy': policy?.toMap(),
      'messagePicker': messagePicker?.toMap(),
      'getCallback': getCallback?.id,
    };
  }

  @override
  String toString() {
    return 'GetOption{policy=$messagePicker, filter=$policy}';
  }
}

class MessagePutOption {
  MessagePolicy? policy;
  MessagePutCallback? putCallback;

  MessagePutOption({
    MessagePolicy? policy,
    this.putCallback,
  }) {
    this.policy = policy ?? MessagePolicyBuilder().build();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'policy': policy?.toMap(),
      'putCallback': putCallback?.id,
    };
  }
}
