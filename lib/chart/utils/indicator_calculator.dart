import 'dart:math';

import '../entity/index.dart';

enum Method { close, open, high, low }

class DataUtil {
  static calculate(List<KLineEntity> dataList,
      [List<int> maDayList = const [5, 20, 40, 50],
      int n = 20,
      int k = 2,
      int periodCCI = 14,
      int period = 20]) {
    // calcMA(dataList, maDayList);
    // calculateMovingAverage(dataList, period);
    // calcBOLL(dataList, n, k);
    // calcVolumeMA(dataList);
    calcKDJ(dataList);
    calcMACD(dataList);
    // calcRSI(dataList);
    calcWR(dataList);
    calcCCI(dataList, periodCCI);
  }

  static void calcBollingerBands(
      List<KLineEntity> dataList, int bollingerPeriod, int bollingerDeviation) {
    _calcBOLLMA(bollingerPeriod, dataList);
    for (int i = 0; i < dataList.length; i++) {
      KLineEntity entity = dataList[i];
      if (i >= bollingerPeriod) {
        double md = 0;
        for (int j = i - bollingerPeriod + 1; j <= i; j++) {
          double c = dataList[j].close;
          double m = entity.bollingerBandsMA!;
          double value = c - m;
          md += value * value;
        }
        md = md / (bollingerPeriod - 1);
        md = sqrt(md);
        entity.bollingerbandsMiddle = entity.bollingerBandsMA!;
        entity.bollingerBandsUpper =
            entity.bollingerbandsMiddle! + bollingerDeviation * md;
        entity.bollingerBandsLower =
            entity.bollingerbandsMiddle! - bollingerDeviation * md;
      }
    }
  }

  static void _calcBOLLMA(int day, List<KLineEntity> dataList) {
    double ma = 0;
    for (int i = 0; i < dataList.length; i++) {
      KLineEntity entity = dataList[i];
      ma += entity.close;
      if (i == day - 1) {
        entity.bollingerBandsMA = ma / day;
      } else if (i >= day) {
        ma -= dataList[i - day].close;
        entity.bollingerBandsMA = ma / day;
      } else {
        entity.bollingerBandsMA = null;
      }
    }
  }

  static void calcMACD(List<KLineEntity> dataList) {
    double fastEMA = 0;
    double slowEMA = 0;
    double dif = 0;
    double dea = 0;
    double macd = 0;

    for (int i = 0; i < dataList.length; i++) {
      KLineEntity entity = dataList[i];
      final closePrice = entity.close;
      if (i == 0) {
        fastEMA = closePrice;
        slowEMA = closePrice;
      } else {
        // EMA（12） = 前一日EMA（12） X 11/13 + 今日收盘价 X 2/13
        fastEMA = fastEMA * 11 / 13 + closePrice * 2 / 13;
        // EMA（26） = 前一日EMA（26） X 25/27 + 今日收盘价 X 2/27
        slowEMA = slowEMA * 25 / 27 + closePrice * 2 / 27;
      }
      // DIF = EMA（12） - EMA（26） 。
      // 今日DEA = （前一日DEA X 8/10 + 今日DIF X 2/10）
      // 用（DIF-DEA）*2即为MACD柱状图。
      dif = fastEMA - slowEMA;
      dea = dea * 8 / 10 + dif * 2 / 10;
      macd = (dif - dea) * 2;
      entity.dif = dif;
      entity.dea = dea;
      entity.macd = macd;
    }
  }

  static void calcVolumeMA(List<KLineEntity> dataList, int periodVolumeFirst,
      int periodVolumeSecond) {
    double volumeMa5 = 0;
    double volumeMa10 = 0;

    for (int i = 0; i < dataList.length; i++) {
      KLineEntity entry = dataList[i];

      volumeMa5 += entry.vol;
      volumeMa10 += entry.vol;

      if (i == periodVolumeFirst - 1) {
        entry.MA5Volume = (volumeMa5 / periodVolumeFirst);
      } else if (i > periodVolumeFirst - 1) {
        volumeMa5 -= dataList[i - periodVolumeFirst].vol;
        entry.MA5Volume = volumeMa5 / periodVolumeFirst;
      } else {
        entry.MA5Volume = 0;
      }

      if (i == periodVolumeSecond - 1) {
        entry.MA10Volume = volumeMa10 / periodVolumeSecond;
      } else if (i > periodVolumeSecond) {
        volumeMa10 -= dataList[i - periodVolumeSecond].vol;
        entry.MA10Volume = volumeMa10 / periodVolumeSecond;
      } else {
        entry.MA10Volume = 0;
      }
    }
  }

