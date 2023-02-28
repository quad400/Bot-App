// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

final times = [
  '1 Minute',
  '5 Minutes',
  '15 Minutes',
  '30 Minutes',
  '1 Hour',
  '2 Hour',
  '4 Hour',
  'Daily',
  'Weekly',
  'Montly'
];

//bar type
class ChartBars {
  final String barName;
  final IconData? icon;
  bool isName;
  ChartBars({
    required this.barName,
    this.icon,
    this.isName = false,
  });
}

List<ChartBars> bars = [
  ChartBars(icon: Icons.leaderboard, barName: 'Bar'),
  ChartBars(barName: 'Line', icon: Icons.timeline),
  ChartBars(barName: 'Candle Stick', icon: Icons.candlestick_chart),
  ChartBars(barName: 'Hollow', icon: Icons.candlestick_chart_outlined)
];

//tools factory
class ToolFactory {
  final String toolName;
  final IconData icon;
  ToolFactory({
    required this.toolName,
    required this.icon,
  });
}

List<ToolFactory> tools = [
  ToolFactory(toolName: 'Lock', icon: Icons.lock),
  ToolFactory(toolName: 'Text', icon: Icons.text_fields),
  ToolFactory(toolName: 'Expand', icon: Icons.fullscreen),
  ToolFactory(toolName: 'Contract', icon: Icons.close_fullscreen),
  ToolFactory(toolName: 'Zoom In', icon: Icons.zoom_in),
  ToolFactory(toolName: 'Zoom Out', icon: Icons.zoom_out),
  ToolFactory(toolName: 'Ruler', icon: Icons.straighten),
  ToolFactory(toolName: 'Cross', icon: Icons.add)
];

// equipments
class Equipments {
  final String equipName;
  final IconData icon;
  int count;
  Equipments({required this.equipName, required this.icon, this.count = 0});
}

////lines
List<Equipments> lines = [
  // Equipments(equipName: 'Horizontal', icon: Icons.horizontal_rule),
  // Equipments(equipName: 'Vertical', icon: Icons.horizontal_rule),
  Equipments(equipName: 'Trend', icon: Icons.horizontal_rule),
  // Equipments(equipName: 'Arrow', icon: Icons.straight_sharp),
];


//More Button

class MoreButton {
  final String moreName;
  final IconData icon;
  MoreButton({
    required this.moreName,
    required this.icon,
  });
}

List<MoreButton> mores = [
  MoreButton(moreName: 'Chart Details', icon: Icons.details_sharp),
  MoreButton(moreName: 'Trading Strategy', icon: Icons.details),
  MoreButton(moreName: 'Chart Settings', icon: Icons.details_sharp),
  MoreButton(moreName: 'Financial News', icon: Icons.details_sharp),
  MoreButton(moreName: 'Financial Calender', icon: Icons.details_sharp),
  MoreButton(moreName: 'Share Chart', icon: Icons.details_sharp),
  MoreButton(moreName: 'Save Chart', icon: Icons.details_sharp),
  MoreButton(moreName: 'Connect Broker', icon: Icons.details_sharp),
];


