 import 'package:flutter/material.dart';

InputDecoration emailField() {
    return InputDecoration(
          hintText: 'Email',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          filled: true,
          suffixIcon: Icon(
            Icons.mail_outlined,
            size: 14,
          ),
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
              )
            );
  }

InputDecoration userNameField() {
    return InputDecoration(
          hintText: 'UserName',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          filled: true,
          suffixIcon: Icon(
            Icons.person,
            size: 14,
          ),
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
              )
            );
  }