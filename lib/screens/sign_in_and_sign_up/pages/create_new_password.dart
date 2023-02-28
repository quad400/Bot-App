import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNewPassword extends StatelessWidget {
  static String routeName = '/reset_password/';
  const CreateNewPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            splashRadius: 13,
            iconSize: 17,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'Reset',
            style: TextStyle(color: Colors.black26, fontSize: 17),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [
            Text(
              'Reset Password',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ]),
        ));
  }
}
