import 'package:flutter/material.dart';
import 'package:basic_rest_crud/src/constants/constants.dart' as constants;

class SignUpTitle extends StatelessWidget {

  final double titleFontSize;

  const SignUpTitle({
    Key? key, 
    this.titleFontSize = 25.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.0,
      child: Column(
        children: [
          Text(
            constants.signUpTitle,
            style: TextStyle( fontSize: this.titleFontSize, fontWeight: FontWeight.w400 )
          ),
          Container(
            margin: const EdgeInsets.symmetric( vertical: 3.0 ),
            height: 3.0,
            width: 130.0,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}