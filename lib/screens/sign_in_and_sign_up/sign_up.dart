// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:frontend/screens/sign_in_and_sign_up/sign_in.dart';

import '../../widgets/widgets.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = '/sign_up';
  const SignUpScreen({super.key});

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
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Sign Up',
          style: TextStyle(color: Colors.black26, fontSize: 17),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [IconButton(
          icon: Icon(Icons.question_mark_outlined),
          onPressed: (){},
        )],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Register Account',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'create your account and start trading with robots',
                style: TextStyle(color: Colors.black45, fontSize: 13),
              ),
              const SizedBox(
                height: 25,
              ),
              //Sign In Text Field
              SignUpForm(),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?  ',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, SignInScreen.routeName);
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              //social media
              const SocialMedia(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'By signing up, you agree to our',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Terms of Use',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    ' and ',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


