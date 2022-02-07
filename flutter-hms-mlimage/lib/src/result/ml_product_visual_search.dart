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

import '../../huawei_ml_image.dart';

class MlProductVisualSearch {
  List<MLVisionSearchProduct?>? productList;
  MLImageBorder? border;
  String? type;

  MlProductVisualSearch({this.border, this.type, this.productList});

  factory MlProductVisualSearch.fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return MlProductVisualSearch();
    }

    var products = List<MLVisionSearchProduct>.empty(growable: true);

    if (map['productList'] != null) {
      map['productList'].forEach((v) {
        products.add(MLVisionSearchProduct.fromMap(v));
      });
    }

    return MlProductVisualSearch(
        border:
            map['border'] != null ? MLImageBorder.fromMap(map['border']) : null,
        type: map['type'] ?? null,
        productList: products);
  }
}

class MLVisionSearchProduct {
  List<MLVisionSearchProductImage?>? imageList;
  String? customContent;
  String? productId;
  String? productUrl;

  MLVisionSearchProduct(
      {this.productId, this.productUrl, this.customContent, this.imageList});

  factory MLVisionSearchProduct.fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return MLVisionSearchProduct();
    }

    var images = List<MLVisionSearchProductImage>.empty(growable: true);

    if (map['imageList'] != null) {
      map['imageList'].forEach((v) {
        images.add(MLVisionSearchProductImage.fromMap(v));
      });
    }

    return MLVisionSearchProduct(
        customContent: map['customContent'] ?? null,
        productId: map['productId'] ?? null,
        productUrl: map['productUrl'] ?? null,
        imageList: images);
  }
}

class MLVisionSearchProductImage {
  double? possibility;
  String? imageId;
  String? productId;

  MLVisionSearchProductImage({this.possibility, this.imageId, this.productId});

  factory MLVisionSearchProductImage.fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return MLVisionSearchProductImage();
    }

    return MLVisionSearchProductImage(
        possibility: map['possibility'] ?? null,
        imageId: map['imageId'] ?? null,
        productId: map['productId'] ?? null);
  }
}

class MLProductCaptureResult {
  String? imageUrl;
  String? id;
  String? other;

  MLProductCaptureResult({this.id, this.imageUrl, this.other});

  factory MLProductCaptureResult.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return MLProductCaptureResult();
    }

    return MLProductCaptureResult(
        imageUrl: json['imgUrl'] ?? null,
        id: json['id'],
        other: json['other'] ?? null);
  }
}
