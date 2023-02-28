import 'package:flutter/material.dart';

import '../../../data/chart_data.dart';

void timerDialog(BuildContext context, int selectedValue) {
    final timer = times.asMap().values.toList();
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Time Interval',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Wrap(
                          children: List.generate(times.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedValue = index;
                            });
                          },
                          child: Container(
                              // height: 30,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 7),
                              decoration: BoxDecoration(
                                  color: selectedValue == index
                                      ? Colors.black87
                                      : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                timer[index],
                                style: TextStyle(
                                    fontSize: 13,
                                    color: selectedValue == index
                                        ? Colors.white
                                        : Colors.black),
                              )),
                        );
                      })),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 3)),
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
