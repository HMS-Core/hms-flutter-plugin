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

class HMSMessageEngine {
  final MethodChannel _methodChannel;
  final EventChannel _eventChannel;

  HMSMessageEngine._(this._methodChannel, this._eventChannel) {
    _methodChannel.setMethodCallHandler(onMethodCall);
  }

  Stream<dynamic>? _messageBroadcastStream;
  StreamSubscription<dynamic>? _messageSub;

  static NearbyMessageHandler? _pendingHandler;
  static MessageGetOption? _pendingGetOption;

  static final HMSMessageEngine _instance = HMSMessageEngine._(
    const MethodChannel(_messageMethodChannel),
    const EventChannel(_messageEventChannel),
  );

  static HMSMessageEngine get instance {
    return _instance;
  }

  Stream<dynamic>? get _getMessageBroadcastStream {
    _messageBroadcastStream ??= _eventChannel.receiveBroadcastStream();
    return _messageBroadcastStream;
  }

  Future<void> put(Message message) {
    ArgumentError.checkNotNull(message, 'message');
    return _methodChannel.invokeMethod(
      'put',
      <String, dynamic>{
        'message': message.toMap(),
      },
    );
  }

  Future<void> putWithOption(Message message, MessagePutOption putOption) {
    ArgumentError.checkNotNull(message, 'message');
    _listen();
    return _methodChannel.invokeMethod(
      'putWithOption',
      <String, dynamic>{
        'message': message.toMap(),
        'putOption': putOption.toMap(),
      },
    );
  }

  Future<void> registerStatusCallback(MessageStatusCallback statusCallback) {
    ArgumentError.checkNotNull(statusCallback, 'statusCallback');
    _listen();
    return _methodChannel.invokeMethod(
      'registerStatusCallback',
      <String, dynamic>{
        'statusCallback': statusCallback.id,
      },
    );
  }

  Future<void> get(NearbyMessageHandler handler) {
    ArgumentError.checkNotNull(handler, 'handler');
    _listen();
    return _methodChannel.invokeMethod(
      'get',
      <String, dynamic>{
        'handler': handler.id,
      },
    );
  }

  Future<void> getWithOption(
    NearbyMessageHandler handler,
    MessageGetOption getOption,
  ) {
    ArgumentError.checkNotNull(handler, 'handler');
    _listen();
    return _methodChannel.invokeMethod(
      'getWithOption',
      <String, dynamic>{
        'handler': handler.id,
        'getOption': getOption.toMap(),
      },
    );
  }

  Future<void> getPending(
    NearbyMessageHandler handler, [
    MessageGetOption? option,
  ]) {
    _listen();
    ArgumentError.checkNotNull(handler);
    ArgumentError.checkNotNull(handler.onFound);
    ArgumentError.checkNotNull(handler.onLost);
    _pendingHandler = handler;
    _pendingGetOption = option;

    return _methodChannel.invokeMethod(
      'getPending',
      <String, dynamic>{
        'getOption': _pendingGetOption?.toMap(),
      },
    );
  }

  Future<void> unput(Message message, [MessagePutOption? putOption]) async {
    ArgumentError.checkNotNull(message, 'message');
    await _methodChannel.invokeMethod(
      'unput',
      <String, dynamic>{
        'message': message.toMap(),
        'putOption': putOption?.toMap(),
      },
    );
    if (putOption?.putCallback?.id != null) {
      MessagePutCallback.putCbs.remove(putOption!.putCallback!.id);
    }
  }

  Future<void> unregisterStatusCallback(
    MessageStatusCallback statusCallback,
  ) async {
    ArgumentError.checkNotNull(statusCallback, 'statusCallback');
    await _methodChannel.invokeMethod(
      'unregisterStatusCallback',
      <String, dynamic>{
        'statusCallback': statusCallback.id,
      },
    );
    MessageStatusCallback.statusCbs.remove(statusCallback.id);
  }

