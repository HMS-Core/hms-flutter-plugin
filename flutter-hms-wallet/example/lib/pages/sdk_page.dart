/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.
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
import 'package:huawei_wallet_example/pages/coupon_card_page.dart';
import 'package:huawei_wallet_example/pages/gift_card_page.dart';
import 'package:huawei_wallet_example/pages/loyalty_card_page.dart';

class SdkPage extends StatefulWidget {
  const SdkPage({Key? key}) : super(key: key);

  @override
  State<SdkPage> createState() => _SdkPageState();
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
        children: <Widget>[
          DropdownButton<int>(
            hint: const Text('Status'),
            value: environment,
            onChanged: (int? newValue) {
              if (newValue != null) {
                setState(() => environment = newValue);
              }
            },
            items: <int>[0, 1, 2, 3, 4, 5].map<DropdownMenuItem<int>>(
              (int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(environmentName(value)),
                );
              },
            ).toList(),
          ),
          MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: Colors.grey,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<dynamic>(
                  builder: (_) => LoyaltyCardPage(
                    environment: environment,
                  ),
                ),
              );
            },
            child: const Text('Add Loyalty Card'),
          ),
          MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: Colors.grey,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<dynamic>(
                  builder: (_) => GiftCardPage(
                    environment: environment,
                  ),
                ),
              );
            },
            child: const Text('Add Gift Card'),
          ),
          MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: Colors.grey,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<dynamic>(
                  builder: (_) => CouponCardPage(
                    environment: environment,
                  ),
                ),
              );
            },
            child: const Text('Add Coupon Card'),
          ),
        ],
      ),
    );
  }

  String environmentName(int value) {
    switch (value) {
      case 0:
        return 'Russian debug environment';
      case 1:
        return 'Russian production environment';
      case 2:
        return 'European debug environment';
      case 3:
        return 'European production environment';
      case 4:
        return 'African debug environment';
      case 5:
        return 'African production environment';
      default:
        return '';
    }
  }
}
