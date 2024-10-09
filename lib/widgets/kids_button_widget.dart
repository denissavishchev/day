import 'package:flutter/material.dart';

import '../constants.dart';

class KidsButtonWidget extends StatelessWidget {
  const KidsButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
    required this.isOn,
  });

  final String text;
  final bool isOn;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: kGrey.withOpacity(0.3)),
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
                  isOn ? kTangerine : kBlue.withOpacity(0.3),
                  isOn ? kTangerineLight : kWhite.withOpacity(0.9)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            ),
            borderRadius: const BorderRadius.all(Radius.circular(50))
        ),
        child: Container(
          width: size.height * 0.06,
          height: size.height * 0.06,
          decoration: BoxDecoration(
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
                    kWhite,
                    kBlue.withOpacity(0.8)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              ),
              borderRadius: const BorderRadius.all(Radius.circular(50))
          ),
          child: Center(
            child: Text(text,
              style: TextStyle(
                  color: isOn ? kTangerine : kGrey,
                  fontSize: 26,
                  fontWeight: FontWeight.bold
              ),),
          ),
        ),
      ),
    );
  }
}