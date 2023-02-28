import 'package:flutter/material.dart';
import 'package:frontend/chart/entity/index.dart';
import 'package:frontend/screens/chart_screen/pages/indicator_input.dart';

import '../model/k_chart_widget.dart' show MainState;
import 'base_chart_renderer.dart';

enum VerticalTextAlignment { left, right }

//For TrendLine
double? trendLineMax;
double? trendLineScale;
double? trendLineContentRec;

class MainRenderer extends BaseChartRenderer<CandleEntity> {
  late double mCandleWidth;
  late double mCandleLineWidth;
  MainState state;
  bool isLine;
  bool isCandle;

  late Rect _contentRect;
  final double _contentPadding = 5.0;
  List<int> maDayList;
  final ChartStyle chartStyle;
  final ChartColors chartColors;
  final IndicatorColor indicatorColor;
  final double mLineStrokeWidth = 1.0;
  double scaleX;
  late Paint mLinePaint;
  final VerticalTextAlignment verticalTextAlignment;

  MainRenderer(
      Rect mainRect,
      double maxValue,
      double minValue,
      double topPadding,
      this.state,
      this.isLine,
      this.isCandle,
      int fixedLength,
      this.chartStyle,
      this.chartColors,
      this.scaleX,
      this.verticalTextAlignment,
      this.indicatorColor,
      [this.maDayList = const [5, 10, 20]])
      : super(
          chartRect: mainRect,
          maxValue: maxValue,
          minValue: minValue,
          topPadding: topPadding,
          fixedLength: fixedLength,
          gridColor: chartColors.gridColor,
        ) {
    mCandleWidth = chartStyle.candleWidth;
    mCandleLineWidth = chartStyle.candleLineWidth;
    mLinePaint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = mLineStrokeWidth
      ..color = chartColors.kLineColor;
    _contentRect = Rect.fromLTRB(
        chartRect.left,
        chartRect.top + _contentPadding,
        chartRect.right,
        chartRect.bottom - _contentPadding);
    if (maxValue == minValue) {
      maxValue *= 1.5;
      minValue /= 2;
    }
    scaleY = _contentRect.height / (maxValue - minValue);
  }

