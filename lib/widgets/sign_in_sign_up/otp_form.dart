import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildOtpForm(context),
            buildOtpForm(context),
            buildOtpForm(context),
            buildOtpForm(context)
          ],
        ),
      ),
    );
  }

  SizedBox buildOtpForm(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 60,
      child: TextFormField(
        onChanged: ((value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        }),
        decoration: InputDecoration(
            hintText: '*',
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            filled: true,
            fillColor: Colors.grey[200],
            floatingLabelBehavior: FloatingLabelBehavior.always,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
              gapPadding: 10,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black12),
              gapPadding: 10,
            )),
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
