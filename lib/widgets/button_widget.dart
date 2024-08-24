import 'package:flutter/material.dart';
import '../constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onTap,
    required this.checked,
  });

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
        padding: const EdgeInsets.symmetric(vertical: 4),
        margin: const EdgeInsets.fromLTRB(0, 18, 18, 0),
        decoration: BoxDecoration(
          border: Border.all(color: kBlue.withOpacity(0.7), width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          boxShadow: [
            BoxShadow(
              color: kBlue.withOpacity(0.5),
            ),
            const BoxShadow(
              color: kGrey,
              spreadRadius: -4.0,
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Positioned(
              top: 12,
                child: Text('23:00', style: TextStyle(color: kRed, fontWeight: FontWeight.bold),)),
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: checked ? Alignment.topCenter : Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: size.height * 0.06,
                height: size.height * 0.08,
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
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(14))
                ),
                child: Center(
                  child: AnimatedCrossFade(
                    firstChild: const Icon(Icons.check_circle, color: kRed, size: 32,),
                    secondChild: const Icon(Icons.cancel, color: kBlue, size: 32,),
                    crossFadeState: checked ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 100),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
