import 'package:flutter/widgets.dart';

import 'package:frontend/screens/sign_in_and_sign_up/index.dart';
import 'package:frontend/screens/chart_screen/index.dart';
import 'package:frontend/screens/market_screen/body.dart';

import '../widgets/market/search_bar.dart';

final Map<String, WidgetBuilder> routes = {
  //sign in sign up
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  ForgetPasswordScreen.routeName: (context) => const ForgetPasswordScreen(),
  OtpPage.routeName: (context) => const OtpPage(),
  CreateNewPassword.routeName: (context) => const CreateNewPassword(),

  //market
  MarketScreen.routeName: (context) => MarketScreen(),
  MySearchBar.routeName: (context) => const MySearchBar(),

  //chart
  ChartScreen.routeName: (context) => ChartScreen(),
};
