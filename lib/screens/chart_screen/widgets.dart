import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:frontend/chart/model/flutter_k_chart.dart';

import 'pages/indicator_input.dart';
import 'pages/indicator_style_widget.dart';

Widget buttonChartType(IconData icon, String text, {VoidCallback? onPressed}) {
  return StatefulBuilder(
    builder: (context, setState) => TextButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
          setState(() {});
        }
      },
      style: TextButton.styleFrom(
        primary: Colors.black,
        minimumSize: const Size(100, 44),
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
        ),
        backgroundColor: Colors.white,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.black,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          )
        ],
      ),
    ),
  );
}

Widget buildToolsButton(String toolName, IconData icon, Function() onTap) {
  return StatefulBuilder(builder: (context, setState) {
    return InkWell(
      onTap: () {
        onTap();
        Navigator.of(context).pop();
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Icon(icon),
            Text(
              toolName,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  });
}

Widget buildEquipmentButton(String equipName, IconData icon, Function() onTap) {
  return StatefulBuilder(builder: (context, setState) {
    return InkWell(
      onTap: () {
        onTap();
        setState(() {});
        Navigator.of(context).pop();
      },
      child: Container(
        width: 112,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(
              width: 4,
            ),
            Text(
              equipName,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  });
}

Widget buildIndicatorButton(String text, Function() onPressed) {
  return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        primary: Colors.black,
        minimumSize: const Size(double.infinity, 60),
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        backgroundColor: Colors.grey.shade300.withOpacity(0.1),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ]));
}

Widget makeDismissible({required Widget child}) {
  return StatefulBuilder(
      builder: ((context, _) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).pop(),
            child: GestureDetector(
              onTap: () {},
              child: child,
            ),
          )));
}

//                           pickColor(context);
//                           reset = false;
//                         });
//                       },
//                       style: TextButton.styleFrom(
//                         elevation: 0,
//                         fixedSize: const Size(80, 40),
//                         backgroundColor: Colors.grey.shade300,
//                         primary: Colors.black,
//                         onSurface: Colors.black,
//                       ),
//                       child: const Text(
//                         'Reset',
//                         style: TextStyle(fontSize: 16, color: Colors.black),
//                       ),
//                     ),
//                     TextButton(
//                         onPressed: () {
//                           mainS = MainState.BOLL;
//                           DataUtil.calcBollingerBands(
//                               datas!,
//                               int.parse(controllerPeriod.text),
//                               int.parse(controllerDeviation.text));
//                           Navigator.pop(context);
//                           setState(() {});
//                         },
//                         style: TextButton.styleFrom(
//                           elevation: 0,
//                           fixedSize: const Size(80, 40),
//                           backgroundColor: Colors.grey.shade300,
//                           primary: Colors.black,
//                           onSurface: Colors.black,
//                         ),
//                         child: const Text(
//                           'Apply',
//                           style: TextStyle(fontSize: 16, color: Colors.black),
//                         )),
//                   ]),
//             ),
//           ],
//         ),
//       );
//     });

