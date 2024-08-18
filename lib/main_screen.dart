import 'package:day/main_provider.dart';
import 'package:day/widgets/day_switch_widget.dart';
import 'package:day/widgets/task_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: kBlack,
        body: Consumer<MainProvider>(
          builder: (context, data, _){
            return SafeArea(
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 20,
                        width: size.width,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [
                                  kBlue,
                                  kGrey
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight
                            ),
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                            boxShadow: [
                              BoxShadow(
                                  color: kRed.withOpacity(0.4),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                  offset: const Offset(0, -1)
                              )
                            ]
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.66 + 90 ,
                      child: Container(
                        height: size.height * 0.1,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                            color: kRed,
                            borderRadius: const BorderRadius.all(Radius.circular(18)),
                            boxShadow: [
                              BoxShadow(
                                  color: kRed.withOpacity(0.6),
                                  blurRadius: 8,
                                  spreadRadius: 4,

                              )
                            ]
                        ),
                      ),
                    ),
                    TaskContainerWidget(
                        position: size.height * 0.4 + 80
                    ),
                    TaskContainerWidget(
                        position: size.height * 0.2 + 100
                    ),
                    const TaskContainerWidget(
                      position: 120,
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        width: size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: kBlack,
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
                            boxShadow: [
                              BoxShadow(
                                  color: kBlack.withOpacity(0.6),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 1)
                              )
                            ]
                        ),
                        child: const DaySwitchWidget(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
    );
  }
}




