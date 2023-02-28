import 'package:flutter/material.dart';

import '../../data/chart_data.dart';

Widget buildMoreSheet(BuildContext context) {
  Widget makeDismissible({required Widget child}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );
  }

  return Container(
    height: 900,
    color: Colors.transparent,
    child: makeDismissible(
      child: DraggableScrollableSheet(
        maxChildSize: 0.7,
        initialChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
          child: ListView(children: [
            Text('MORE',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.w600, letterSpacing: -0.7)),
            const Divider(
              thickness: 0.3,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: mores
                  .map((e) => GestureDetector(
                        onTap: () => print(e.moreName),
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 7),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(e.icon),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                e.moreName,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis),
                              )
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            )
          ]),
        ),
      ),
    ),
  );
}
