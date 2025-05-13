import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  const RichTextWidget({super.key, required this.firstText, required this.secondText});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: secondText,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
