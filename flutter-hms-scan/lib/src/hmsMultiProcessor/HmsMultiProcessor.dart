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

part of huawei_scan;

class HmsMultiProcessor {
  //Constants
  static const int MPSyncMode = 444;
  static const int MPAsyncMode = 555;

  static MultiCameraRequest? multiCameraRequest;

  static Future<dynamic> multiMethodCallHandler(MethodCall call) async {
    if (call.method == 'MultiProcessorResponse') {
      ScanResponse response = ScanResponse.fromJson(call.arguments);
      HmsMultiProcessor.multiCameraRequest?.multiCameraListener?.call(response);
    }
  }

  static Future<ScanResponseList> decodeMultiSync(DecodeRequest request) async {
    ScanResponseList result = ScanResponseList.fromJson(
      await HmsScan.instance.multiProcessorChannel.invokeMethod(
        'decodeMultiSync',
        request.toMap(),
      ),
    );
    return result;
  }

  static Future<ScanResponseList> decodeMultiAsync(
    DecodeRequest request,
  ) async {
    ScanResponseList result = ScanResponseList.fromJson(
      await HmsScan.instance.multiProcessorChannel.invokeMethod(
        'decodeMultiAsync',
        request.toMap(),
      ),
    );
    return result;
  }

  static Future<ScanResponseList> startMultiProcessorCamera(
    MultiCameraRequest request,
  ) async {
    multiCameraRequest = request;
    final ScanResponseList result = ScanResponseList.fromJson(
      await HmsScan.instance.multiProcessorChannel.invokeMethod(
        'multiProcessorCamera',
        request.toMap(),
      ),
    );
    multiCameraRequest = null;
    return result;
  }
}
