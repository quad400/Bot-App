// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SocialMedia extends StatelessWidget {
  const SocialMedia({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {},
          child: Container(
            height: 30,
            width: 30,
            padding: EdgeInsets.all(5),
            decoration:
                BoxDecoration(color: Color(0xFFF5F6F9), shape: BoxShape.circle),
            child: SvgPicture.asset(
              "/icons/icons8-google.svg",
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        IconButton(
          icon: Icon(Icons.facebook_outlined),
          onPressed: (){},
        ),
        const SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            height: 30,
            width: 30,
            padding: EdgeInsets.all(5),
            decoration:
                BoxDecoration(color: Color(0xFFF5F6F9), shape: BoxShape.circle),
            child: SvgPicture.asset(
              "/icons/icons8-twitter.svg",
            ),
          ),
        ),
      ],
    );
  }
}

