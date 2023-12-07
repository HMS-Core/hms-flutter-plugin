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

class HmsScanUtils {
  static Future<ScanResponse> startDefaultView(
    DefaultViewRequest request,
  ) async {
    final ScanResponse result = ScanResponse.fromJson(
      await HmsScan.instance.scanUtilsChannel.invokeMethod(
        'defaultView',
        request.toMap(),
      ),
    );
    return result;
  }

  static Future<Image> buildBitmap(BuildBitmapRequest request) async {
    final Uint8List uInt8list =
        await HmsScan.instance.scanUtilsChannel.invokeMethod(
      'buildBitmap',
      request.toMap(),
    );
    return imageFromUInt8List(uInt8list);
  }

// Returns Image from Uint8List
  static Image imageFromUInt8List(Uint8List data) {
    return Image.memory(data);
  }

  static Future<ScanResponseList> decodeWithBitmap(DecodeRequest request) async {
    final ScanResponseList result = ScanResponseList.fromJson(
      await HmsScan.instance.scanUtilsChannel.invokeMethod(
        'decodeWithBitmap',
        request.toMap(),
      ),
    );
    return result;
  }

  static Future<ScanResponseList> decode(DecodeRequest request) async {
    final ScanResponseList result = ScanResponseList.fromJson(
      await HmsScan.instance.scanUtilsChannel.invokeMethod(
        'decode',
        request.toMap(),
      ),
    );
    return result;
  }

  //HMS Logger
  static Future<void> disableLogger() async {
    await HmsScan.instance.scanUtilsChannel.invokeMethod('disableLogger');
  }

  static Future<void> enableLogger() async {
    await HmsScan.instance.scanUtilsChannel.invokeMethod('enableLogger');
  }
}
