import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'create_new_password.dart';
import 'package:frontend/widgets/widgets.dart';

class OtpPage extends StatelessWidget {
  static String routeName = '/otp/';
  const OtpPage({super.key});

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
          'OTP',
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
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Text(
              'OTP Verification',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'We\'ve sent you the PIN at ',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                Text('(+234) 081-0649-0229',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))
              ],
            ),
            const Spacer(),
            const OtpForm(),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'This code will expires at ',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  '1:00',
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, CreateNewPassword.routeName);
              },
              child: const DefaultButton(
                texts: Text(
                  "Verify",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const Spacer(),
            const Text(
              'Didn\'t receive any code?',
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              highlightColor: Colors.transparent,
              child: const Text(
                'Resend OTP code',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
