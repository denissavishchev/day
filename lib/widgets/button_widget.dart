import 'package:flutter/material.dart';
import '../constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onTap,
    required this.icon,
    this.colorOne = kGrey,
    this.colorTwo = kBlue,
    this.iconColor = kBlue,
  });

  final IconData icon;
  final Color colorOne;
  final Color colorTwo;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.height * 0.06,
        height: size.height * 0.06,
        decoration: BoxDecoration(
            border: Border.all(
                color: kBlue,
                width: 1),
            boxShadow: [
              BoxShadow(
                  color: kBlack.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 2)
              )
            ],
            gradient: LinearGradient(
                colors: [
                  colorOne,
                  colorTwo
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft
            ),
            borderRadius: const BorderRadius.all(Radius.circular(14))
        ),
        child: Center(
          child: Icon(icon, color: iconColor, size: 32,),
        ),
      ),
    );
  }
}