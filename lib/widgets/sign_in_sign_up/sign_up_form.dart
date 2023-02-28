import 'package:flutter/material.dart';

import '../../constants/form_error_constants.dart';
import '../../screens/sign_in_and_sign_up/sign_in.dart';
import '../widgets.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUPFormState();
}

class _SignUPFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  final List<String> errors = [];
  late bool newValue;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: emailField()),
          const SizedBox(
            height: 20,
          ),
          // buildEmailFormField(),
          TextFormField(
              keyboardType: TextInputType.name, decoration: userNameField()),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: passwordField()),
          const SizedBox(
            height: 20,
          ),
          // buildPasswordFormField(),
          TextFormField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: confirmPasswordField()),
          FormError(errors: errors),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              // if (_formKey.currentState!.validate()) {
              //   _formKey.currentState?.save();
              // }
              Navigator.pushNamed(context, SignInScreen.routeName);
            },
            child: const DefaultButton(
                texts: Text(
              "Sign Up",
              style: TextStyle(color: Colors.white),
            )),
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
        obscureText: true,

        //password change
        onSaved: (newValue) => password = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kPassNullError)) {
            setState(() {
              errors.remove(kPassNullError);
            });
          } else if (value.length >= 8 && errors.contains(kShortPassError)) {
            setState(() {
              errors.remove(kShortPassError);
            });
          }
          return null;
        },

        //password validator

        validator: (value) {
          if (value!.isEmpty && !errors.contains(kPassNullError)) {
            setState(() {
              errors.add(kPassNullError);
            });
          } else if (value.length < 8 && !errors.contains(kShortPassError)) {
            setState(() {
              errors.add(kShortPassError);
            });
          }
          return null;
        },
        keyboardType: TextInputType.visiblePassword,
        decoration: passwordField());
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kEmailNullError)) {
            setState(() {
              errors.remove(kEmailNullError);
            });
          } else if (emailValidateRegExp.hasMatch(value) &&
              errors.contains(kInvalidEmailError)) {
            setState(() {
              errors.remove(kInvalidEmailError);
            });
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty && !errors.contains(kEmailNullError)) {
            setState(() {
              errors.add(kEmailNullError);
            });
          } else if (!emailValidateRegExp.hasMatch(value) &&
              !errors.contains(kInvalidEmailError)) {
            setState(() {
              errors.add(kInvalidEmailError);
            });
          }
          return null;
        },
        decoration: emailField());
  }
}