  @override
  void drawText(Canvas canvas, CandleEntity data, double x) {
    if (isLine == true) return;
    TextSpan? span;
    if (state == MainState.MA) {
      span = TextSpan(
          // children: _createMATextSpan(data),
          children: [
            if (data.movingAverage != 0)
              TextSpan(
                  text: 'MA: ${format(data.movingAverage)}',
                  style: getTextStyle(indicatorColor.maColor))
          ]);
    } else if (state == MainState.BOLL) {
      span = TextSpan(
        children: [
          if (data.bollingerBandsUpper != 0)
            TextSpan(
                text: 'UB:${format(data.bollingerBandsUpper)}    ',
                style: getTextStyle(chartColors.ma5Color)),
          if (data.bollingerbandsMiddle != 0)
            TextSpan(
                text: 'MB:${format(data.bollingerbandsMiddle)}    ',
                style: getTextStyle(chartColors.ma10Color)),
          if (data.bollingerBandsLower != 0)
            TextSpan(
                text: 'LB:${format(data.bollingerBandsLower)}    ',
                style: getTextStyle(chartColors.ma30Color)),
        ],
      );
    } else if (state == MainState.ENV) {
      span = TextSpan(children: [
        if (data.envelopeUpper != 0)
          TextSpan(
              text: 'Upper:${format(data.envelopeUpper)}    ',
              style: getTextStyle(indicatorColor.envelopeUpColor)),
        if (data.envelopeLower != 0)
          TextSpan(
              text: 'Lower:${format(data.envelopeLower)}    ',
              style: getTextStyle(indicatorColor.envelopeDnColor)),
      ]);
    }

    if (span == null) return;
    TextPainter tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(x, chartRect.top - topPadding));
  }

  // List<InlineSpan> _createMATextSpan(CandleEntity data) {
  //   List<InlineSpan> result = [];
  //   for (int i = 0; i < (data.maValueList?.length ?? 0); i++) {
  //     if (data.maValueList?[i] != 0) {
  //       var item = TextSpan(
  //           text:
  //               'MA${IndicatorInput.movingAveragePeriod[i]}:${format(data.maValueList![i])}    ',
  //           style: getTextStyle(chartColors.getMAColor(i)));
  //       result.add(item);
  //     }
  //   }
  //   return result;
  // }

  @override
  void drawChart(CandleEntity lastPoint, CandleEntity curPoint, double lastX,
      double curX, Size size, Canvas canvas) {
    if (isLine) {
      drawPolyline(lastPoint.close, curPoint.close, canvas, lastX, curX);
    } else {
      drawCandle(curPoint, canvas, curX);
      if (state == MainState.MA) {
        drawMaLine(lastPoint, curPoint, canvas, lastX, curX);
      } else if (state == MainState.BOLL) {
        drawBollLine(lastPoint, curPoint, canvas, lastX, curX);
      } else if (state == MainState.ENV) {
        drawEnvelope(lastPoint, curPoint, canvas, lastX, curX);
      } else if (state == MainState.PAR) {
        drawParabolicSAR(lastPoint, canvas, lastX);
      }
    }
  }

  Shader? mLineFillShader;
  Path? mLinePath, mLineFillPath;
  Paint mLineFillPaint = Paint()
    ..style = PaintingStyle.fill
    ..isAntiAlias = true;

  //画折线图
  drawPolyline(double lastPrice, double curPrice, Canvas canvas, double lastX,
      double curX) {
    mLinePath ??= Path();

    if (lastX == curX) lastX = 0;
    mLinePath!.moveTo(lastX, getY(lastPrice));
    mLinePath!.cubicTo((lastX + curX) / 2, getY(lastPrice), (lastX + curX) / 2,
        getY(curPrice), curX, getY(curPrice));

    mLineFillShader ??= LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      tileMode: TileMode.clamp,
      colors: [chartColors.lineFillColor, chartColors.lineFillInsideColor],
    ).createShader(Rect.fromLTRB(
        chartRect.left, chartRect.top, chartRect.right, chartRect.bottom));
    mLineFillPaint.shader = mLineFillShader;

    mLineFillPath ??= Path();

    mLineFillPath!.moveTo(lastX, chartRect.height + chartRect.top);
    mLineFillPath!.lineTo(lastX, getY(lastPrice));
    mLineFillPath!.cubicTo((lastX + curX) / 2, getY(lastPrice),
        (lastX + curX) / 2, getY(curPrice), curX, getY(curPrice));
    mLineFillPath!.lineTo(curX, chartRect.height + chartRect.top);
    mLineFillPath!.close();

    canvas.drawPath(mLineFillPath!, mLineFillPaint);
    mLineFillPath!.reset();

    canvas.drawPath(mLinePath!,
        mLinePaint..strokeWidth = (mLineStrokeWidth / scaleX).clamp(0.1, 1.0));
    mLinePath!.reset();
  }

  void drawMaLine(CandleEntity lastPoint, CandleEntity curPoint, Canvas canvas,
      double lastX, double curX) {
    if (lastPoint.movingAverage != 0) {
      drawLine(lastPoint.movingAverage, curPoint.movingAverage, canvas, lastX,
          curX, indicatorColor.maColor);
    }
  }

  void drawBollLine(CandleEntity lastPoint, CandleEntity curPoint,
      Canvas canvas, double lastX, double curX) {
    if (lastPoint.bollingerBandsUpper != 0) {
      drawLine(lastPoint.bollingerBandsUpper, curPoint.bollingerBandsUpper,
          canvas, lastX, curX, indicatorColor.bollingerBands);
    }
    if (lastPoint.bollingerbandsMiddle != 0) {
      drawLine(lastPoint.bollingerbandsMiddle, curPoint.bollingerbandsMiddle,
          canvas, lastX, curX, indicatorColor.bollingerBands);
    }
    if (lastPoint.bollingerBandsLower != 0) {
      drawLine(lastPoint.bollingerBandsLower, curPoint.bollingerBandsLower,
          canvas, lastX, curX, indicatorColor.bollingerBands);
    }
  }

  void drawEnvelope(CandleEntity lastPoint, CandleEntity curPoint,
      Canvas canvas, double lastX, double curX) {
    if (lastPoint.envelopeLower != 0) {
      drawLine(lastPoint.envelopeLower, curPoint.envelopeLower, canvas, lastX,
          curX, indicatorColor.envelopeDnColor);
    }
    // print('lastPointLower == ${lastPoint.envelopeLower}');
    if (lastPoint.envelopeUpper != 0) {
      drawLine(lastPoint.envelopeUpper, curPoint.envelopeUpper, canvas, lastX,
          curX, indicatorColor.envelopeUpColor);
    }
    // print('lastPointUpper == ${lastPoint.envelopeUpper}');
  }

  void drawParabolicSAR(CandleEntity lastPoint, Canvas canvas, double lastX) {
    if (lastPoint.parabolicUptrend != 0) {
      // drawLine(lastPoint.parabolicUptrend, curPoint.parabolicUptrend, canvas,
      //     lastX, curX, chartColors.parabolicSAR);
      drawPoint(lastPoint.parabolicUptrend, canvas, lastX,
          indicatorColor.parabolicColor);
    }
    if (lastPoint.parabolicDownTrend != 0) {
      // drawP(lastPoint.parabolicDownTrend, curPoint.parabolicDownTrend, canvas, lastX,
      //     curX, chartColors.parabolicColor);
      drawPoint(lastPoint.parabolicDownTrend, canvas, lastX,
          indicatorColor.parabolicColor);
    }
  }

  void drawCandle(CandleEntity curPoint, Canvas canvas, double curX) {
    var high = getY(curPoint.high);
    var low = getY(curPoint.low);
    var open = getY(curPoint.open);
    var close = getY(curPoint.close);
    double r = mCandleWidth / 2;
    double lineR = mCandleLineWidth / 2;
    if (open >= close) {
      // CandleLineWidth
      if (open - close < mCandleLineWidth) {
        open = close + mCandleLineWidth;
      }
      chartPaint.color = chartColors.upColor;
      canvas.drawRect(
          Rect.fromLTRB(curX - r, close, curX + r, open), chartPaint);
      canvas.drawRect(
          Rect.fromLTRB(curX - lineR, high, curX + lineR, low), chartPaint);
    } else if (close > open) {
      //  CandleLineWidth
      if (close - open < mCandleLineWidth) {
        open = close - mCandleLineWidth;
      }
      chartPaint.color = chartColors.dnColor;
      canvas.drawRect(
          Rect.fromLTRB(curX - r, open, curX + r, close), chartPaint);
      canvas.drawRect(
          Rect.fromLTRB(curX - lineR, high, curX + lineR, low), chartPaint);
    }
  }

  @override
  void drawVerticalText(canvas, textStyle, int gridRows) {
    double rowSpace = chartRect.height / gridRows;
    for (var i = 0; i <= gridRows; ++i) {
      double value = (gridRows - i) * rowSpace / scaleY + minValue;
      TextSpan span = TextSpan(text: format(value), style: textStyle);
      TextPainter tp =
          TextPainter(text: span, textDirection: TextDirection.ltr);
      tp.layout();

      double offsetX;
      switch (verticalTextAlignment) {
        case VerticalTextAlignment.left:
          offsetX = 0;
          break;
        case VerticalTextAlignment.right:
          offsetX = chartRect.width - tp.width;
          break;
      }

      if (i == 0) {
        tp.paint(canvas, Offset(offsetX, topPadding));
      } else {
        tp.paint(
            canvas, Offset(offsetX, rowSpace * i - tp.height + topPadding));
      }
    }
  }

  @override
  void drawGrid(Canvas canvas, int gridRows, int gridColumns) {
//    final int gridRows = 4, gridColumns = 4;
    double rowSpace = chartRect.height / gridRows;
    for (int i = 0; i <= gridRows; i++) {
      canvas.drawLine(Offset(0, rowSpace * i + topPadding),
          Offset(chartRect.width, rowSpace * i + topPadding), gridPaint);
    }
    double columnSpace = chartRect.width / gridColumns;
    for (int i = 0; i <= columnSpace; i++) {
      canvas.drawLine(Offset(columnSpace * i, topPadding / 3),
          Offset(columnSpace * i, chartRect.bottom), gridPaint);
    }
  }

  @override
  double getY(double y) {
    //For TrendLine
    updateTrendLineData();
    return (maxValue - y) * scaleY + _contentRect.top;
  }

  void updateTrendLineData() {
    trendLineMax = maxValue;
    trendLineScale = scaleY;
    trendLineContentRec = _contentRect.top;
  }
}
