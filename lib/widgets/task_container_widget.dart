import 'package:flutter/material.dart';
import '../constants.dart';

class TaskContainerWidget extends StatelessWidget {
  const TaskContainerWidget({
    super.key,
    required this.position,
  });

  final double position;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Positioned(
      top: position,
      child: Container(
        height: size.height * 0.2,
        width: size.width,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [
                  kGrey,
                  kBlue,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
            ),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
            boxShadow: [
              BoxShadow(
                  color: kRed.withOpacity(0.6),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 1)
              )
            ]
        ),
      ),
    );
  }
}