  static void calcRSI(List<KLineEntity> dataList, int periodRSI) {
    double? rsi;
    double rsiABSEma = 0;
    double rsiMaxEma = 0;
    for (int i = 0; i < dataList.length; i++) {
      KLineEntity entity = dataList[i];
      final double closePrice = entity.close;
      if (i == 0) {
        rsi = 0;
        rsiABSEma = 0;
        rsiMaxEma = 0;
      } else {
        double rMax = max(0, closePrice - dataList[i - 1].close.toDouble());
        double rAbs = (closePrice - dataList[i - 1].close.toDouble()).abs();

        rsiMaxEma = (rMax + (periodRSI - 1) * rsiMaxEma) / periodRSI;
        rsiABSEma = (rAbs + (periodRSI - 1) * rsiABSEma) / periodRSI;
        rsi = (rsiMaxEma / rsiABSEma) * 100;
      }
      if (i < periodRSI - 1) rsi = null;
      if (rsi != null && rsi.isNaN) rsi = null;
      entity.rsi = rsi;
    }
  }

  static void calcSMA(List<KLineEntity> datas, int periodSMA) {
    double ma = 0.0;
    if (datas.isNotEmpty) {
      for (int i = 0; i < datas.length; i++) {
        KLineEntity entry = datas[i];
        final amount = entry.close;
        ma += amount;
        if (i == periodSMA - 1) {
          entry.movingAverage = (ma / periodSMA);
        } else if (i >= periodSMA) {
          ma = datas[i - periodSMA].close;
          entry.movingAverage = ma / periodSMA;
          // print(entry.movingAverage);
        } else {
          entry.movingAverage = 0;
        }
        print(entry.movingAverage);
      }
    }
  }

  static void calcKDJ(List<KLineEntity> dataList) {
    var preK = 50.0;
    var preD = 50.0;
    final tmp = dataList.first;
    tmp.k = preK;
    tmp.d = preD;
    tmp.j = 50.0;
    for (int i = 1; i < dataList.length; i++) {
      final entity = dataList[i];
      final n = max(0, i - 8);
      var low = entity.low;
      var high = entity.high;
      for (int j = n; j < i; j++) {
        final t = dataList[j];
        if (t.low < low) {
          low = t.low;
        }
        if (t.high > high) {
          high = t.high;
        }
      }
      final cur = entity.close;
      var rsv = (cur - low) * 100.0 / (high - low);
      rsv = rsv.isNaN ? 0 : rsv;
      final k = (2 * preK + rsv) / 3.0;
      final d = (2 * preD + k) / 3.0;
      final j = 3 * k - 2 * d;
      preK = k;
      preD = d;
      entity.k = k;
      entity.d = d;
      entity.j = j;
    }
  }

  static void calcWR(List<KLineEntity> dataList) {
    double r;
    for (int i = 0; i < dataList.length; i++) {
      KLineEntity entity = dataList[i];
      int startIndex = i - 14;
      if (startIndex < 0) {
        startIndex = 0;
      }
      double max14 = double.minPositive;
      double min14 = double.maxFinite;
      for (int index = startIndex; index <= i; index++) {
        max14 = max(max14, dataList[index].high);
        min14 = min(min14, dataList[index].low);
      }
      if (i < 13) {
        entity.r = -10;
      } else {
        r = -100 * (max14 - dataList[i].close) / (max14 - min14);
        if (r.isNaN) {
          entity.r = null;
        } else {
          entity.r = r;
        }
      }
    }
  }

  static void calcCCI(List<KLineEntity> dataList, int periodCCI) {
    final size = dataList.length;
    for (int i = 0; i < size; i++) {
      final kline = dataList[i];
      final tp = (kline.high + kline.low + kline.close) / 3;
      final start = max(0, i - periodCCI + 1);
      var amount = 0.0;
      var len = 0;
      for (int n = start; n <= i; n++) {
        amount += (dataList[n].high + dataList[n].low + dataList[n].close) / 3;
        len++;
      }
      final ma = amount / len;
      var amountPrice = 0.0;
      for (int n = start; n <= i; n++) {
        amountPrice +=
            (ma - (dataList[n].high + dataList[n].low + dataList[n].close) / 3)
                .abs();
      }
      final md = amountPrice / len;
      kline.cci = ((tp - ma) / 0.015 / md);
      if (kline.cci!.isNaN) {
        kline.cci = 0.0;
      }
    }
  }

