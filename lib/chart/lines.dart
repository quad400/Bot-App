import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../screens/chart_screen/pages/indicator_input.dart';
import 'entity/k_line_entity.dart';

class TrendLine {
  final Offset p1;
  final Offset p2;
  final double maxHeight;
  final double scale;

  TrendLine(this.p1, this.p2, this.maxHeight, this.scale);
}

class VerticalLine {
  final Offset p1;
  final Offset p2;
  final double maxHeight;
  final double scale;

  VerticalLine(this.p1, this.p2, this.maxHeight, this.scale);
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

// List solveChatData(String result,  ) {
//   final Map parseJson = json.decode(result) as Map<dynamic, dynamic>;
//   final list = parseJson['data'] as List<dynamic>;
//   List<KLineEntity>? datas = list
//       .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
//       .toList()
//       .reversed
//       .toList()
//       .cast<KLineEntity>();
//   return datas;
// }


