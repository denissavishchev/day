import 'package:day/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class HorizontalSwitchButtonWidget extends StatelessWidget {
  const HorizontalSwitchButtonWidget({
    super.key,
    required this.onTap,
    required this.checked,
    required this.index,
  });

  final VoidCallback onTap;
  final bool checked;
  final int index;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return GestureDetector(
            onTap: onTap,
            child: Container(
              width: 80,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: kBlue.withOpacity(0.7), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(14)),
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
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: checked ? Alignment.topRight : Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
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
                      borderRadius: const BorderRadius.all(Radius.circular(12))
                  ),
                  child: Center(
                    child: AnimatedCrossFade(
                      firstChild: const Icon(Icons.circle, color: kRed, size: 18,),
                      secondChild: const Icon(Icons.circle, color: kBlue, size: 18,),
                      crossFadeState: checked ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 100),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
