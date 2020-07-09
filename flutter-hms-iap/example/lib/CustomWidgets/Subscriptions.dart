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
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_iap/IapClient.dart';
import 'package:huawei_iap/model/InAppPurchaseData.dart';
import 'package:huawei_iap/model/OwnedPurchasesReq.dart';
import 'package:huawei_iap/model/OwnedPurchasesResult.dart';
import 'package:huawei_iap/model/ProductInfo.dart';
import 'package:huawei_iap/model/ProductInfoReq.dart';
import 'package:huawei_iap/model/ProductInfoResult.dart';
import 'package:huawei_iap/model/PurchaseIntentReq.dart';
import 'package:huawei_iap/model/PurchaseResultInfo.dart';

class Subscriptions extends StatefulWidget {
  @override
  _SubscriptionsState createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  List<ProductInfo> available = [];
  List<InAppPurchaseData> purchased = [];
  List<InAppPurchaseData> purchasedRecord = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
    ownedPurchases();
    purchaseHistory();
  }

  loadProducts() async {
    try {
      ProductInfoResult result = await IapClient.obtainProductInfo(
          ProductInfoReq(priceType: 2, skuIds: ["p05", "p15"]));

      setState(() {
        available = [];
        for (int i = 0; i < result.productInfoList.length; i++) {
          available.add(result.productInfoList[i]);
        }
      });
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  buyProduct(String productID) async {
    try {
      PurchaseResultInfo result = await IapClient.createPurchaseIntent(
          PurchaseIntentReq(
              priceType: 2, developerPayload: "Test", productId: productID));
      loadProducts();
      ownedPurchases();
      purchaseHistory();
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  ownedPurchases() async {
    try {
      OwnedPurchasesResult result =
          await IapClient.obtainOwnedPurchases(OwnedPurchasesReq(priceType: 2));
      setState(() {
        purchased = [];
        for (int i = 0; i < result.inAppPurchaseDataList.length; i++) {
          purchased.add(result.inAppPurchaseDataList[i]);
        }
      });
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  purchaseHistory() async {
    try {
      OwnedPurchasesResult result = await IapClient.obtainOwnedPurchaseRecord(
          OwnedPurchasesReq(priceType: 2));
      setState(() {
        purchasedRecord = [];
        for (int i = 0; i < result.inAppPurchaseDataList.length; i++) {
          purchasedRecord.add(result.inAppPurchaseDataList[i]);
        }
      });
    } on PlatformException catch (e) {
      log(e.toString());
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
                "Subscriptions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Subscriptions are purchased once and renew automatically",
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                "Purchased",
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
                          purchased[i].productName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(purchased[i].productId),
                      )
                    ],
                  ),
                );
              }),
          Row(
            children: <Widget>[
              Text(
                "Available",
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
                    buyProduct(available[i].productId);
                  },
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            available[i].productName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(available[i].productDesc),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(available[i].price),
                        )
                      ],
                    ),
                  ),
                );
              }),
          Row(
            children: <Widget>[
              Text(
                "Purchased Record",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )
            ],
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: purchasedRecord.length,
              itemBuilder: (BuildContext ctxt, int i) {
                return Card(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          purchasedRecord[i].productName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(purchasedRecord[i].productId),
                      )
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
