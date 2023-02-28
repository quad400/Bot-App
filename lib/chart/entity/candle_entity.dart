mixin CandleEntity {
  late double open;
  late double high;
  late double low;
  late double close;

  //simple moving average list
  List<double>? maValueList;
  double? movingAverage;

  //bollinger bands
  double? bollingerBandsUpper;
  double? bollingerbandsMiddle;
  double? bollingerBandsLower;
  double? bollingerBandsMA;

  //envelope
  double? envelopeUpper;
  double? envelopeLower;

  // parabolic SAR
  double? parabolicUptrend;
  double? parabolicDownTrend;

  //exponential moving average
  double? exponentialMA;
}
