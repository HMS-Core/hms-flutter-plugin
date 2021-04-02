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
import 'package:flutter/services.dart';
import 'package:huawei_wallet/huawei_wallet.dart';
import 'package:huawei_wallet_example/pages/pass/pass_action_page.dart';
import 'package:huawei_wallet_example/utils/utils.dart';

class CouponCardPage extends StatefulWidget {
  final int environment;

  const CouponCardPage({Key key, this.environment}) : super(key: key);
  @override
  _CouponCardPageState createState() => _CouponCardPageState();
}

class _CouponCardPageState extends State<CouponCardPage> {
  String status = 'ACTIVE';
  DateTime lastBalanceDate = DateTime(2021, 1, 1);
  DateTime startDate = DateTime(2020, 1, 12);
  DateTime endDate = DateTime(2022, 1, 12);

  TextEditingController passTypeIdController = TextEditingController.fromValue(
    TextEditingValue(text: Constants.passTypeIdCoupon),
  );
  TextEditingController passStyleIdController = TextEditingController.fromValue(
    TextEditingValue(text: Constants.passStyleIdCoupon),
  );
  TextEditingController serialNumberController =
      TextEditingController.fromValue(
    TextEditingValue(text: Utils.getRandomNumber(12)),
  );
  TextEditingController cardLogoController = TextEditingController.fromValue(
    TextEditingValue(
      text:
          'https://contentcenter-drcn.dbankcdn.com/cch5/Wallet-WalletKit/picres/cloudRes/coupon_logo.png',
    ),
  );
  TextEditingController merchantNameController =
      TextEditingController.fromValue(
    TextEditingValue(text: 'Merchant Name'),
  );
  TextEditingController cardNameController = TextEditingController.fromValue(
    TextEditingValue(text: 'Coupon Name'),
  );
  TextEditingController cardNumberController = TextEditingController.fromValue(
    TextEditingValue(text: Utils.getRandomNumber(6)),
  );
  TextEditingController backgroundColorController =
      TextEditingController.fromValue(
    TextEditingValue(text: '#FF483D8B'),
  );
  TextEditingController barValController = TextEditingController.fromValue(
    TextEditingValue(text: '1234567890'),
  );
  TextEditingController barTextController = TextEditingController.fromValue(
    TextEditingValue(text: '123456789123456'),
  );
  TextEditingController eventNumberController = TextEditingController.fromValue(
    TextEditingValue(text: '0'),
  );
  TextEditingController messageHeaderController =
      TextEditingController.fromValue(
    TextEditingValue(text: 'Message'),
  );
  TextEditingController messageInfoController = TextEditingController.fromValue(
    TextEditingValue(text: 'Welcome to use Coupon Card.'),
  );
  TextEditingController bannerURIController = TextEditingController.fromValue(
    TextEditingValue(
      text:
          'https://contentcenter-drcn.dbankcdn.com/cch5/wallet/HiWallet/cloudRes/ic_empty_traffic.png',
    ),
  );
  TextEditingController bannerURIDescController =
      TextEditingController.fromValue(
    TextEditingValue(text: 'Rotation Chart'),
  );
  TextEditingController uriLabelController = TextEditingController();
  TextEditingController uriValueController = TextEditingController();
  TextEditingController nearbyLabelController = TextEditingController.fromValue(
    TextEditingValue(text: 'Nearby Location'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Gift Card'),
      ),
      body: ListView(
        children: [
          TextField(
            controller: serialNumberController,
            decoration: InputDecoration(labelText: 'Serial Number'),
          ),
          TextField(
            controller: passStyleIdController,
            decoration: InputDecoration(labelText: 'Template - Style Id'),
          ),
          TextField(
            controller: passTypeIdController,
            decoration: InputDecoration(labelText: 'Pass Type'),
          ),
          TextField(
            // 2
            controller: cardLogoController,
            decoration: InputDecoration(labelText: 'Logo Uri'),
          ),
          TextField(
            // 3
            controller: merchantNameController,
            decoration: InputDecoration(labelText: 'Merchant Name'),
          ),
          TextField(
            // 4
            controller: cardNameController,
            decoration: InputDecoration(labelText: 'Card Name'),
          ),
          TextField(
            // 5
            controller: cardNumberController,
            decoration: InputDecoration(labelText: 'Gift Card Number'),
          ),
          TextField(
            // 8
            controller: backgroundColorController,
            decoration:
                InputDecoration(labelText: 'Hex Background Color for Coupon'),
          ),
          TextField(
            // 10
            controller: barValController,
            decoration: InputDecoration(labelText: 'Barcode Value'),
          ),
          TextField(
            // 10
            controller: barTextController,
            decoration: InputDecoration(labelText: 'Barcode Text'),
          ),
          TextField(
            // 13
            controller: eventNumberController,
            decoration: InputDecoration(labelText: 'Evenet Number'),
          ),
          TextField(
            // 14
            controller: messageHeaderController,
            decoration: InputDecoration(labelText: 'Message Header'),
          ),
          TextField(
            // 14
            controller: messageInfoController,
            decoration: InputDecoration(labelText: 'Message Info'),
          ),
          TextField(
            // 15
            controller: bannerURIController,
            decoration: InputDecoration(labelText: 'Banner URI'),
          ),
          TextField(
            // 15
            controller: bannerURIDescController,
            decoration: InputDecoration(labelText: 'Banner URI Description'),
          ),
          TextField(
            // 15
            controller: uriLabelController,
            decoration: InputDecoration(labelText: 'URL Label'),
          ),
          TextField(
            // 15
            controller: uriValueController,
            decoration: InputDecoration(labelText: 'URL Value'),
          ),
          TextField(
            // 16
            controller: nearbyLabelController,
            decoration: InputDecoration(labelText: 'Nearby Location Label'),
          ),
          DropdownButton<String>(
            hint: Text('Status'),
            value: status,
            onChanged: (String newValue) {
              setState(() {
                status = newValue;
              });
            },
            items: <String>['ACTIVE', 'COMPLETED', 'EXPIRED', 'INACTIVE']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ListTile(
            subtitle: Text('Last Balance Update Date'),
            title: Text(lastBalanceDate?.toIso8601String() ?? ''),
            onTap: () async {
              lastBalanceDate = await showDatePicker(
                context: context,
                initialDate: lastBalanceDate ?? DateTime.now(),
                firstDate: DateTime.utc(2000),
                lastDate: DateTime.utc(2050),
              );
              setState(() {});
            },
          ),
          ListTile(
            subtitle: Text('Start Date'),
            title: Text(startDate?.toIso8601String() ?? ''),
            onTap: () async {
              startDate = await showDatePicker(
                context: context,
                initialDate: startDate ?? DateTime.now(),
                firstDate: DateTime.utc(2000),
                lastDate: DateTime.utc(2050),
              );
              setState(() {});
            },
          ),
          ListTile(
            subtitle: Text('End Date'),
            title: Text(endDate?.toIso8601String() ?? ''),
            onTap: () async {
              endDate = await showDatePicker(
                context: context,
                initialDate: endDate ?? DateTime.now(),
                firstDate: DateTime.utc(2000),
                lastDate: DateTime.utc(2050),
              );
              setState(() {});
            },
          ),
          const SizedBox(height: 32),
          MaterialButton(
            child: Text('Save Card'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PassActionPage(
                    passObject: getPassObject(),
                    environment: widget.environment,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  PassObject getPassObject() {
    return PassObject(
      serialNumber: serialNumberController.text,
      passStyleIdentifier: passStyleIdController.text,
      passTypeIdentifier: passTypeIdController.text,
      organizationPassId: cardNumberController.text,
      status: PassStatus(
        state: status.toLowerCase(),
        effectTime: '${startDate?.toIso8601String()}Z',
        expireTime: '${endDate?.toIso8601String()}Z',
      ),
      barCode: BarCode(
        type: BarCode.barcodeTypeQrCode,
        text: barTextController.text,
        value: barValController.text,
      ),
      commonFields: [
        CommonField(
          key: WalletPassConstant.passAppendFieldKeyBackgroundColor,
          label: 'backgroundColorLable',
          value: backgroundColorController.text,
        ),
        CommonField(
          key: WalletPassConstant.passCommonFieldKeyLogo,
          label: 'cardLogoLable',
          value: cardLogoController.text,
        ),
        CommonField(
          key: WalletPassConstant.passCommonFieldKeyMerchantName,
          label: 'merchantNameLable',
          value: merchantNameController.text,
        ),
        CommonField(
          key: WalletPassConstant.passCommonFieldKeyName,
          label: 'cardNameLable',
          value: cardNameController.text,
        ),
        CommonField(
          key: WalletPassConstant.passCommonFieldKeyCardNumber,
          label: 'cardNumberLable',
          value: cardNumberController.text,
        ),
      ],
      messageList: [
        AppendField(
          key: '1',
          label: messageHeaderController.text,
          value: messageInfoController.text,
        ),
      ],
      imageList: [
        AppendField(
          key: '1',
          label: bannerURIDescController.text,
          value: bannerURIController.text,
        ),
      ],
      urlList: [
        AppendField(
          key: '1',
          label: uriLabelController.text,
          value: uriValueController.text,
        ),
      ],
    );
  }
}
