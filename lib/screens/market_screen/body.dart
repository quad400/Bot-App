import 'package:flutter/material.dart';
import 'package:frontend/screens/market_screen/index.dart';
import 'package:frontend/widgets/widgets.dart';

import '../../data/market_data.dart';

class MarketScreen extends StatefulWidget {
  static String routeName = '/market';
  MarketScreen({Key? key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  int currentIndex = 0;

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50.withOpacity(0.5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Markets',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: -1.2),
        ),
        actions: [
          IconButton(
              splashRadius: 13,
              splashColor: Colors.transparent,
              icon: const Icon(
                Icons.search,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {
                Navigator.pushNamed(context, MySearchBar.routeName);
              }),
          PopupMenuButton<menuItem>(
              onSelected: (value) {
                if (value == menuItem.symbol) {
                } else if (value == menuItem.auto) {
                } else if (value == menuItem.settings) {}
              },
              icon: const Icon(
                Icons.more_vert_outlined,
                color: Colors.black,
                size: 20,
              ),
              splashRadius: 14,
              itemBuilder: (context) => const [
                    PopupMenuItem(
                        value: menuItem.symbol,
                        child: Text(
                          'Add Symbol',
                          style:
                              TextStyle(fontSize: 12, fontFamily: 'Montserrat'),
                        )),
                    PopupMenuItem(
                        value: menuItem.auto,
                        child:
                            Text('Auto Trade', style: TextStyle(fontSize: 12))),
                    PopupMenuItem(
                        value: menuItem.settings,
                        child:
                            Text('Settings', style: TextStyle(fontSize: 12))),
                  ])
        ],
      ),
      body: const CustomTab(),
    );
  }
}