  Future<void> unget(
    NearbyMessageHandler handler, [
    MessageGetOption? getOption,
  ]) async {
    ArgumentError.checkNotNull(handler, 'handler');
    await _methodChannel.invokeMethod(
      'unget',
      <String, dynamic>{
        'handler': handler.id,
        'getOption': getOption?.toMap(),
      },
    );
    NearbyMessageHandler.msgHandlerCbs.remove(handler.id);
    if (getOption?.getCallback?.id != null) {
      MessageGetCallback.getCbs.remove(getOption!.getCallback!.id);
    }
  }

  Future<void> ungetPending() async {
    await _methodChannel.invokeMethod(
      'ungetPending',
      <String, dynamic>{
        'getOption': _pendingGetOption?.toMap(),
      },
    );
    _pendingHandler = null;
  }

  Future<void> dispose() async {
    await _methodChannel.invokeMethod(
      'dispose',
    );
    _messageSub?.cancel();
    MessageGetCallback.getCbs.clear();
    MessagePutCallback.putCbs.clear();
    MessageStatusCallback.statusCbs.clear();
    NearbyMessageHandler.msgHandlerCbs.clear();
    _pendingGetOption = null;
    _pendingHandler = null;
  }

  void _listen() {
    _messageSub ??= _getMessageBroadcastStream!.listen((dynamic channelEvent) {
      Map<dynamic, dynamic> argsMap = channelEvent;
      String? event = argsMap['event'];
      int? id = argsMap['id'];
      if (id == null) {
        debugPrint('HMSMessageEngine | id is null.');
        return;
      }

      _MessageEvent? msgEvent = _toMessageEvent(event);
      if (msgEvent != null) {
        NearbyMessageHandler? handler = NearbyMessageHandler.msgHandlerCbs[id];
        switch (msgEvent) {
          case _MessageEvent.onBleSignalChanged:
            handler?.onBleSignalChanged?.call(
              Message.fromMap(argsMap['message']),
              BleSignal.fromMap(argsMap['bleSignal']),
            );
            break;
          case _MessageEvent.onDistanceChanged:
            handler?.onDistanceChanged?.call(
              Message.fromMap(argsMap['message']),
              Distance.fromMap(argsMap['distance']),
            );
            break;
          case _MessageEvent.onFound:
            handler?.onFound?.call(Message.fromMap(argsMap['message']));
            break;
          case _MessageEvent.onLost:
            handler?.onLost?.call(Message.fromMap(argsMap['message']));
            break;
        }
      }
      if (event == 'onPermissionChanged') {
        MessageStatusCallback.statusCbs[id]?.onPermissionChanged
            ?.call(argsMap['granted']);
      }
      if (event == 'onGetTimeout') {
        MessageGetCallback.getCbs[id]?.onTimeout?.call();
      }
      if (event == 'onPutTimeout') {
        MessagePutCallback.putCbs[id]?.onTimeout?.call();
      }
    });
  }

  static Future<dynamic> onMethodCall(MethodCall call) {
    final Map<dynamic, dynamic>? argsMap = call.arguments;
    switch (call.method) {
      case 'pendingOnFound':
        _pendingHandler?.onFound?.call(Message.fromMap(argsMap!['message']));
        break;
      case 'pendingOnLost':
        _pendingHandler?.onLost?.call(Message.fromMap(argsMap!['message']));
        break;
      case 'pendingOnTimeout':
        _pendingGetOption?.getCallback?.onTimeout?.call();
        break;
      default:
        debugPrint('ERROR | Unknown method');
        break;
    }
    return Future<dynamic>.value(null);
  }

  static _MessageEvent? _toMessageEvent(String? event) {
    return _messageHandlerEventMap[event!];
  }

  static const Map<String, _MessageEvent> _messageHandlerEventMap =
      <String, _MessageEvent>{
    'onBleSignalChanged': _MessageEvent.onBleSignalChanged,
    'onDistanceChanged': _MessageEvent.onDistanceChanged,
    'onFound': _MessageEvent.onFound,
    'onLost': _MessageEvent.onLost,
  };
}

enum _MessageEvent {
  onBleSignalChanged,
  onDistanceChanged,
  onFound,
  onLost,
}
