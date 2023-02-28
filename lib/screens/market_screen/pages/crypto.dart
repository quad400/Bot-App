import 'package:flutter/material.dart';
import 'package:frontend/data/market_data.dart';
import 'package:frontend/widgets/widgets.dart';

import '../../../data/view_data.dart';

class CryptoTabViews extends StatefulWidget {
  CryptoTabViews({Key? key}) : super(key: key);

  @override
  State<CryptoTabViews> createState() => _CryptoTabViewsState();
}

class _CryptoTabViewsState extends State<CryptoTabViews> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 5, right: 5),
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: crypto.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: (){
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => CryptoBuildSheet(context: context, index: index),
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
                                  crypto[index].name,
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
                                      '${crypto[index].marketHigh}',
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
                                      '${crypto[index].rate}%',
                                      style: const TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.red),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text('${crypto[index].marketLow}',
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
                              crypto[index].fullName,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade400,
                                letterSpacing: -0.7,
                              ),
                            ),
                            Text(
                              "H: ${forex[index].high}     -     L: ${crypto[index].low}",
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
