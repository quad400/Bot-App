// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ChartColors {
  // Background Color
  List<Color> bgBlackColor = [Color(0xff18191d), Color(0xff18191d)];
  List<Color> bgWhiteColor = [Colors.white, Colors.white70.withOpacity(0.1)];

  Color kLineColor = Color(0xff4C86CD);
  Color lineFillColor = Color(0x554C86CD);
  Color lineFillInsideColor = Color(0x00000000);

// Candle stick
  Color upColor = Color(0xff4DAA90);
  Color dnColor = Color(0xffC15466);

// Moving Average
  Color maColor = Color(0xff6CB0A6);
  Color ma5Color = Color(0xffC9B885);
  Color ma10Color = Color(0xff6CB0A6);
  Color ma30Color = Color(0xff9979C6);

  // Volume
  Color volColor = Color(0xff4729AE);

  // MACD
  Color macdColor = Color(0xff4729AE);
  Color difColor = Color(0xffC9B885);
  Color deaColor = Color(0xff6CB0A6);

  // KDJ
  Color kColor = Color(0xffC9B885);
  Color dColor = Color(0xff6CB0A6);
  Color jColor = Color(0xff9979C6);

  // RSI



  



  Color defaultTextColor = Color(0xff60738E);

  Color nowPriceUpColor = Color(0xff4DAA90);
  Color nowPriceDnColor = Color(0xffC15466);
  Color nowPriceTextColor = Color(0xffffffff);

  Color depthBuyColor = Color(0xff60A893);
  Color depthSellColor = Color(0xffC15866);

  Color selectBorderColor = Color(0xff6C7A86);

  Color selectFillColor = Color(0xff0D1722);

  // Color gridColor = Color(0xff4c5c74);
  Color gridColor = Colors.grey.shade400;

  Color infoWindowNormalColor = Color(0xffffffff);
  Color infoWindowTitleColor = Color(0xffffffff);
  Color infoWindowUpColor = Color(0xff00ff00);
  Color infoWindowDnColor = Color(0xffff0000);

  Color hCrossColor = Color(0xffffffff);
  Color vCrossColor = Color(0xffffffff);
  // Color hCrossColor = Colors.black54;
  // Color vCrossColor = Colors.black54;
  Color crossTextColor = Color(0xffffffff);

  Color maxColor = Color(0xffffffff);
  Color minColor = Color(0xffffffff);

  Color getMAColor(int index) {
    switch (index) {
      case 1:
        return ma10Color;
      case 2:
        return ma30Color;
      case 3:
        return upColor;
      case 4:
        return dnColor;
      default:
        return ma5Color;
    }
  }
}

class ChartStyle {
  double topPadding = 30.0;

  double bottomPadding = 20.0;

  double childPadding = 12.0;

  //点与点的距离
  double pointWidth = 11.0;

  //蜡烛宽度
  double candleWidth = 8.5;

  //蜡烛中间线的宽度
  double candleLineWidth = 1.5;

  //vol柱子宽度
  double volWidth = 8.5;

  //macd柱子宽度
  double macdWidth = 3.0;

  //垂直交叉线宽度
  double vCrossWidth = 1.0;

  //水平交叉线宽度
  double hCrossWidth = 1.0;

  //现在价格的线条长度
  double nowPriceLineLength = 1;

  //现在价格的线条间隔
  double nowPriceLineSpan = 1;

  //现在价格的线条粗细
  double nowPriceLineWidth = 1;

  int gridRows = 4;

  int gridColumns = 4;

  //下方時間客製化
  List<String>? dateTimeFormat;

  double width1 = 1;
  double width2 = 1.5;
  double width3 = 2;
  double width4 = 2.5;

  double getWidth(StrokeWidth index) {
    switch (index) {
      case StrokeWidth.one:
        return width1;
      case StrokeWidth.two:
        return width2;
      case StrokeWidth.three:
        return width3;
      case StrokeWidth.four:
        return width4;
      default:
        return width1;
    }
  }
}

enum StrokeWidth { one, two, three, four }
