import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {

  String text = '';

  NoDataWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
              'assets/img/cero-items.png',
            height: MediaQuery.of(context).size.height * .25,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
              text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
