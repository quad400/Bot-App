import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:frontend/screens/sign_in_and_sign_up/index.dart';
import 'package:frontend/widgets/widgets.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static String routeName = '/forget_password';
  const ForgetPasswordScreen({Key? key}) : super(key: key);

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
          'Forget Password',
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
        height: double.maxFinite,
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              'Forgot Password',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Please enter your email and we will send \nyou link to return to your account',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Form(
              child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: emailField()),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, OtpPage.routeName);
              },
              child: const DefaultButton(
                  texts: Text(
                "Verify Email",
                style: TextStyle(color: Colors.white),
              )),
            ),
            const Spacer(
              flex: 1,
            ),
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
              flex: 3,
            )
          ],
        ),
      ),
    );
  }
}
