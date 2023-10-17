import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final onPressed;
  final String text;
  final double? height;
  const CommonButton(
      {super.key, required this.onPressed, required this.text, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
            ),
          )),
    );
  }
}
