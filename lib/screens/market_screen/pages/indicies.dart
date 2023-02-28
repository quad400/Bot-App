import 'package:flutter/material.dart';
import 'package:frontend/data/market_data.dart';

import '../../../data/view_data.dart';
import '../../../widgets/widgets.dart';

class IndiciesTabViews extends StatefulWidget {
  IndiciesTabViews({Key? key}) : super(key: key);

  @override
  State<IndiciesTabViews> createState() => _IndiciesTabViewsState();
}

class _IndiciesTabViewsState extends State<IndiciesTabViews> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 5, right: 5),
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: indicies.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => IndiciesBuildSheet(context: context, index: index),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  indicies[index].name,
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                const Icon(
                                  Icons.arrow_upward,
                                  color: Colors.red,
                                  size: 12,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${indicies[index].marketHigh}',
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      '${indicies[index].rate}%',
                                      style: const TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.red),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text('${indicies[index].marketLow}',
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w500,
                                        ))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              indicies[index].fullName,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade400,
                                letterSpacing: -0.7,
                              ),
                            ),
                            Text(
                              "H: ${indicies[index].high}     -     L: ${indicies[index].low}",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade400,
                                letterSpacing: -0.3,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
