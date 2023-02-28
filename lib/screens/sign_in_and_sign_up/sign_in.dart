import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:frontend/screens/sign_in_and_sign_up/sign_up.dart';
import 'package:frontend/screens/sign_in_and_sign_up/index.dart';
import '../../widgets/widgets.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = '/sign_in';
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //build the app bar

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
          'Sign In',
          style: TextStyle(color: Colors.black26, fontSize: 17),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              splashRadius: 10,
              iconSize: 14,
              onPressed: () {},
              icon: const Icon(
                Icons.question_mark_rounded,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Welcome back!',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Sign In to your account with your email and password\n or continue with social media',
              style: TextStyle(color: Colors.black26, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            SignInForm(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?  ',
                    style: TextStyle(fontSize: 12, color: Colors.black54)),
                InkWell(
                    onTap: () {
                      Navigator.popAndPushNamed(
                          context, SignUpScreen.routeName);
                    },
                    child: const Text('Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12)))
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            const SocialMedia(),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
