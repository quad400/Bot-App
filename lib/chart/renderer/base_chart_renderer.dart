import 'dart:ui';

import 'package:flutter/material.dart';

export '../model/chart_style.dart';

abstract class BaseChartRenderer<T> {
  double maxValue, minValue;
  late double scaleY;
  double topPadding;
  Rect chartRect;
  int fixedLength;
  Paint chartPaint = Paint()
    ..isAntiAlias = true
    ..filterQuality = FilterQuality.high
    ..strokeWidth = 1
    ..color = Colors.red;
    Paint chartPoint = Paint()
    ..isAntiAlias = true
    ..filterQuality = FilterQuality.high
    ..strokeWidth = 3
    ..color = Colors.red;
  Paint gridPaint = Paint()
    ..isAntiAlias = true
    ..filterQuality = FilterQuality.high
    ..strokeWidth = 0.5
    ..color = const Color(0xff4c5c74);

  BaseChartRenderer({
    required this.chartRect,
    required this.maxValue,
    required this.minValue,
    required this.topPadding,
    required this.fixedLength,
    required Color gridColor,
  }) {
    if (maxValue == minValue) {
      maxValue *= 1.5;
      minValue /= 2;
    }
    scaleY = chartRect.height / (maxValue - minValue);
    gridPaint.color = gridColor;
    // print("maxValue=====" + maxValue.toString() + "====minValue===" + minValue.toString() + "==scaleY==" + scaleY.toString());
  }

  double getY(double y) => (maxValue - y) * scaleY + chartRect.top;

  String format(double? n) {
    if (n == null || n.isNaN) {
      return '0.00';
    } else {
      return n.toStringAsFixed(fixedLength);
    }
  }

  void drawGrid(Canvas canvas, int gridRows, int gridColumns);

  void drawText(Canvas canvas, T data, double x);

  void drawVerticalText(canvas, textStyle, int gridRows);

  void drawChart(T lastPoint, T curPoint, double lastX, double curX, Size size,
      Canvas canvas);

  void drawLine(double? lastPrice, double? curPrice, Canvas canvas,
      double lastX, double curX, Color color) {
    if (lastPrice == null || curPrice == null) {
      return;
    }
    // print('lasePrice==$lastPrice==curPrice==$curPrice');
    double lastY = getY(lastPrice);
    double curY = getY(curPrice);
    // print('lastX-----==$lastX==lastY==$lastY==curX==$curX==curY==$curY');
    canvas.drawLine(
        Offset(lastX, lastY), Offset(curX, curY), chartPaint..color = color);
  }

  void drawPoint(
    double? lastPrice,
    Canvas canvas,
    double lastX,
    Color color,
  ) {
    if (lastPrice == null) {
      return;
    }
    double lastY = getY(lastPrice);

    canvas.drawPoints(
        PointMode.points, [Offset(lastX, lastY)], chartPoint..color = color);
  }

  TextStyle getTextStyle(Color color) {
    return TextStyle(fontSize: 10.0, color: color);
  }
}