  static void calcEnvelope(
      List<KLineEntity> datas, int envelopePeriod, int envelopeDeviation) {
    double amountPrice = 0.0;
    double upper = (1 + envelopeDeviation / 100);
    double lower = (1 - envelopeDeviation / 100);
    for (int i = 0; i < datas.length; i++) {
      KLineEntity entry = datas[i];
      calcSMA(datas, envelopePeriod);
      amountPrice = entry.movingAverage!;
      // print('amountPrice==$amountPrice');
      entry.envelopeUpper = amountPrice * upper;
      entry.envelopeLower = amountPrice * lower;
    }
  }

  static void calcParablolicSAR(
      List<KLineEntity> datas, double parabolicSteps) {
    for (int i = 0; i < datas.length; i++) {
      KLineEntity entry = datas[i];
      double extremePriceUp = datas[i].high;
      double extremePriceLow = datas[i].low;
      if (i == 0) {
        entry.parabolicDownTrend = datas[i].close -
            parabolicSteps * (extremePriceLow - datas[i].close);
        entry.parabolicUptrend =
            datas[i].close + parabolicSteps * (extremePriceUp - datas[i].close);
      } else {
        entry.parabolicDownTrend = datas[i - 1].close -
            parabolicSteps * (extremePriceLow - datas[i - 1].close);
        entry.parabolicUptrend = datas[i - 1].close +
            parabolicSteps * (extremePriceUp - datas[i - 1].close);
      }
      print(
          '${entry.parabolicUptrend} ============ ${entry.parabolicDownTrend}');
    }
  }

  static void calcStandardDeviation(List<KLineEntity> datas, int stdPeriod) {
    double value = 0.0;
    for (int i = 0; i < datas.length; i++) {
      KLineEntity entry = datas[i];
      calcSMA(datas, stdPeriod);
      value += pow((datas[i].close - entry.movingAverage!), 2);
      entry.standardDeviation = sqrt(value / (stdPeriod - 1));
    }
  }

  static calcSimpleMovingAverage(
      List<KLineEntity> datas, List<int> movingAveragePeriod) {
    List<double> ma = List<double>.filled(movingAveragePeriod.length, 0);

    if (datas.isNotEmpty) {
      for (int i = 0; i < datas.length; i++) {
        KLineEntity entity = datas[i];
        final closePrice = entity.close;
        entity.maValueList = List<double>.filled(movingAveragePeriod.length, 0);

        for (int j = 0; j < movingAveragePeriod.length; j++) {
          ma[j] += closePrice;
          if (i == movingAveragePeriod[j] - 1) {
            entity.maValueList?[j] = ma[j] / movingAveragePeriod[j];
          } else if (i >= movingAveragePeriod[j]) {
            ma[j] -= datas[i - movingAveragePeriod[j]].close;
            entity.maValueList?[j] = ma[j] / movingAveragePeriod[j];
          } else {
            entity.maValueList?[j] = 0;
          }
        }
      }
    }
  }

  // static void calcEMA(List<KLineEntity> dataList, int period) {
  //   List<double> previousEMA = [];
  //   double previousMA = [];

  //   double amount = 0.0;
  //   double calcEMA = 0.0;
  //   final double smoothing = 2 / (period + 1);
  //   for (int i = 0; i < dataList.length; i++) {
  //     KLineEntity entity = dataList[i];
  //     final price = entity.close;
  //     amount += price;

  //     if (i == period - 1) {
  //        //first ema
  //       amount = amount / period;
  //       previousMA.add(amount); //first moving average
  //       entity.exponentialMA = previousEMA.add(0.0);
  //     } else if (i == period) {
  //       previousEMA.add(0.0); //second ema
  //       amount -= dataList[i - period - 1].close;
  //       amount = amount / period;
  //       previousMA.add(amount); //second moving average
  //     } else {
  //       calcEMA = smoothing * previousEMA[i] +
  //           (1 - smoothing) * previousMA[i - 1];
  //       previousEMA.add(calcEMA);
  //       amount -= dataList[i - period].close;
  //       amount = amount / period;
  //       previousMA.add(amount);
  //     }
  //   }
  // }

  static void calcEMA(List<KLineEntity> dataList, int period) {
    double previousEMA = 0.0;
    final double multiplier = 2 / (period + 1);
    double amount = 0.0;
    for (int i = 0; i < dataList.length; i++) {
      KLineEntity entity = dataList[i];
      final double price = entity.close;
      amount += price;
      if (i == period - 1) {
        previousEMA = amount / period;
      } else if (i >= period) {
        previousEMA = price * multiplier + previousEMA * (1 - multiplier);
      } else {
        null;
      }
      entity.exponentialMA = previousEMA;
    }
  }
}
