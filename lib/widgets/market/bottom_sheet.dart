import 'package:flutter/material.dart';

class CustBottomSheet extends StatefulWidget {
  CustBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustBottomSheet> createState() => _CustBottomSheetState();
}

class _CustBottomSheetState extends State<CustBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Click Me'),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) => buildSheet(context),
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))));
          },
        ),
      ),
    );
  }

  Widget buildSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              print('place order');
            },
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
          const Divider(),
          GestureDetector(
            onTap: () {
              print('Strategy');
            },
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
          const Divider(),
          GestureDetector(
            onTap: () {
              print('Details');
            },
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
          const Divider(),
          GestureDetector(
            onTap: () {
              print('Delete');
            },
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
