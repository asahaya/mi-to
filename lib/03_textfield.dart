import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final String? keyboardType;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        style: TextStyle(fontFamily: 'BananaS'),
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType == 'mail'
            ? TextInputType.emailAddress
            : TextInputType.visiblePassword,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade400),
          ),
          fillColor: Colors.white.withOpacity(0.7),
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
