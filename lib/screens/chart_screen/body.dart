// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:frontend/screens/chart_screen/pages/indicator_input.dart';
import 'package:frontend/screens/chart_screen/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

import '../../chart/model/chart_translations.dart';
import '../../chart/model/flutter_k_chart.dart';
import '../../widgets/widgets.dart';
import '../chart_screen/pages/indicator_style_widget.dart';

class ChartScreen extends StatefulWidget {
  static String routeName = '/chart';

  const ChartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen>
    with TickerProviderStateMixin {
  int selectedValue = 4;
  int barSelectedValue = 2;
  int selectedIndex = 1;
  bool isExpanded = false;
  bool isDarkMode = true;

  List<KLineEntity>? datas;
  bool showLoading = true;
  bool _volHidden = true;
  MainState mainState = MainState.NONE;
  SecondaryState secondaryState = SecondaryState.NONE;
  bool isLine = false;
  bool isCandle = true;
  final bool _hideGrid = false;
  final bool _showNowPrice = true;
  // List<DepthEntity>? _bids, _asks;
  bool isChangeUI = false;
  final bool _isTrendLine = false;
  final VerticalTextAlignment _verticalTextAlignment =
      VerticalTextAlignment.right;

  ChartStyle chartStyle = ChartStyle();
  ChartColors chartColors = ChartColors();
  IndicatorColor indicatorColor = IndicatorColor();

  bool reset = false;
  bool indicator = false;

  @override
  void initState() {
    super.initState();
    getData();
    // print(getData());
  }

  @override
  void dispose() {
    // _controllerDeviation.dispose();
    // _controllerPeriod.dispose();
    IndicatorInput.bollingerControllerDeviation.dispose();
    IndicatorInput.bollingerControllerPeriod.dispose();
    super.dispose();
  }

  void getData() {
    final Future<String> future = getChatDataFromJson();
    future.then((String result) {
      solveChatData(result);
    }).catchError((_) {
      showLoading = false;
      setState(() {});
      print('### datas error $_');
    });
  }

  Future<String> getChatDataFromJson() async {
    return rootBundle.loadString('frontend/assets/assets/chatData.json');
  }

// fetch data from online
  Future<String> getChatDataFromInternet(String? period) async {
    var url =
        'https://api.huobi.br.com/market/history/kline?period=${period ?? '1minute'}&size=300&symbol=btcusdt';
    late String result;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      result = response.body;
    } else {
      print('Failed getting IP address');
    }
    return result;
  }

