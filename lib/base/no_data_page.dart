import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPage({Key? key, required this.text,
  this.imgPath = "images/empty_cart.jpg",}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgPath,
          height: MediaQuery.of(context).size.height*0.5,
          width: MediaQuery.of(context).size.width*0.5,
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
        Text(
          text, 
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height*0.03,
            color: Theme.of(context).disabledColor
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}