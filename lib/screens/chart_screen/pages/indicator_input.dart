import 'package:flutter/material.dart';

class IndicatorInput {
  //Bollinger bands
  static String bollingerName = 'Bollinger Bands';
  static int bollingerDeviation = 2;
  static int bollingerPeriod = 20;
  static final bollingerControllerPeriod =
      TextEditingController(text: '${IndicatorInput.bollingerPeriod}');
  static final bollingerControllerDeviation =
      TextEditingController(text: '${IndicatorInput.bollingerDeviation}');

  // Envelope
  static String envelopeName = 'Envelope';
  static int envelopePeriod = 7;
  static int envelopeDeviation = 1;
  static final envelopControllerPeriod =
      TextEditingController(text: '${IndicatorInput.envelopePeriod}');
  static final envelopControllerDeviation =
      TextEditingController(text: '${IndicatorInput.envelopeDeviation}');

  // Simple Moving Average
  static String sma = 'Simple Moving Average';
  static int smaPeriod = 20;
  static final smaControllerPeriod =
      TextEditingController(text: '${IndicatorInput.smaPeriod}');

// Parabolic SAR
  static String parabolicName = 'Parabolic SAR';
  static double parabolicSteps = 0.02;
  static final parabolicControllerSteps =
      TextEditingController(text: '${IndicatorInput.parabolicSteps}');

  // Volume
  static String volume = 'Volume';
  static int periodVolumeFirst = 10;
  static int periodVolumeSecond = 20;

  // Relative Strength Index
  static String rsiName = 'Relative Strength Index';
  static int rsiPeriod = 20;
  static final rsiControllerPeriod =
      TextEditingController(text: '${IndicatorInput.rsiPeriod}');

  // Standard Deviation
  static String stdName = 'Standard Deviation';
  static int stdPeriod = 20;
  static final stdControllerPeriod =
      TextEditingController(text: '${IndicatorInput.stdPeriod}');

  //commodity channel index
  static String cciName = 'Commodity Channel Index';
  static int cciPeriod = 14;
  static final cciControllerPeriod =
      TextEditingController(text: '${IndicatorInput.cciPeriod}');

  // Source
  static List<String> sources = ['Close', 'Open', 'High', 'Low'];
  static String selectedSource = 'Close';

  // Method
  static List<String> methods = ['SMA', 'EMA'];
  static String selectedMethod = 'SMA';
  // Style
  static List<int> style = [1, 2, 3, 4];
  static int selectedStyle = 2;
}

class IndicatorColor {
  Color bollingerBands = const Color.fromARGB(255, 0, 175, 134);
  Color envelopeUpColor = const Color.fromARGB(255, 2, 49, 218);
  Color envelopeDnColor = const Color.fromARGB(255, 243, 7, 7);
  Color maColor = const Color(0xff9979C6);
  Color parabolicColor = const Color.fromARGB(255, 0, 175, 134);
  Color rsiColor = const Color.fromARGB(255, 24, 115, 243);
  Color stdColor = const Color.fromARGB(255, 0, 175, 134);
}
