/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

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

void checkArguments(List<dynamic> args) {
  if (args.contains(null))
    throw new ArgumentError("Required parameters must not be null!");
}

typedef void AvailabilityResultListener(AvailabilityEvent event);

enum AvailabilityEvent { onDialogCanceled, resultOk, resultCanceled }

AvailabilityEvent toAvailabilityEvent(String event) => availabilityMap[event];

const Map<String, AvailabilityEvent> availabilityMap = {
  '-1': AvailabilityEvent.resultOk,
  '0': AvailabilityEvent.resultCanceled,
  'onDialogCanceled': AvailabilityEvent.onDialogCanceled
};
