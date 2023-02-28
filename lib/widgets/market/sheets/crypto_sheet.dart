// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../data/market_data.dart';

class CryptoBuildSheet extends StatelessWidget {
  
  const CryptoBuildSheet({
    Key? key,
    required this.context,
    required this.index,
  }) : super(key: key);

  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(5, 10, 30, 5),
              child: Row(
                children: [
                  Text(
                    crypto[index].name,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    crypto[index].fullName,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade400,
                      letterSpacing: -0.7,
                    ),
                  )
                ],
              )),
          const Divider(
            thickness: 0.3,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: const Text(
                'Place Order',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  // backgroundColor: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Divider(
            thickness: 0.5,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: const Text(
                'Market Strategy',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  // backgroundColor: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Divider(
            thickness: 0.5,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: const Text(
                'Details',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  // backgroundColor: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Divider(
            thickness: 0.5,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  // backgroundColor: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
