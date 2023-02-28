// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Function onPressed;
  
  const CircleIcon({
    Key? key,
    required this.icon,
    required this.iconSize,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 13,
      splashColor: Colors.transparent,
      icon:  Icon(
        icon,
        color: Colors.black,
        size: iconSize,
      ),
      onPressed: onPressed(),
    );
  }
}
