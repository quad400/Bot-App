import 'package:flutter/material.dart';

import 'chart_screen/index.dart';
import 'market_screen/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 1;
  final screens = [
    MarketScreen(),
    ChartScreen(),
    const Center(
        child: Icon(
      Icons.assessment,
      size: 70,
      color: Colors.black,
    )),
    const Center(
        child: Icon(
      Icons.article,
      size: 70,
      color: Colors.black,
    )),
    const Center(
        child: Icon(
      Icons.art_track,
      size: 70,
      color: Colors.black,
    ))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            backgroundColor: Colors.white,
            elevation: 5,
            labelTextStyle: MaterialStateProperty.all(const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: -1.1)),
            indicatorColor: Colors.transparent),
        child: NavigationBar(
          height: 50,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() {
            this.index = index;
          }),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: const [
            NavigationDestination(
                icon: Icon(
                  Icons.swap_vert_outlined,
                  size: 18,
                ),
                selectedIcon: Icon(
                  Icons.swap_vert,
                  size: 22,
                ),
                label: 'Markets'),
            NavigationDestination(
                icon: Icon(
                  Icons.timeline_outlined,
                  size: 18,
                ),
                selectedIcon: Icon(
                  Icons.timeline,
                  size: 22,
                ),
                label: 'Chart'),
            NavigationDestination(
                icon: Icon(
                  Icons.assessment_outlined,
                  size: 18,
                ),
                selectedIcon: Icon(
                  Icons.assessment,
                  size: 22,
                ),
                label: 'Order'),
            NavigationDestination(
                icon: Icon(
                  Icons.article_outlined,
                  size: 18,
                ),
                selectedIcon: Icon(
                  Icons.article,
                  size: 22,
                ),
                label: 'News'),
            NavigationDestination(
                icon: Icon(
                  Icons.auto_graph_outlined,
                  size: 18,
                ),
                selectedIcon: Icon(
                  Icons.auto_graph,
                  size: 22,
                ),
                label: 'Robot'),
          ],
        ),
      ),
    );
  }
}
