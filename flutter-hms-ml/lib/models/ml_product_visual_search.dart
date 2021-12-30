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

import 'package:huawei_ml/models/ml_border.dart';

class MlProductVisualSearch {
  List<MLVisionSearchProduct>? productList;
  MLBorder? border;
  String? type;

  MlProductVisualSearch({this.border, this.type, this.productList});

  MlProductVisualSearch.fromJson(Map<String, dynamic> json) {
    if (json['productList'] != null) {
      productList = <MLVisionSearchProduct>[];
      json['productList'].forEach((v) {
        productList?.add(new MLVisionSearchProduct.fromJson(v));
      });
    }
    border = json['border'] != null ? MLBorder.fromJson(json['border']) : null;
    type = json['type'] ?? null;
  }
}

class MLVisionSearchProduct {
  final List<MLVisionSearchProductImage>? imageList;
  final String? customContent;
  final dynamic possibility;
  final String? productId;
  final String? productUrl;

  MLVisionSearchProduct(
      {this.productId,
      this.possibility,
      this.productUrl,
      this.customContent,
      this.imageList});

  factory MLVisionSearchProduct.fromJson(Map<String, dynamic> json) {
    List<MLVisionSearchProductImage> _list = <MLVisionSearchProductImage>[];

    if (json['imageList'] != null) {
      json['imageList'].forEach((v) {
        _list.add(new MLVisionSearchProductImage.fromJson(v));
      });
    }
    return MLVisionSearchProduct(
        imageList: _list,
        customContent: json['customContent'],
        possibility: json['possibility'],
        productId: json['productId'],
        productUrl: json['productUrl']);
  }
}

class MLVisionSearchProductImage {
  double? possibility;
  String? imageId;
  String? productId;

  MLVisionSearchProductImage({this.possibility, this.imageId, this.productId});

  MLVisionSearchProductImage.fromJson(Map<String, dynamic> json) {
    possibility = json['possibility'] ?? null;
    imageId = json['imageId'] ?? null;
    productId = json['productId'] ?? null;
  }
}

class MLProductCaptureResult {
  String? imageUrl;
  String? id;
  String? other;

  MLProductCaptureResult({this.id, this.imageUrl, this.other});

  MLProductCaptureResult.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imgUrl'] ?? null;
    id = json['id'];
    other = json['other'] ?? null;
  }
}
