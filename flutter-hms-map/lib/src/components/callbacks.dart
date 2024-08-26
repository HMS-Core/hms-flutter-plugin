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

part of '../../huawei_map.dart';

typedef CameraPositionCallback = void Function(CameraPosition position);
typedef ArgumentCallback<T> = void Function(T argument);

class ArgumentCallbacks<T> {
  final List<ArgumentCallback<T>> _callbacks = <ArgumentCallback<T>>[];

  bool get isEmpty => _callbacks.isEmpty;

  bool get isNotEmpty => _callbacks.isNotEmpty;

  void add(ArgumentCallback<T> callback) {
    _callbacks.add(callback);
  }

  void remove(ArgumentCallback<T> callback) {
    _callbacks.remove(callback);
  }

  void call(T argument) {
    final int length = _callbacks.length;
    if (length == 1) {
      _callbacks[0].call(argument);
    } else if (length > 0) {
      for (ArgumentCallback<T> callback
          in List<ArgumentCallback<T>>.from(_callbacks)) {
        callback(argument);
      }
    }
  }
}
