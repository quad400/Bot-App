// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:frontend/chart/model/flutter_k_chart.dart';
import 'package:frontend/screens/chart_screen/pages/indicator_input.dart';

import '../../../data/chart_data.dart';

class ChartType extends StatefulWidget {
  List<KLineEntity>? datas;
  ChartStyle chartStyle = ChartStyle();
  ChartColors chartColors = ChartColors();
  IndicatorColor indicatorColor = IndicatorColor();
  bool isLine, isCandle;
  ChartType({
    Key? key,
    this.isCandle = true,
    this.isLine = false,
  }) : super(key: key);

  @override
  State<ChartType> createState() => _ChartTypeState();
}

class _ChartTypeState extends State<ChartType> {
  void chartModifier() {}

  @override
  Widget build(BuildContext context) {
    final chartType = KChartWidget(
      widget.datas,
      widget.chartStyle,
      widget.indicatorColor,
      widget.chartColors,
      // isCandle: widget.isCandle,
      // isLine: widget.isLine,
    );
    return AlertDialog(
        clipBehavior: Clip.antiAlias,
        contentPadding: const EdgeInsets.all(0),
        content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      button(Icons.candlestick_chart, "Candle", onPressed: () {
                        if (chartType.isCandle != true &&
                            chartType.isLine == true) {
                          setState(() {
                            widget.isCandle = true;
                            widget.isCandle = chartType.isCandle;
                            widget.isLine = true;
                            widget.isLine = chartType.isLine;
                          });
                          print(
                              'Candle: ${widget.isCandle}, Line: ${widget.isLine}');
                        }
                      }),
                      button(Icons.ssid_chart, "Line", onPressed: () {
                        if (chartType.isLine != true &&
                            chartType.isCandle == true) {
                          setState(() {
                            // chartType.isCandle = false;
                            widget.isCandle = false;
                            widget.isCandle = chartType.isCandle;
                            widget.isLine = true;
                            widget.isLine = chartType.isLine;
                          });
                          print(
                              'Line: ${widget.isLine}, Candle: ${widget.isCandle}');
                        }
                      }),
                    ],
                  )
                ])),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 3)),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              )),
        ]);
  }

  Widget button(IconData icon, String text, {VoidCallback? onPressed}) {
    return TextButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
          setState(() {});
        }
      },
      style: TextButton.styleFrom(
        primary: Colors.black,
        minimumSize: const Size(100, 44),
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
        ),
        backgroundColor: Colors.white,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.black,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          )
        ],
      ),
    );
  }
}