  void solveChatData(String result) {
    final Map parseJson = json.decode(result) as Map<dynamic, dynamic>;
    final list = parseJson['data'] as List<dynamic>;
    datas = list
        .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
        .toList()
        .reversed
        .toList()
        .cast<KLineEntity>();

    // print(datas!);
    // DataUtil.calculate(datas!);
    // DataUtil.calcBollingerBands(datas!, IndicatorInput.bollingerPeriod,
    //     IndicatorInput.bollingerDeviation);
    // DataUtil.calcSimpleMovingAverage(
    //     datas!, IndicatorInput.movingAveragePeriod);
    // DataUtil.calcVolumeMA(datas!, IndicatorInput.periodVolumeFirst,
    //     IndicatorInput.periodVolumeSecond);
    // DataUtil.calcRSI(datas!, IndicatorInput.periodRSI);
    // DataUtil.calcEnvelope(datas!, IndicatorInput.envelopePeriod,
    //     IndicatorInput.envelopeDeviation);
    // DataUtil.calcParablolicSAR(datas!, IndicatorInput.parabolicSteps);
    // DataUtil.calcStandardDeviation(datas!, IndicatorInput.stdPeriod);
    showLoading = false;
    setState(() {});

    // return datas!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: isExpanded == true
          ? null
          : AppBar(
              backgroundColor: Colors.black87,
              elevation: 0.16,
              leading: IconButton(
                  splashRadius: 13,
                  splashColor: Colors.transparent,
                  icon: const Icon(
                    CupertinoIcons.back,
                    color: Colors.white70,
                    size: 20,
                  ),
                  onPressed: () {}),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'EUR/USD',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.8),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Euro/US Dollar',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.8,
                        color: Colors.black38),
                  ),
                ],
              ),
              actions: [
                IconButton(
                    splashRadius: 13,
                    splashColor: Colors.transparent,
                    icon: const Icon(
                      Icons.star_outline,
                      color: Colors.yellow,
                      size: 20,
                    ),
                    onPressed: () {}),
              ],
            ),
      body: Column(
        children: [
          SizedBox(
            height: 35,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    iconSize: 20,
                    splashRadius: 16,
                    icon: const Icon(
                      Icons.construction,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        isDismissible: true,
                        context: context,
                        builder: (context) =>
                            buildToolSheet(context, _isTrendLine),
                      );
                    }),
                IconButton(
                  icon: const Icon(
                    Icons.access_time,
                    color: Colors.white70,
                  ),
                  iconSize: 20,
                  onPressed: () => timerDialog(context, selectedValue),
                  splashRadius: 14,
                ),
                IconButton(
                    icon: const Icon(
                      Icons.bar_chart,
                      color: Colors.white70,
                    ),
                    iconSize: 20,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  clipBehavior: Clip.antiAlias,
                                  contentPadding: const EdgeInsets.all(0),
                                  content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Bar Type',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Wrap(
                                              children: [
                                                buttonChartType(
                                                    Icons.candlestick_chart,
                                                    "Candle", onPressed: () {
                                                  if (isCandle != true &&
                                                      isLine == true) {
                                                    isCandle = true;
                                                    isLine = false;
                                                  }
                                                }),
                                                buttonChartType(
                                                    Icons.ssid_chart, "Line",
                                                    onPressed: () {
                                                  if (isLine != true &&
                                                      isCandle == true) {
                                                    isCandle = false;
                                                    isLine = true;
                                                  }
                                                }),
                                              ],
                                            )
                                          ])),
                                  actions: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.black,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 3)),
                                        onPressed: () {
                                          setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ]));
                    },
                    splashRadius: 18),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => buildIndicatorSheet(context));
                  },
                  radius: 35,
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                        color: Colors.transparent, shape: BoxShape.circle),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'f',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic),
                        ),
                        Text(
                          'x',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.white70,
                  ),
                  iconSize: 20,
                  // ignore: avoid_print
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => buildMoreSheet(context));
                  },
                  splashRadius: 14,
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(children: <Widget>[
              SizedBox(
                height: isExpanded == false ? 500 : double.infinity,
                width: double.infinity,
                child: KChartWidget(
                  datas,
                  chartStyle,
                  indicatorColor,
                  chartColors,
                  isLine: isLine,
                  onSecondaryTap: () {
                    print('Secondary Tap');
                  },
                  isTrendLine: _isTrendLine,
                  mainState: mainState,
                  volHidden: _volHidden,
                  secondaryState: secondaryState,
                  fixedLength: 2,
                  timeFormat: TimeFormat.YEAR_MONTH_DAY,
                  translations: kChartTranslations,
                  showNowPrice: _showNowPrice,
                  hideGrid: _hideGrid,
                  isTapShowInfoDialog: false,
                  verticalTextAlignment: _verticalTextAlignment,
                ),
              ),
              if (showLoading)
                Container(
                    width: double.infinity,
                    height: 400,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator()),
              Positioned(
                  right: 8,
                  top: 5,
                  child: Container(
                    height: 50,
                    width: 130,
                    color: Colors.red,
                  )),
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        mini: true,
        child: const Icon(Icons.swap_horiz),
      ),
    );
  }

  Widget buildIndicatorSheet(BuildContext context) {
    return makeDismissible(
        child: DraggableScrollableSheet( 
            initialChildSize: 0.85,
            maxChildSize: 0.85,
            minChildSize: 0.4,
            builder: (context, scrollController) {
              return Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                  child: ListView(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('INDICATOR',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.7)),
                        IconButton(
                          icon: const Icon(Icons.clear),
                          iconSize: 26,
                          onPressed: () => Navigator.of(context).pop(),
                          splashRadius: 17,
                        ),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Trends',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Divider(
                              thickness: 0.3,
                            ),
                            buildIndicatorButton('Bollinger Bands  (BOLL)', () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) =>
                                      buildBollingerBandsIndicator(datas!));

                              setState(() {});
                            }),
                            buildIndicatorButton(
                                'Exponential Moving Average  (EMA)', () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) =>
                                      buildBollingerBandsIndicator(datas!));

                              setState(() {});
                            }),
                            buildIndicatorButton(
                                ' Simple Moving Average  (SMA)', () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) =>
                                      buildSMAIndicator(datas!));

                              setState(() {});
                            }),
                            buildIndicatorButton('Envelope', () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) =>
                                      buildEnvelopeIndicator(datas!));

                              setState(() {});
                            }),
                            buildIndicatorButton('ParabolicSAR', () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) =>
                                      buildParabolicIndicator(datas!));

                              setState(() {});
                            }),
                            const SizedBox(
                              height: 7,
                            ),
                            const Text(
                              'Oscilators',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Divider(
                              thickness: 0.3,
                            ),
                            buildIndicatorButton(
                                'Relative Strength Index  (RSI)', () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) =>
                                      buildRsiOscillator(datas!));

                              setState(() {});
                            }),
                            buildIndicatorButton('Standard Deviation (STD)',
                                () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) =>
                                      buildStdOscillator(datas!));

                              setState(() {});
                            }),
                            buildIndicatorButton(
                                'Moving Average Convergence Divergence  (MACD)',
                                () {
                              setState(() {
                                secondaryState = SecondaryState.MACD;
                              });
                              Navigator.pop(context);
                            }),
                            buildIndicatorButton(
                                'Commodity Channel Index   (CCI)', () {
                              setState(() {
                                secondaryState = SecondaryState.CCI;
                              });
                              Navigator.pop(context);
                            }),
                            buildIndicatorButton('Williams Range  (WR)', () {
                              setState(() {
                                secondaryState = SecondaryState.WR;
                              });
                              Navigator.pop(context);
                            }),
                            buildIndicatorButton('KDJ', () {
                              setState(() {
                                secondaryState = SecondaryState.KDJ;
                              });
                              Navigator.pop(context);
                            }),
                            buildIndicatorButton('Volume', () {
                              setState(() {
                                _volHidden = false;
                              });
                              Navigator.pop(context);
                            })
                          ],
                        )),
                  ]));
            }));
  }

  Widget buildStdOscillator(List<KLineEntity>? datas) =>
      DraggableScrollableSheet(
          initialChildSize: 1,
          maxChildSize: 1,
          minChildSize: 0.9,
          builder: (context, scrollController) =>
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      backgroundColor: Colors.black,
                      leading: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.white,
                        ),
                        splashRadius: 35,
                      ),
                      title: Text(
                        IndicatorInput.stdName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.3),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'INPUTS',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    periodRow('Period', IndicatorInput.stdPeriod,
                        IndicatorInput.stdControllerPeriod),
                    const SizedBox(
                      height: 15,
                    ),
                    sourceRow('Source', IndicatorInput.sources,
                        IndicatorInput.selectedSource, reset),
                    const SizedBox(
                      height: 15,
                    ),
                    sourceRow('Method', IndicatorInput.methods,
                        IndicatorInput.selectedMethod, reset),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'STYLE',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    styleBuilder(
                        context,
                        'Main Line',
                        IndicatorInput.style,
                        IndicatorInput.selectedStyle,
                        reset,
                        indicatorColor.stdColor),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textButtonIndicatorBuilder(datas, context, () {
                          IndicatorInput.stdPeriod = 20;
                          IndicatorInput.stdControllerPeriod.text =
                              '${IndicatorInput.stdPeriod}';
                          // reset = true;
                          buildDropDown(IndicatorInput.sources,
                              IndicatorInput.selectedSource, reset);
                          buildStyleDropDown(IndicatorInput.style,
                              IndicatorInput.selectedStyle, reset);
                          // pickColor(context);
                          // reset = false;
                          // });
                        }, 'Reset'),
                        textButtonIndicatorBuilder(datas, context, () {
                          secondaryState = SecondaryState.STD;
                          DataUtil.calcStandardDeviation(
                            datas!,
                            int.parse(IndicatorInput.stdControllerPeriod.text),
                          );
                          Navigator.pop(context);
                          setState(() {});
                        }, 'Apply'),
                      ]),
                ),
              ]));

  Widget buildRsiOscillator(List<KLineEntity>? datas) =>
      DraggableScrollableSheet(
          initialChildSize: 1,
          maxChildSize: 1,
          minChildSize: 0.9,
          builder: (context, scrollController) =>
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      backgroundColor: Colors.black,
                      leading: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.white,
                        ),
                        splashRadius: 35,
                      ),
                      title: Text(
                        IndicatorInput.rsiName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.3),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'INPUTS',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    periodRow('Period', IndicatorInput.rsiPeriod,
                        IndicatorInput.rsiControllerPeriod),
                    const SizedBox(
                      height: 15,
                    ),
                    sourceRow('Source', IndicatorInput.sources,
                        IndicatorInput.selectedSource, reset),
                    const SizedBox(
                      height: 15,
                    ),
                    sourceRow('Method', IndicatorInput.methods,
                        IndicatorInput.selectedMethod, reset),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'STYLE',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    styleBuilder(
                        context,
                        'Main Line',
                        IndicatorInput.style,
                        IndicatorInput.selectedStyle,
                        reset,
                        indicatorColor.rsiColor),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textButtonIndicatorBuilder(datas, context, () {
                          IndicatorInput.rsiPeriod = 20;
                          IndicatorInput.rsiControllerPeriod.text =
                              '${IndicatorInput.rsiPeriod}';
                          // reset = true;
                          buildDropDown(IndicatorInput.sources,
                              IndicatorInput.selectedSource, reset);
                          buildStyleDropDown(IndicatorInput.style,
                              IndicatorInput.selectedStyle, reset);
                          // pickColor(context);
                          // reset = false;
                          // });
                        }, 'Reset'),
                        textButtonIndicatorBuilder(datas, context, () {
                          secondaryState = SecondaryState.RSI;
                          DataUtil.calcRSI(
                            datas!,
                            int.parse(IndicatorInput.rsiControllerPeriod.text),
                          );
                          Navigator.pop(context);
                          setState(() {});
                        }, 'Apply'),
                      ]),
                ),
              ]));

  Widget buildParabolicIndicator(List<KLineEntity>? datas) =>
      DraggableScrollableSheet(
          initialChildSize: 1,
          maxChildSize: 1,
          minChildSize: 0.9,
          builder: (context, scrollController) =>
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      backgroundColor: Colors.black,
                      leading: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.white,
                        ),
                        splashRadius: 35,
                      ),
                      title: Text(
                        IndicatorInput.parabolicName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.3),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'INPUTS',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    doubleRowPeriod('Step', IndicatorInput.parabolicSteps,
                        IndicatorInput.parabolicControllerSteps),
                    const SizedBox(
                      height: 15,
                    ),
                    sourceRow('Source', IndicatorInput.sources,
                        IndicatorInput.selectedSource, reset),
                    const SizedBox(
                      height: 15,
                    ),
                    sourceRow('Method', IndicatorInput.methods,
                        IndicatorInput.selectedMethod, reset),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'STYLE',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    styleBuilder(
                        context,
                        'Main Line',
                        IndicatorInput.style,
                        IndicatorInput.selectedStyle,
                        reset,
                        indicatorColor.parabolicColor),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textButtonIndicatorBuilder(datas, context, () {
                          IndicatorInput.parabolicSteps = 20;
                          IndicatorInput.parabolicControllerSteps.text =
                              '${IndicatorInput.parabolicSteps}';
                          // reset = true;
                          buildDropDown(IndicatorInput.sources,
                              IndicatorInput.selectedSource, reset);
                          buildStyleDropDown(IndicatorInput.style,
                              IndicatorInput.selectedStyle, reset);
                          // pickColor(context);
                          // reset = false;
                          // });
                        }, 'Reset'),
                        textButtonIndicatorBuilder(datas, context, () {
                          mainState = MainState.PAR;
                          DataUtil.calcParablolicSAR(
                            datas!,
                            double.parse(
                                IndicatorInput.parabolicControllerSteps.text),
                          );
                          Navigator.pop(context);
                          setState(() {});
                        }, 'Apply'),
                      ]),
                ),
              ]));

  Widget buildSMAIndicator(List<KLineEntity>? datas) =>
      DraggableScrollableSheet(
          initialChildSize: 1,
          maxChildSize: 1,
          minChildSize: 0.9,
          builder: (context, scrollController) =>
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      backgroundColor: Colors.black,
                      leading: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.white,
                        ),
                        splashRadius: 35,
                      ),
                      title: Text(
                        IndicatorInput.sma,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.3),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'INPUTS',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    periodRow('Period', IndicatorInput.smaPeriod,
                        IndicatorInput.smaControllerPeriod),
                    const SizedBox(
                      height: 15,
                    ),
                    sourceRow('Source', IndicatorInput.sources,
                        IndicatorInput.selectedSource, reset),
                    const SizedBox(
                      height: 15,
                    ),
                    sourceRow('Method', IndicatorInput.methods,
                        IndicatorInput.selectedMethod, reset),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'STYLE',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    styleBuilder(
                        context,
                        'Main Line',
                        IndicatorInput.style,
                        IndicatorInput.selectedStyle,
                        reset,
                        indicatorColor.maColor),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textButtonIndicatorBuilder(datas, context, () {
                          IndicatorInput.smaPeriod = 20;
                          IndicatorInput.smaControllerPeriod.text =
                              '${IndicatorInput.smaPeriod}';
                          // reset = true;
                          buildDropDown(IndicatorInput.sources,
                              IndicatorInput.selectedSource, reset);
                          buildStyleDropDown(IndicatorInput.style,
                              IndicatorInput.selectedStyle, reset);
                          // pickColor(context);
                          // reset = false;
                          // });
                        }, 'Reset'),
                        textButtonIndicatorBuilder(datas, context, () {
                          mainState = MainState.MA;
                          DataUtil.calcSMA(
                            datas!,
                            int.parse(
                                IndicatorInput.envelopControllerPeriod.text),
                          );
                          Navigator.pop(context);
                          setState(() {});
                        }, 'Apply'),
                      ]),
                ),
              ]));

  Widget buildEnvelopeIndicator(List<KLineEntity>? datas) =>
      DraggableScrollableSheet(
          initialChildSize: 1,
          maxChildSize: 1,
          minChildSize: 0.9,
          builder: (context, scrollController) =>
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      backgroundColor: Colors.black,
                      leading: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.white,
                        ),
                        splashRadius: 35,
                      ),
                      title: Text(
                        IndicatorInput.envelopeName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.3),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'INPUTS',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    periodRow('Period', IndicatorInput.envelopePeriod,
                        IndicatorInput.envelopControllerPeriod),
                    const SizedBox(
                      height: 15,
                    ),
                    periodRow('Deviation', IndicatorInput.envelopeDeviation,
                        IndicatorInput.envelopControllerDeviation),
                    const SizedBox(
                      height: 15,
                    ),
                    sourceRow('Source', IndicatorInput.sources,
                        IndicatorInput.selectedSource, reset),
                    const SizedBox(
                      height: 15,
                    ),
                    sourceRow('Method', IndicatorInput.methods,
                        IndicatorInput.selectedMethod, reset),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'STYLE',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    styleBuilder(
                        context,
                        'Upper Bands',
                        IndicatorInput.style,
                        IndicatorInput.selectedStyle,
                        reset,
                        indicatorColor.envelopeUpColor),
                    styleBuilder(
                        context,
                        'Lower Band',
                        IndicatorInput.style,
                        IndicatorInput.selectedStyle,
                        reset,
                        indicatorColor.envelopeDnColor),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textButtonIndicatorBuilder(datas, context, () {
                          IndicatorInput.envelopePeriod = 7;
                          IndicatorInput.envelopeDeviation = 1;
                          IndicatorInput.envelopControllerPeriod.text =
                              '${IndicatorInput.envelopePeriod}';
                          IndicatorInput.envelopControllerDeviation.text =
                              '${IndicatorInput.envelopeDeviation}';
                          // reset = true;
                          buildDropDown(IndicatorInput.sources,
                              IndicatorInput.selectedSource, reset);
                          buildStyleDropDown(IndicatorInput.style,
                              IndicatorInput.selectedStyle, reset);
                          // pickColor(context);
                          // reset = false;
                          // });
                        }, 'Reset'),
                        textButtonIndicatorBuilder(datas, context, () {
                          mainState = MainState.ENV;
                          DataUtil.calcEnvelope(
                              datas!,
                              int.parse(
                                  IndicatorInput.envelopControllerPeriod.text),
                              int.parse(IndicatorInput
                                  .envelopControllerDeviation.text));
                          Navigator.pop(context);
                          setState(() {});
                        }, 'Apply'),
                      ]),
                ),
              ]));

  Widget buildBollingerBandsIndicator(List<KLineEntity>? datas) =>
      DraggableScrollableSheet(
          initialChildSize: 1,
          maxChildSize: 1,
          minChildSize: 0.9,
          builder: (context, scrollController) =>
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      backgroundColor: Colors.black,
                      leading: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.white,
                        ),
                        splashRadius: 35,
                      ),
                      title: Text(
                        IndicatorInput.bollingerName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.3),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'INPUTS',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    periodRow('Period', IndicatorInput.bollingerPeriod,
                        IndicatorInput.bollingerControllerPeriod),
                    const SizedBox(
                      height: 15,
                    ),
                    periodRow('Deviation', IndicatorInput.bollingerDeviation,
                        IndicatorInput.bollingerControllerDeviation),
                    const SizedBox(
                      height: 15,
                    ),
                    sourceRow('Source', IndicatorInput.sources,
                        IndicatorInput.selectedSource, reset),
                    const SizedBox(
                      height: 15,
                    ),
                    sourceRow('Method', IndicatorInput.methods,
                        IndicatorInput.selectedMethod, reset),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'STYLE',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    styleBuilder(
                        context,
                        'Main Line',
                        IndicatorInput.style,
                        IndicatorInput.selectedStyle,
                        reset,
                        indicatorColor.bollingerBands),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textButtonIndicatorBuilder(datas, context, () {
                          IndicatorInput.bollingerPeriod = 20;
                          IndicatorInput.bollingerDeviation = 2;
                          IndicatorInput.bollingerControllerPeriod.text =
                              '${IndicatorInput.bollingerPeriod}';
                          IndicatorInput.bollingerControllerDeviation.text =
                              '${IndicatorInput.bollingerDeviation}';
                          // reset = true;
                          buildDropDown(IndicatorInput.sources,
                              IndicatorInput.selectedSource, reset);
                          buildStyleDropDown(IndicatorInput.style,
                              IndicatorInput.selectedStyle, reset);
                          // pickColor(context);
                          // reset = false;
                          // });
                        }, 'Reset'),
                        textButtonIndicatorBuilder(datas, context, () {
                          mainState = MainState.BOLL;
                          DataUtil.calcBollingerBands(
                              datas!,
                              int.parse(IndicatorInput
                                  .bollingerControllerPeriod.text),
                              int.parse(IndicatorInput
                                  .bollingerControllerDeviation.text));
                          Navigator.pop(context);
                          setState(() {});
                        }, 'Apply'),
                      ]),
                ),
              ]));

  Widget buildToolSheet(BuildContext context, bool trendLine) {
    return makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (_, controller) => Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
          child: ListView(
            controller: controller,
            children: [
              Text('TOOL FACTORY',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w600, letterSpacing: -0.7)),
              const Divider(
                thickness: 0.3,
              ),
              const Text(
                'TOOLS',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    letterSpacing: -0.6),
              ),
              Container(
                height: 85,
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(children: [
                    buildToolsButton('Lock', Icons.lock, () {}),
                    buildToolsButton('Text', Icons.text_fields, () {}),
                    buildToolsButton('Expand', Icons.fullscreen, () {
                      setState(() {
                        isExpanded = true;
                      });
                    }),
                    buildToolsButton('Contract', Icons.fullscreen_exit, () {
                      setState(() {
                        isExpanded = false;
                      });
                    }),
                    buildToolsButton('Zoom In', Icons.zoom_in, () {}),
                    buildToolsButton('Zoom Out', Icons.zoom_out, () {}),
                  ]),
                ),
              ),
              const Divider(
                thickness: 0.3,
              ),
              const Text(
                'EQUIPMENTS',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    letterSpacing: -0.6),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Lines',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: -0.5),
              ),
              buildEquipmentButton('TrendLine', Icons.horizontal_rule, () {
                setState(() {
                  trendLine = true;
                });
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget styleBuilder(BuildContext context, String title, List<int> style,
      int selectedStyle, bool reset, Color indicatorColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Main Line',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.5)),
        ),
        Row(
          children: [
            buildStyleDropDown(style, selectedStyle, reset),
            const SizedBox(
              width: 3,
            ),
            InkWell(
              onTap: () {
                blockColorPicker(context, indicatorColor);
                setState(() {});
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: indicatorColor,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0.2,
                        blurRadius: 0.4,
                        blurStyle: BlurStyle.outer)
                  ],
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  void blockColorPicker(BuildContext context, Color indicatorColor) =>
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.white,
              child: BlockPicker(
                pickerColor: indicatorColor,
                onColorChanged: (color) {
                  setState(() {
                    indicatorColor = color;
                  });
                  Navigator.of(context).pop();
                },
              ),
            );
          });

  //
}
