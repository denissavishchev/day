import 'package:flutter/material.dart';
import '../constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.icon,
    required this.onTap,
    required this.checked,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.height * 0.07,
        height: size.height * 0.14,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: kBlue),
          boxShadow: [
            BoxShadow(
              color: kBlue.withOpacity(0.5),
              spreadRadius: 2.0,
              blurRadius: 2.0,
            ),
          ],
            gradient: const LinearGradient(
                colors: [
                  kGrey,
                  kBlue
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft
            ),
            borderRadius: const BorderRadius.all(Radius.circular(18)),
        ),
        child: Container(
          width: size.height * 0.06,
          height: size.height * 0.06,
          decoration: BoxDecoration(
              border: Border.all(
                  color: checked ? kRed : kBlue,
                  width: 1),
              boxShadow: [
                BoxShadow(
                    color: checked ? kRed.withOpacity(0.3) : kBlack.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 2)
                )
              ],
              gradient: const LinearGradient(
                  colors: [
                    kGrey,
                    kBlue
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
              ),
              borderRadius: const BorderRadius.all(Radius.circular(100))
          ),
          child: Icon(icon, color: checked ? kRed : kBlue,
          ),
        ),
      ),
    );
  }
}