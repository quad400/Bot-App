import 'package:frontend/chart/entity/std_entity.dart';

import 'cci_entity.dart';
import 'kdj_entity.dart';
import 'rsi_entity.dart';
import 'rw_entity.dart';

mixin MACDEntity on KDJEntity, RSIEntity, WREntity, CCIEntity, STDEntity{
  double? dea;
  double? dif;
  double? macd;
}
