// ignore_for_file: library_private_types_in_public_api, constant_identifier_names

import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:frontend/screens/chart_screen/pages/indicator_input.dart';
import 'chart_translations.dart';
import '../extension/map_ext.dart';
import 'flutter_k_chart.dart';

enum MainState { MA, BOLL, ENV, PAR, NONE }

enum SecondaryState { MACD, KDJ, RSI, WR, CCI, STD, NONE }

class TimeFormat {
  static const List<String> YEAR_MONTH_DAY = [yyyy, '-', mm, '-', dd];
  static const List<String> YEAR_MONTH_DAY_WITH_HOUR = [
    yyyy,
    '-',
    mm,
    '-',
    dd,
    ' ',
    HH,
    ':',
    nn
  ];
}

class KChartWidget extends StatefulWidget {
  final List<KLineEntity>? datas;
  final MainState mainState;
  final bool volHidden;
  final SecondaryState secondaryState;
  final Function()? onSecondaryTap;
  final bool isLine, isCandle;
  //

//settings
  final bool isTapShowInfoDialog,
      hideGrid,
      showNowPrice,
      showInfoDialog,
      materialInfoDialog;

  final Map<String, ChartTranslations> translations;
  final List<String> timeFormat;

  final Function(bool)? onLoadMore;

  final int fixedLength;
  final List<int> maDayList;
  final int flingTime;
  final double flingRatio;
  final Curve flingCurve;
  final Function(bool)? isOnDrag;
  final ChartColors chartColors;
  final ChartStyle chartStyle;
  final IndicatorColor indicatorColor;
  final VerticalTextAlignment verticalTextAlignment;

  //+ trending lines
  final bool isTrendLine;
  final bool isHorizontalLine;
  final bool isVerticalLine;
  //.
  final double xFrontPadding;

  // ignore: use_key_in_widget_constructors
  const KChartWidget(
    this.datas,
    this.chartStyle,
    this.indicatorColor,
    this.chartColors, {
    this.isTrendLine = false,
    this.isHorizontalLine = false,
    this.isVerticalLine = false,
    this.xFrontPadding = 100,
    this.mainState = MainState.NONE,
    this.secondaryState = SecondaryState.NONE,
    this.onSecondaryTap,
    this.volHidden = false,
    this.isLine = false,
    this.isCandle = true,
    this.isTapShowInfoDialog = false,
    this.hideGrid = false,
    this.showNowPrice = true,
    this.showInfoDialog = true,
    this.materialInfoDialog = true,
    this.translations = kChartTranslations,
    this.timeFormat = TimeFormat.YEAR_MONTH_DAY,
    this.onLoadMore,
    this.fixedLength = 2,
    this.maDayList = const [5, 10, 20],
    this.flingTime = 600,
    this.flingRatio = 0.5,
    this.flingCurve = Curves.decelerate,
    this.isOnDrag,
    this.verticalTextAlignment = VerticalTextAlignment.right,
  });

  @override
  _KChartWidgetState createState() => _KChartWidgetState();
}

