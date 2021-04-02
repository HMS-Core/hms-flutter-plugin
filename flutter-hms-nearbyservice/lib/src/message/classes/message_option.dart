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

import 'package:huawei_nearbyservice/src/message/callback/classes.dart';
import 'package:huawei_nearbyservice/src/message/classes/message_picker.dart';
import 'package:huawei_nearbyservice/src/message/classes/message_policy.dart';

class MessageGetOption {
  MessagePolicy policy;
  MessagePicker messagePicker;
  MessageGetCallback getCallback;

  MessageGetOption(
      {MessagePolicy policy, MessagePicker messagePicker, this.getCallback}) {
    this.policy = policy ?? MessagePolicyBuilder().build();
    this.messagePicker = messagePicker ?? MessagePicker.includeAll;
  }

  Map<String, dynamic> toMap() => {
        'policy': policy?.toMap(),
        'messagePicker': messagePicker?.toMap(),
        'getCallback': getCallback?.id
      };

  @override
  String toString() =>
      'GetOption{policy=' +
      messagePicker.toString() +
      ', filter=' +
      policy.toString() +
      '}';
}

class MessagePutOption {
  MessagePolicy policy;
  MessagePutCallback putCallback;

  MessagePutOption({MessagePolicy policy, this.putCallback}) {
    this.policy = policy ?? MessagePolicyBuilder().build();
  }

  Map<String, dynamic> toMap() => {
        'policy': policy?.toMap(),
        'putCallback': putCallback?.id,
      };
}
