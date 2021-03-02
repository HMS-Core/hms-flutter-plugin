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

import 'hms_card_info.dart';
import 'hms_cards.dart';

class GameCard extends StatefulWidget {
  final int idx;
  final Function(HMSCardInfo cardInfo, int idx) onTap;

  const GameCard({Key key, @required this.onTap, this.idx}) : super(key: key);

  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  HMSCardInfo cardInfo;

  Widget _buildLayout({Key key, Widget child, Color backgroundColor}) {
    return Container(
      key: key,
      height: MediaQuery.of(context).size.height / 12,
      width: MediaQuery.of(context).size.height / 12,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFFEFEFEF),
        border: Border.all(
          color: Color(0xFFC5C5C5),
        ),
      ),
      child: Center(
        child: child,
      ),
    );
  }

  Widget _buildFront() {
    return _buildLayout(
      key: ValueKey(true),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
              backgroundColor: Colors.transparent,
              maxRadius: 14,
              child: Image.asset(cardInfo.imageAssetPath)),
          Text(
            cardInfo.name,
            style: TextStyle(
              fontSize: 10.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRear() {
    return _buildLayout(
      key: ValueKey(false),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        maxRadius: 20,
        child: Image.asset(
          'assets/HuaweiLogo.png',
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cardInfo = HMSCards.of(context).cardInfos[widget.idx];

    Widget _buildAnimation() {
      return GestureDetector(
        key: widget.key,
        onTap: () {
          setState(() {
            if (!cardInfo.isFound) {
              HMSCards.of(context).cardInfos[widget.idx].selected = true;
            }
          });
          widget.onTap(cardInfo, widget.idx);
        },
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 600),
          child: cardInfo.isFound
              ? _buildFront()
              : cardInfo.selected ? _buildFront() : _buildRear(),
        ),
      );
    }

    return Container(
      child: Center(
          child: Container(
        constraints: BoxConstraints.tight(Size.square(200.0)),
        child: _buildAnimation(),
      )),
    );
  }
}
