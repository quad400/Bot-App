// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Text? texts;
  const DefaultButton({
    Key? key,
    this.texts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 235, 233, 233),
                offset: Offset(2, 4),
                spreadRadius: 2,
                blurRadius: 3)
          ],
          color: Colors.black,
        ),
        child: texts);
  }
}
