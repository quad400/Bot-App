import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:frontend/screens/market_screen/index.dart';

class CustomTab extends StatefulWidget {
  const CustomTab({super.key});

  @override
  State<CustomTab> createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 7, vsync: this);
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: TabBar(
            controller: tabController,
            padding: const EdgeInsets.all(0),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade300,
            indicatorColor: const Color.fromARGB(255, 216, 139, 4),
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
            physics: const BouncingScrollPhysics(),
            tabs: [
              Tab(
                child: Row(
                  children: const [
                    Icon(Icons.star, size: 18, color: Colors.amber),
                    Text('Favourite')
                  ],
                ),
              ),
              const Tab(
                text: 'Forex',
              ),
              const Tab(
                text: 'Cryptocurrency',
              ),
              const Tab(
                text: 'Stocks',
              ),
              const Tab(
                text: 'Commodities',
              ),
              const Tab(
                text: 'Indicies',
              ),
              const Tab(
                text: 'Futures',
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Container(
              margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              width: double.maxFinite,
              height: 425.1,
              child: TabBarView(
                controller: tabController,
                children: [
                  FavouriteTabViews(),
                  ForexTabViews(),
                  CryptoTabViews(),
                  StockTabViews(),
                  CommoditiesTabViews(),
                  IndiciesTabViews(),
                  FuturesTabViews(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
