// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KroundedButton extends StatelessWidget {
  KroundedButton(
      {this.title, this.colour, this.onPressed});
  final Color colour;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}



class ReusableCard_2 extends StatelessWidget {
  ReusableCard_2({ this.colour,  this.cardChild, this.onPress});

  Color colour;
  Widget cardChild;
  VoidCallback  onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(

        child: cardChild,
        decoration: BoxDecoration(

          color: colour,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(12),

      ),
    );
  }
}



