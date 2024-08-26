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

class Consumables extends StatefulWidget {
  @override
  _ConsumablesState createState() => _ConsumablesState();
}

class _ConsumablesState extends State<Consumables> {
  List<ProductInfo> available = <ProductInfo>[];
  List<InAppPurchaseData> purchased = <InAppPurchaseData>[];
  List<InAppPurchaseData> purchasedRecord = <InAppPurchaseData>[];

  @override
  void initState() {
    super.initState();
    loadProducts();
    ownedPurchases();
    purchaseHistory();
  }

  void loadProducts() async {
    try {
      ProductInfoResult result = await IapClient.obtainProductInfo(
        ProductInfoReq(
          priceType: IapClient.IN_APP_CONSUMABLE,
          //Make sure that the product IDs are the same as those defined in AppGallery Connect.
          skuIds: <String>['consumable_1', 'consumable_2'],
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
        PurchaseIntentReq(
          priceType: IapClient.IN_APP_CONSUMABLE,
          productId: productID,
          signatureAlgorithm:
              SignAlgorithmConstants.SIGNATURE_ALGORITHM_SHA256WITHRSA_PSS,
          reservedInfor: '{\"key1\":\"value1\",\"key2\":\"value2\"}',
        ),
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
      OwnedPurchasesResult result = await IapClient.obtainOwnedPurchases(
        OwnedPurchasesReq(
          priceType: IapClient.IN_APP_CONSUMABLE,
          signatureAlgorithm:
              SignAlgorithmConstants.SIGNATURE_ALGORITHM_SHA256WITHRSA_PSS,
        ),
      );
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

  void consumeItem(String purchaseToken) async {
    try {
      ConsumeOwnedPurchaseResult result = await IapClient.consumeOwnedPurchase(
        ConsumeOwnedPurchaseReq(
          purchaseToken: purchaseToken,
          signatureAlgorithm:
              SignAlgorithmConstants.SIGNATURE_ALGORITHM_SHA256WITHRSA_PSS,
        ),
      );
      if (result.returnCode == HmsIapResults.ORDER_STATE_SUCCESS.resultCode) {
        ownedPurchases();
        purchaseHistory();
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

  void purchaseHistory() async {
    try {
      OwnedPurchasesResult result = await IapClient.obtainOwnedPurchaseRecord(
        OwnedPurchasesReq(
          priceType: IapClient.IN_APP_CONSUMABLE,
          signatureAlgorithm:
              SignAlgorithmConstants.SIGNATURE_ALGORITHM_SHA256WITHRSA_PSS,
        ),
      );
      setState(() {
        purchasedRecord.clear();
        if (result.inAppPurchaseDataList != null)
          for (int i = 0; i < result.inAppPurchaseDataList!.length; i++) {
            purchasedRecord.add(result.inAppPurchaseDataList![i]);
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
                'Consumables',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Consumables are used once and depleted, and can be purchased again, for example, in-game currencies.',
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
              return InkWell(
                onTap: () {
                  if (purchased[i].purchaseToken != null)
                    consumeItem(purchased[i].purchaseToken!);
                  else
                    log('Please provide valid product id.');
                },
                child: Card(
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
                  buyProduct(available[i].productId ?? '');
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
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: purchasedRecord.length >= 5 ? 5 : purchasedRecord.length,
            itemBuilder: (BuildContext ctxt, int i) {
              return Card(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        purchasedRecord[i].productName ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(purchasedRecord[i].productId ?? ''),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
