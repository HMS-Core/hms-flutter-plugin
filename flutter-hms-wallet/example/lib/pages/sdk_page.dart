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
import 'package:flutter/material.dart';
import 'package:huawei_wallet_example/pages/pass/loyalty_card_page.dart';
import 'package:huawei_wallet_example/pages/pass/gift_card_page.dart';
import 'package:huawei_wallet_example/pages/pass/coupon_card_page.dart';

class SdkPage extends StatefulWidget {
  @override
  _SdkPageState createState() => _SdkPageState();
}

class _SdkPageState extends State<SdkPage> {
  int environment = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to Huawei Wallet App'),
      ),
      body: ListView(
        children: [
          DropdownButton<int>(
            hint: Text('Status'),
            value: environment,
            onChanged: (int newValue) {
              setState(() {
                environment = newValue;
              });
            },
            items:
                <int>[0, 1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(environmentName(value)),
              );
            }).toList(),
          ),
          MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text('Add Loyalty Card'),
            color: Colors.grey,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => LoyaltyCardPage(
                    environment: environment,
                  ),
                ),
              );
            },
          ),
          MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text('Add Gift Card'),
            color: Colors.grey,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => GiftCardPage(
                    environment: environment,
                  ),
                ),
              );
            },
          ),
          MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text('Add Coupon Card'),
            color: Colors.grey,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CouponCardPage(
                    environment: environment,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String environmentName(int value) {
    switch (value) {
      case 0:
        return 'Russian debug environment';
        break;
      case 1:
        return 'Russian production environment';
        break;
      case 2:
        return 'European debug environment';
        break;
      case 3:
        return 'European production environment';
        break;
      case 4:
        return 'African debug environment';
        break;
      case 5:
        return 'African production environment';
        break;
      default:
        return '';
    }
  }
}
