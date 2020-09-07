/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:huawei_ml/utils/ml_border.dart';

class MlProductVisionSearch {
  String type;
  MlBorder border;
  ProductList productList;

  MlProductVisionSearch({this.productList, this.border, this.type});

  MlProductVisionSearch.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? null;
    border =
        json['border'] != null ? new MlBorder.fromJson(json['border']) : null;
    productList = json['productList'] != null
        ? new ProductList.fromJson(json['productList'])
        : null;
  }
}

class ProductList {
  dynamic possibility;
  String productId;
  ImageList imageList;

  ProductList({this.imageList, this.possibility, this.productId});

  ProductList.fromJson(Map<String, dynamic> json) {
    possibility = json['possibility'] ?? null;
    productId = json['productId'] ?? null;
    imageList = json['imageList'] != null
        ? new ImageList.fromJson(json['imageList'])
        : null;
  }
}

class ImageList {
  dynamic possibility;
  String imageId;
  String productId;

  ImageList({this.productId, this.possibility, this.imageId});

  ImageList.fromJson(Map<String, dynamic> json) {
    possibility = json['possibility'] ?? null;
    imageId = json['imageId'] ?? null;
    productId = json['productId'] ?? null;
  }
}
