import 'package:flutter/material.dart';

InputDecoration passwordField() {
    return InputDecoration(
          hintText: 'Password',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          filled: true,
          suffixIcon: Icon(
            Icons.lock_outline,
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

InputDecoration confirmPasswordField() {
    return InputDecoration(
          hintText: 'Confirm Password',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          filled: true,
          suffixIcon: Icon(
            Icons.lock_outline,
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

