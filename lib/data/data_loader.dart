import 'package:flutter/material.dart';


// rootBundle.loadString('assets/depth.json').then((result) {
//       final parseJson = json.decode(result);
      // final tick = parseJson['tick'] as Map<String, dynamic>;
      // final List<DepthEntity> bids = (tick['bids'] as List<dynamic>)
      //     .map<DepthEntity>(
      //         (item) => DepthEntity(item[0] as double, item[1] as double))
      //     .toList();
      // final List<DepthEntity> asks = (tick['asks'] as List<dynamic>)
      //     .map<DepthEntity>(
      //         (item) => DepthEntity(item[0] as double, item[1] as double))
      //     .toList();
      // initDepth(bids, asks);
    // });


    Widget buildButtons() {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: <Widget>[
        // button("Candle", onPressed: () {
        //   if (isCandle != true && isLine == true) {
        //     setState(() {
        //       isLine = false;
        //       isCandle = true;
        //     });
        //   }
        // }),
        // button("Line", onPressed: () {
        //   if (isLine != true && isCandle == true) {
        //     setState(() {
        //       isCandle = false;
        //       isLine = true;
        //     });
        //   }
        // }),
        // button("TrendLine", onPressed: () => _isTrendLine = !_isTrendLine),
        // button("Line:MA", onPressed: () {
        //   _mainState = MainState.MA;
        // }),
        // button("Line:BOLL", onPressed: () => _mainState = MainState.BOLL),
        // button("Hide Line", onPressed: () => _mainState = MainState.NONE),
        // button("Secondary Chart:MACD",
        //     onPressed: () => _secondaryState = SecondaryState.MACD),
        // button("Secondary Chart:KDJ",
        //     onPressed: () => _secondaryState = SecondaryState.KDJ),
        // button("Secondary Chart:RSI",
        //     onPressed: () => _secondaryState = SecondaryState.RSI),
        // button("Secondary Chart:WR",
        //     onPressed: () => _secondaryState = SecondaryState.WR),
        // button("Secondary Chart:CCI",
        //     onPressed: () => _secondaryState = SecondaryState.CCI),
        // button("Secondary Chart:Hide",
        //     onPressed: () => _secondaryState = SecondaryState.NONE),
        // button(_volHidden ? "Show Vol" : "Hide Vol",
        //     onPressed: () => _volHidden = !_volHidden),
        // // button("Change Language", onPressed: () => isChinese = !isChinese),
        // button(_hideGrid ? "Show Grid" : "Hide Grid",
        //     onPressed: () => _hideGrid = !_hideGrid),
        // button(_showNowPrice ? "Hide Now Price" : "Show Now Price",
        //     onPressed: () => _showNowPrice = !_showNowPrice),
        // button("Customize UI", onPressed: () {
        //   setState(() {
        //     this.isChangeUI = !this.isChangeUI;
        //     if (this.isChangeUI) {
        //       chartColors.selectBorderColor = Colors.red;
        //       chartColors.selectFillColor = Colors.red;
        //       chartColors.lineFillColor = Colors.red;
        //       chartColors.kLineColor = Colors.yellow;
        //     } else {
        //       chartColors.selectBorderColor = Color(0xff6C7A86);
        //       chartColors.selectFillColor = Color(0xff0D1722);
        //       chartColors.lineFillColor = Color(0x554C86CD);
        //       chartColors.kLineColor = Color(0xff4C86CD);
        //     }
        //   });
        // }),
        // button("Change PriceTextPaint",
        //     onPressed: () => setState(() {
        //           _priceLeft = !_priceLeft;
        //           if (_priceLeft) {
        //             _verticalTextAlignment = VerticalTextAlignment.left;
        //           } else {
        //             _verticalTextAlignment = VerticalTextAlignment.right;
        //           }
        //         })),
      ],
    );
  }




// final List<DepthEntity> bids = (tick['bids'] as List<dynamic>)
      //     .map<DepthEntity>(
      //         (item) => DepthEntity(item[0] as double, item[1] as double))
      //     .toList();
      // final List<DepthEntity> asks = (tick['asks'] as List<dynamic>)
      //     .map<DepthEntity>(
      //         (item) => DepthEntity(item[0] as double, item[1] as double))
      //     .toList();
      // initDepth(bids, asks);



// void initDepth(List<DepthEntity>? bids, List<DepthEntity>? asks) {
  //   if (bids == null || asks == null || bids.isEmpty || asks.isEmpty) return;
  //   _bids = [];
  //   _asks = [];
  //   double amount = 0.0;
  //   bids.sort((left, right) => left.price.compareTo(right.price));
  //   for (var item in bids.reversed) {
  //     amount += item.vol;
  //     item.vol = amount;
  //     _bids!.insert(0, item);
  //   }

  //   amount = 0.0;
  //   asks.sort((left, right) => left.price.compareTo(right.price));
  //   for (var item in asks) {
  //     amount += item.vol;
  //     item.vol = amount;
  //     _asks!.add(item);
  //   }
  //   setState(() {});
  // }








 // if (_bids != null && _asks != null)
        //   Container(
        //     height: 130,
        //     width: double.infinity,
        //     child: DepthChart(_bids!, _asks!, chartColors),
        //   )