class _KChartWidgetState extends State<KChartWidget>
    with TickerProviderStateMixin {
  double mScaleX = 1.0, mScrollX = 0.0;
  StreamController<InfoWindowEntity?>? mInfoWindowStream;
  double mHeight = 0, mWidth = 0;
  AnimationController? _controller;
  Animation<double>? aniX;

  //For TrendLine
  List<TrendLine> trendLines = [];
  List<VerticalLine> verticalLines = [];
  double? changeinXposition;
  double? changeinYposition;
  double mSelectY = 0.0, mSelectX = 0.0;
  bool waitingForOtherPairofCords = false;
  bool enableCordRecord = false;

  double getMinScrollX() {
    return mScaleX;
  }

  double _lastScale = 1.0;
  bool isScale = false, isDrag = false, isLongPress = false, isOnTap = false;

  @override
  void initState() {
    super.initState();
    mInfoWindowStream = StreamController<InfoWindowEntity?>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    mInfoWindowStream?.close();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.datas != null && widget.datas!.isEmpty) {
      mScrollX = mSelectX = 0.0;
      mScaleX = 1.0;
    }
    final painter = ChartPainter(
      widget.chartStyle,
      widget.chartColors,
      widget.indicatorColor,
      trendLines: trendLines, //For TrendLine
      xFrontPadding: widget.xFrontPadding,
      isTrendLine: widget.isTrendLine, //For TrendLine
      selectY: mSelectY, //For TrendLine
      datas: widget.datas,
      scaleX: mScaleX,
      scrollX: mScrollX,
      selectX: mSelectX,
      isLongPass: isLongPress,
      isOnTap: isOnTap,
      isTapShowInfoDialog: widget.isTapShowInfoDialog,
      mainState: widget.mainState,
      volHidden: widget.volHidden,
      secondaryState: widget.secondaryState,
      isLine: widget.isLine,
      isCandle: widget.isCandle,
      hideGrid: widget.hideGrid,
      showNowPrice: widget.showNowPrice,
      sink: mInfoWindowStream?.sink,
      fixedLength: widget.fixedLength,
      verticalTextAlignment: widget.verticalTextAlignment,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        mHeight = constraints.maxHeight;
        mWidth = constraints.maxWidth;

        return GestureDetector(
          onTapUp: (details) {
            if (!widget.isTrendLine &&
                widget.onSecondaryTap != null &&
                painter.isInSecondaryRect(details.localPosition)) {
              widget.onSecondaryTap!();
            }

            if (!widget.isTrendLine &&
                    painter.isInMainRect(details.localPosition) ||
                !widget.isHorizontalLine &&
                    painter.isInMainRect(details.localPosition)) {
              isOnTap = true;
              if (mSelectX != details.globalPosition.dx &&
                  widget.isTapShowInfoDialog) {
                mSelectX = details.globalPosition.dx;
                notifyChanged();
              }
            }
            if (widget.isTrendLine && !isLongPress && enableCordRecord) {
              enableCordRecord = false;
              Offset p1 = Offset(getTrendLineX(), mSelectY);
              if (!waitingForOtherPairofCords) {
                trendLines.add(TrendLine(
                    p1, const Offset(-1, -1), trendLineMax!, trendLineScale!));
              }

              if (waitingForOtherPairofCords) {
                var a = trendLines.last;
                trendLines.removeLast();
                trendLines
                    .add(TrendLine(a.p1, p1, trendLineMax!, trendLineScale!));
                waitingForOtherPairofCords = false;
              } else {
                waitingForOtherPairofCords = true;
              }
              notifyChanged();
            }
            if (widget.isHorizontalLine && !isLongPress && enableCordRecord) {
              enableCordRecord = false;
              Offset point1 = const Offset(5, 3);
              Offset point2 = const Offset(-5, 3);
              // double maxHeight = painter.
              // if(!waitingForOtherPairofCords){
              //   verticalLines.add(VerticalLine(point1, point2, , scale))
              // }
            }
          },
          onHorizontalDragDown: (details) {
            isOnTap = false;
            _stopAnimation();
            _onDragChanged(true);

            if (widget.isVerticalLine && isLongPress) {}
          },
          onHorizontalDragUpdate: (details) {
            if (isScale || isLongPress) return;
            mScrollX = ((details.primaryDelta ?? 0) / mScaleX + mScrollX)
                .clamp(0.0, ChartPainter.maxScrollX)
                .toDouble();
            notifyChanged();
          },
          onHorizontalDragEnd: (DragEndDetails details) {
            var velocity = details.velocity.pixelsPerSecond.dx;
            _onFling(velocity);
          },
          onHorizontalDragCancel: () => _onDragChanged(false),
          onScaleStart: (_) {
            isScale = true;
          },
          onScaleUpdate: (details) {
            if (isDrag || isLongPress) return;
            mScaleX = (_lastScale * details.scale).clamp(0.5, 2.2);
            notifyChanged();
          },
          onScaleEnd: (_) {
            isScale = false;
            _lastScale = mScaleX;
          },
          onLongPressStart: (details) {
            isOnTap = false;
            isLongPress = true;
            if ((mSelectX != details.globalPosition.dx ||
                    mSelectY != details.globalPosition.dy) &&
                !widget.isTrendLine) {
              mSelectX = details.globalPosition.dx;
              notifyChanged();
            }
            //For TrendLine
            if (widget.isTrendLine && changeinXposition == null) {
              mSelectX = changeinXposition = details.globalPosition.dx;
              mSelectY = changeinYposition = details.globalPosition.dy;
              notifyChanged();
            }
            //For TrendLine
            if (widget.isTrendLine && changeinXposition != null) {
              changeinXposition = details.globalPosition.dx;
              changeinYposition = details.globalPosition.dy;
              notifyChanged();
            }
          },
          onLongPressMoveUpdate: (details) {
            if ((mSelectX != details.globalPosition.dx ||
                    mSelectY != details.globalPosition.dy) &&
                !widget.isTrendLine) {
              mSelectX = details.globalPosition.dx;
              mSelectY = details.localPosition.dy;
              notifyChanged();
            }
            if (widget.isTrendLine) {
              mSelectX =
                  mSelectX + (details.globalPosition.dx - changeinXposition!);
              changeinXposition = details.globalPosition.dx;
              mSelectY =
                  mSelectY + (details.globalPosition.dy - changeinYposition!);
              changeinYposition = details.globalPosition.dy;
              notifyChanged();
            }
          },
          onLongPressEnd: (details) {
            isLongPress = false;
            enableCordRecord = true;
            mInfoWindowStream?.sink.add(null);
            notifyChanged();
          },
          child: Stack(
            children: <Widget>[
              CustomPaint(
                size: const Size(double.infinity, double.infinity),
                painter: painter,
              ),
              if (widget.showInfoDialog) _buildInfoDialog()
            ],
          ),
        );
      },
    );
  }

  void _stopAnimation({bool needNotify = true}) {
    if (_controller != null && _controller!.isAnimating) {
      _controller!.stop();
      _onDragChanged(false);
      if (needNotify) {
        notifyChanged();
      }
    }
  }

  void _onDragChanged(bool isOnDrag) {
    isDrag = isOnDrag;
    if (widget.isOnDrag != null) {
      widget.isOnDrag!(isDrag);
    }
  }

  void _onFling(double x) {
    _controller = AnimationController(
        duration: Duration(milliseconds: widget.flingTime), vsync: this);
    aniX = null;
    aniX = Tween<double>(begin: mScrollX, end: x * widget.flingRatio + mScrollX)
        .animate(CurvedAnimation(
            parent: _controller!.view, curve: widget.flingCurve));
    aniX!.addListener(() {
      mScrollX = aniX!.value;
      if (mScrollX <= 0) {
        mScrollX = 0;
        if (widget.onLoadMore != null) {
          widget.onLoadMore!(true);
        }
        _stopAnimation();
      } else if (mScrollX >= ChartPainter.maxScrollX) {
        mScrollX = ChartPainter.maxScrollX;
        if (widget.onLoadMore != null) {
          widget.onLoadMore!(false);
        }
        _stopAnimation();
      }
      notifyChanged();
    });
    aniX!.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _onDragChanged(false);
        notifyChanged();
      }
    });
    _controller!.forward();
  }

  void notifyChanged() => setState(() {});

  late List<String> infos;

  Widget _buildInfoDialog() {
    return StreamBuilder<InfoWindowEntity?>(
        stream: mInfoWindowStream?.stream,
        builder: (context, snapshot) {
          if ((!isLongPress && !isOnTap) ||
              widget.isLine == true ||
              !snapshot.hasData ||
              snapshot.data?.kLineEntity == null) return Container();
          KLineEntity entity = snapshot.data!.kLineEntity;
          double upDown = entity.change ?? entity.close - entity.open;
          double upDownPercent = entity.ratio ?? (upDown / entity.open) * 100;
          final double? entityAmount = entity.amount;
          infos = [
            getDate(entity.time),
            entity.open.toStringAsFixed(widget.fixedLength),
            entity.high.toStringAsFixed(widget.fixedLength),
            entity.low.toStringAsFixed(widget.fixedLength),
            entity.close.toStringAsFixed(widget.fixedLength),
            "${upDown > 0 ? "+" : ""}${upDown.toStringAsFixed(widget.fixedLength)}",
            "${upDownPercent > 0 ? "+" : ''}${upDownPercent.toStringAsFixed(2)}%",
            if (entityAmount != null) entityAmount.toInt().toString()
          ];
          const dialogPadding = 4.0;
          final dialogWidth = mWidth / 3;
          return Container(
            margin: EdgeInsets.only(
                left: snapshot.data!.isLeft
                    ? dialogPadding
                    : mWidth - dialogWidth - dialogPadding,
                top: 25),
            width: dialogWidth,
            decoration: BoxDecoration(
                color: widget.chartColors.selectFillColor,
                border: Border.all(
                    color: widget.chartColors.selectBorderColor, width: 0.5)),
            child: ListView.builder(
              padding: const EdgeInsets.all(dialogPadding),
              itemCount: infos.length,
              itemExtent: 14.0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final translations = widget.translations.of(context);

                return _buildItem(
                  infos[index],
                  translations.byIndex(index),
                );
              },
            ),
          );
        });
  }

  Widget _buildItem(String info, String infoName) {
    Color color = widget.chartColors.infoWindowNormalColor;
    if (info.startsWith("+")) {
      color = widget.chartColors.infoWindowUpColor;
    } else if (info.startsWith("-")) {
      color = widget.chartColors.infoWindowDnColor;
    }
    final infoWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: Text(infoName,
                style: TextStyle(
                    color: widget.chartColors.infoWindowTitleColor,
                    fontSize: 10.0))),
        Text(info, style: TextStyle(color: color, fontSize: 10.0)),
      ],
    );
    return widget.materialInfoDialog
        ? Material(color: Colors.transparent, child: infoWidget)
        : infoWidget;
  }

  String getDate(int? date) => dateFormat(
      DateTime.fromMillisecondsSinceEpoch(
          date ?? DateTime.now().millisecondsSinceEpoch),
      widget.timeFormat);
}
