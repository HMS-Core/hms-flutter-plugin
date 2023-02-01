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

part of huawei_ar;

typedef ARSceneCreatedCallback = void Function(ARSceneController controller);
typedef ARTrackableCallback = void Function(dynamic arTrackable);
typedef ARHandleMessageDataCallback = void Function(String text);
typedef ARHandleCameraConfigDataCallback = void Function(
    ARCameraConfig cameraConfig);
typedef ARHandleCameraIntrinsicsDataCallback = void Function(
    ARCameraIntrinsics cameraIntrinsics);
typedef ARHandleFaceHealthResultCallback = void Function(String healthResult);
typedef ARSceneMeshDrawFrameCallback = void Function(ARSceneMesh arSceneMesh);

enum ARSceneType {
  HAND,
  FACE,
  BODY,
  WORLD,
  AUGMENTED_IMAGE,
  SCENE_MESH,
  WORLD_BODY,
  CLOUD3D_OBJECT,
}

class AREngineScene extends StatefulWidget {
  final double? height;
  final double? width;

  final ARSceneType arSceneType;
  final ARSceneBaseConfig arSceneConfig;
  final ARSceneCreatedCallback? onArSceneCreated;

  final String notSupportedText;

  final TextStyle notSupportedTextStyle;

  static const TextStyle _notSupportedTextStyle =
      TextStyle(fontWeight: FontWeight.bold);

  const AREngineScene(
    this.arSceneType,
    this.arSceneConfig, {
    Key? key,
    this.height,
    this.width,
    this.onArSceneCreated,
    this.notSupportedText = Constants.NOT_SUPPORTED,
    this.notSupportedTextStyle = _notSupportedTextStyle,
  }) : super(key: key);

  @override
  State<AREngineScene> createState() => _AREngineSceneState();
}

class _AREngineSceneState extends State<AREngineScene>
    with WidgetsBindingObserver {
  late MethodChannel _channel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return SizedBox(
        height: widget.height,
        width: widget.width,
        child: AndroidView(
          key: widget.key,
          viewType: Constants.VIEW_TYPE,
          onPlatformViewCreated: _onPlatformViewCreated,
          creationParams: widget.arSceneConfig.getARSceneConfig(),
          creationParamsCodec: const JSONMessageCodec(),
        ),
      );
    }
    return Text(
      '$defaultTargetPlatform ${widget.notSupportedText}',
      style: widget.notSupportedTextStyle,
    );
  }

  void _onPlatformViewCreated(int id) {
    if (widget.onArSceneCreated == null) {
      return;
    }
    _channel = MethodChannel(AR_SCENE_METHOD_CHANNEL + id.toString());
    widget.onArSceneCreated!(ARSceneController._(id, _channel));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class ARSceneController {
  final MethodChannel _channel;
  late ARTrackableCallback onDetectTrackable;
  late ARHandleMessageDataCallback handleMessageData;
  late ARHandleCameraConfigDataCallback handleCameraConfigData;
  late ARHandleCameraIntrinsicsDataCallback handleCameraIntrinsicsData;
  late ARHandleFaceHealthResultCallback handleResult;
  late ARSceneMeshDrawFrameCallback sceneMeshDrawFrame;

  ARSceneController._(
    int id,
    this._channel,
  ) {
    _channel
        .setMethodCallHandler((MethodCall call) => _onMethodCallHandler(call));
  }

  dynamic _onMethodCallHandler(MethodCall call) {
    switch (call.method) {
      case 'onDetectTrackable#Hand':
        _onDetectARHand(call);
        break;
      case 'onDetectTrackable#Face':
        _onDetectARFace(call);
        break;
      case 'onDetectTrackable#Body':
        _onDetectARBody(call);
        break;
      case 'onDetectTrackable#Plane':
        _onDetectARPlane(call);
        break;
      case 'onDetectTrackable#Cloud3DObject':
        _onDetectARPlane(call);
        break;
      case 'onDetectTrackable#AugmentedImage':
        _onDetectARAugmentedImage(call);
        break;
      case 'onDetectTrackable#WorldBody':
        _onDetectARBody(call);
        break;
      case 'onDetectTrackable#SceneMesh':
        _sceneMeshDrawFrame(call);
        break;
      case 'handleMessageData':
        handleMessageData(call.arguments);
        break;
      case 'handleCameraConfigData':
        _handleCameraConfigData(call);
        break;
      case 'handleCameraIntrinsicsData':
        _handleCameraIntrinsicsData(call);
        break;
      case 'handleResult':
        handleResult(call.arguments);
        break;
    }
  }

  void _onDetectARHand(MethodCall call) {
    ARHand arHand;
    try {
      if (call.arguments != null) {
        arHand = ARHand.fromJSON(call.arguments);
        onDetectTrackable(arHand);
      }
    } catch (e) {
      debugPrint('Cannot convert json arguments to ARHand. $e');
    }
  }

  void _onDetectARFace(MethodCall call) {
    ARFace arFace;
    try {
      if (call.arguments != null) {
        arFace = ARFace.fromJSON(call.arguments);
        onDetectTrackable(arFace);
      }
    } catch (e) {
      debugPrint('Cannot convert json arguments to ARFace. $e');
    }
  }

  void _onDetectARBody(MethodCall call) {
    ARBody arBody;
    try {
      if (call.arguments != null) {
        arBody = ARBody.fromJSON(call.arguments);
        onDetectTrackable(arBody);
      }
    } catch (e) {
      debugPrint('Cannot convert json arguments to ARBody. $e');
    }
  }

  void _onDetectARPlane(MethodCall call) {
    ARPlane arPlane;
    try {
      if (call.arguments != null) {
        arPlane = ARPlane.fromJSON(call.arguments);
        onDetectTrackable(arPlane);
      }
    } catch (e) {
      debugPrint('Cannot convert json arguments to ARPlane. $e');
    }
  }

  void _onDetectARAugmentedImage(MethodCall call) {
    ARAugmentdImage arAugmentdImage;
    try {
      if (call.arguments != null) {
        arAugmentdImage = ARAugmentdImage.fromJSON(call.arguments);
        onDetectTrackable(arAugmentdImage);
      }
    } catch (e) {
      debugPrint('Cannot convert json arguments to ARAugmentdImage. $e');
    }
  }

  void _handleCameraIntrinsicsData(MethodCall call) {
    ARCameraIntrinsics arCameraIntrinsics;
    try {
      if (call.arguments != null) {
        arCameraIntrinsics = ARCameraIntrinsics.fromJSON(call.arguments);
        handleCameraIntrinsicsData(arCameraIntrinsics);
      }
    } catch (e) {
      debugPrint('Cannot convert json arguments to ARCameraIntrinsics. $e');
    }
  }

  void _handleCameraConfigData(MethodCall call) {
    ARCameraConfig arCameraConfig;
    try {
      if (call.arguments != null) {
        arCameraConfig = ARCameraConfig.fromJSON(call.arguments);
        handleCameraConfigData(arCameraConfig);
      }
    } catch (e) {
      debugPrint('Cannot convert json arguments to ARCameraConfig. $e');
    }
  }

  void _sceneMeshDrawFrame(MethodCall call) {
    ARSceneMesh arSceneMesh;
    try {
      if (call.arguments != null) {
        arSceneMesh = ARSceneMesh.fromJSON(call.arguments);
        sceneMeshDrawFrame(arSceneMesh);
      }
    } catch (e) {
      debugPrint('Cannot convert json arguments to ARSceneMesh. $e');
    }
  }

  void dispose() async {
    _channel.invokeMethod('dispose');
  }
}
