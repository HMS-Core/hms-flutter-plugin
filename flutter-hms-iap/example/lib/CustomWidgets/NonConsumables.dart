/*
 * Copyright 2020-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:developer' show log;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:huawei_iap/huawei_iap.dart';

class NonConsumables extends StatefulWidget {
  @override
  _NonConsumablesState createState() => _NonConsumablesState();
}

class _NonConsumablesState extends State<NonConsumables> {
  List<ProductInfo> available = <ProductInfo>[];
  List<InAppPurchaseData> purchased = <InAppPurchaseData>[];

  @override
  void initState() {
    super.initState();
    loadProducts();
    ownedPurchases();
  }

  void loadProducts() async {
    try {
      ProductInfoResult result = await IapClient.obtainProductInfo(
        ProductInfoReq(
          priceType: 1,
          // Make sure that the product IDs are the same as those defined in AppGallery Connect.
          skuIds: <String>['non_consumable_1', 'non_consumable_2'],
        ),
      );
      setState(() {
        available.clear();
        if (result.productInfoList != null)
          for (int i = 0; i < result.productInfoList!.length; i++) {
            available.add(result.productInfoList![i]);
          }
      });
    } on PlatformException catch (e) {
      if (e.code == HmsIapResults.ORDER_HWID_NOT_LOGIN.resultCode) {
        log(HmsIapResults.ORDER_HWID_NOT_LOGIN.resultMessage!);
      } else {
        log(e.toString());
      }
    }
  }

  void buyProduct(String productID) async {
    try {
      PurchaseResultInfo result = await IapClient.createPurchaseIntent(
        PurchaseIntentReq(priceType: 1, productId: productID),
      );
      if (result.returnCode == HmsIapResults.ORDER_STATE_SUCCESS.resultCode) {
        loadProducts();
        ownedPurchases();
      } else {
        if (result.errMsg != null)
          log(result.errMsg!);
        else
          log(result.rawValue);
      }
    } on PlatformException catch (e) {
      if (e.code == HmsIapResults.ORDER_HWID_NOT_LOGIN.resultCode) {
        log(HmsIapResults.ORDER_HWID_NOT_LOGIN.resultMessage!);
      } else {
        log(e.toString());
      }
    }
  }

  void ownedPurchases() async {
    try {
      OwnedPurchasesResult result =
          await IapClient.obtainOwnedPurchases(OwnedPurchasesReq(priceType: 1));
      setState(() {
        purchased.clear();
        if (result.inAppPurchaseDataList != null)
          for (int i = 0; i < result.inAppPurchaseDataList!.length; i++) {
            purchased.add(result.inAppPurchaseDataList![i]);
          }
      });
    } on PlatformException catch (e) {
      if (e.code == HmsIapResults.ORDER_HWID_NOT_LOGIN.resultCode) {
        log(HmsIapResults.ORDER_HWID_NOT_LOGIN.resultMessage!);
      } else {
        log(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Non Consumables',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Non-Consumables are purchased once and do not expire or decrease.',
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                'Purchased',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )
            ],
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: purchased.length,
            itemBuilder: (BuildContext ctxt, int i) {
              return Card(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        purchased[i].productName ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(purchased[i].productId ?? ''),
                    )
                  ],
                ),
              );
            },
          ),
          Row(
            children: <Widget>[
              Text(
                'Available',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )
            ],
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: available.length,
            itemBuilder: (BuildContext ctxt, int i) {
              return InkWell(
                onTap: () {
                  if (available[i].productId != null)
                    buyProduct(available[i].productId!);
                  else
                    log('Please provide valid product id.');
                },
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          available[i].productName ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(available[i].productDesc ?? ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(available[i].price ?? ''),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          Row(
            children: <Widget>[
              Text(
                'Purchased Record - Last 5',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )
            ],
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(23.0),
              child: Text(
                'For non-consumables, this method does not return product information.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
