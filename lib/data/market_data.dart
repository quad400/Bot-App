// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Markets {
  final String name;
  final String fullName;
  final double marketHigh;
  final double marketLow;
  final double rate;
  final double high;
  final double low;
  final IconData trend;

  const Markets({
    required this.name,
    required this.fullName,
    required this.marketHigh,
    required this.marketLow,
    required this.rate,
    required this.high,
    required this.low,
    required this.trend,
  });
}


  enum menuItem {
    symbol,
    auto,
    settings
  }

  
final List<Markets> favourite = [
  const Markets(
      name: 'BTC/USD',
      fullName: 'Bitcoin/US Dollar',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'EUR/USD',
      fullName: 'Euro/US Dollar',
      marketHigh: 1.67493,
      marketLow: 1.67284,
      rate: 1.4,
      high: 1.83646,
      low: 1.62838,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'AAPL',
      fullName: 'Apple Inc.',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'BTC/USD',
      fullName: 'Bitcoin/US Dollar',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
];


final List<Markets> forex = [
  const Markets(
      name: 'BTC/USD',
      fullName: 'Bitcoin/US Dollar',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'EUR/USD',
      fullName: 'Euro/US Dollar',
      marketHigh: 1.67493,
      marketLow: 1.67284,
      rate: 1.4,
      high: 1.83646,
      low: 1.62838,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'AAPL',
      fullName: 'Apple Inc.',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'BTC/USD',
      fullName: 'Bitcoin/US Dollar',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
];


final List<Markets> crypto = [
  const Markets(
      name: 'BTC/USD',
      fullName: 'Bitcoin/US Dollar',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'EUR/USD',
      fullName: 'Euro/US Dollar',
      marketHigh: 1.67493,
      marketLow: 1.67284,
      rate: 1.4,
      high: 1.83646,
      low: 1.62838,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'AAPL',
      fullName: 'Apple Inc.',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'BTC/USD',
      fullName: 'Bitcoin/US Dollar',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
];

final List<Markets> indicies = [
  const Markets(
      name: 'BTC/USD',
      fullName: 'Bitcoin/US Dollar',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'EUR/USD',
      fullName: 'Euro/US Dollar',
      marketHigh: 1.67493,
      marketLow: 1.67284,
      rate: 1.4,
      high: 1.83646,
      low: 1.62838,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'AAPL',
      fullName: 'Apple Inc.',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'BTC/USD',
      fullName: 'Bitcoin/US Dollar',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
];

final List<Markets> commodities = [
  const Markets(
      name: 'BTC/USD',
      fullName: 'Bitcoin/US Dollar',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'EUR/USD',
      fullName: 'Euro/US Dollar',
      marketHigh: 1.67493,
      marketLow: 1.67284,
      rate: 1.4,
      high: 1.83646,
      low: 1.62838,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'AAPL',
      fullName: 'Apple Inc.',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'BTC/USD',
      fullName: 'Bitcoin/US Dollar',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
];

final List<Markets> futures = [
  const Markets(
      name: 'BTC/USD',
      fullName: 'Bitcoin/US Dollar',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'EUR/USD',
      fullName: 'Euro/US Dollar',
      marketHigh: 1.67493,
      marketLow: 1.67284,
      rate: 1.4,
      high: 1.83646,
      low: 1.62838,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'AAPL',
      fullName: 'Apple Inc.',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'BTC/USD',
      fullName: 'Bitcoin/US Dollar',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
];

final List<Markets> stock = [
  const Markets(
      name: 'BTC/USD',
      fullName: 'Bitcoin/US Dollar',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'EUR/USD',
      fullName: 'Euro/US Dollar',
      marketHigh: 1.67493,
      marketLow: 1.67284,
      rate: 1.4,
      high: 1.83646,
      low: 1.62838,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'AAPL',
      fullName: 'Apple Inc.',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
  const Markets(
      name: 'BTC/USD',
      fullName: 'Bitcoin/US Dollar',
      marketHigh: 1.34567,
      marketLow: 1.33234,
      rate: 2,
      high: 1.44567,
      low: 1.23453,
      trend: Icons.arrow_upward),
];
