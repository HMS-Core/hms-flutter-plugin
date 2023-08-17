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

class BuildBitmapRequest {
  String? content;
  int? type;
  int? width;
  int? height;
  int? margin;
  Color? bitmapColor;
  Color? backgroundColor;
  Uint8List? qrLogo;

  BuildBitmapRequest({
    this.content,
    this.type = HmsScanTypes.QRCode,
    this.width = 700,
    this.height = 700,
    this.margin = 1,
    this.bitmapColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.qrLogo,
  });

  factory BuildBitmapRequest.fromJson(String str) {
    return BuildBitmapRequest.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory BuildBitmapRequest.fromMap(Map<String, dynamic> json) {
    return BuildBitmapRequest(
      content: json['content'],
      type: json['type'],
      width: json['width'],
      height: json['height'],
      margin: json['margin'],
      bitmapColor:
          json['bitmapColor'] == null ? null : Color(json['bitmapColor']),
      backgroundColor:
          json['backgroundColor'] == null ? null : Color(json['bitmapColor']),
      qrLogo: json['qrLogo'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'type': type,
      'width': width,
      'height': height,
      'bitmapColor': bitmapColor?.value,
      'margin': margin,
      'backgroundColor': backgroundColor?.value,
      'qrLogo': qrLogo?.toString(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is BuildBitmapRequest &&
        other.content == content &&
        other.type == type &&
        other.width == width &&
        other.height == height &&
        other.bitmapColor == bitmapColor &&
        other.margin == margin &&
        other.backgroundColor == backgroundColor &&
        other.qrLogo == qrLogo;
  }

  @override
  int get hashCode {
    return Object.hash(
      content,
      type,
      width,
      height,
      bitmapColor,
      margin,
      backgroundColor,
      qrLogo,
    );
  }
}
