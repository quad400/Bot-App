// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:frontend/constants/form_error_constants.dart';
import 'package:frontend/screens/sign_in_and_sign_up/index.dart';
import '../widgets.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  final List<String> errors = [];
  late bool newValue;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          const SizedBox(
            height: 20,
          ),
          buildPasswordFormField(),
          const SizedBox(
            height: 25,
          ),
          FormError(errors: errors),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (value) {
                  setState(() {
                    value = newValue;
                  });
                },
                activeColor: Colors.black,
                checkColor: Colors.black,
              ),
              const Text(
                'Remember me',
                style: TextStyle(fontSize: 13),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.popAndPushNamed(
                      context, ForgetPasswordScreen.routeName);
                },
                child: const Text(
                  'forgot password',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
              }
              //  Navigator.pushNamed(context, SignInScreen.routeName);
            },
            child: const DefaultButton(
                texts: Text(
              "Continue",
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
