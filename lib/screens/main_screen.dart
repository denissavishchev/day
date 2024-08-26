import 'package:day/main_provider.dart';
import 'package:day/screens/tasks_screen.dart';
import 'package:day/widgets/button_widget.dart';
import 'package:day/widgets/day_switch_widget.dart';
import 'package:day/widgets/task_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

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
                        width: size.width * 0.95,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [
                                  kBlue,
                                  kGrey
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight
                            ),
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(18)),
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
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: kRed,
                            borderRadius: const BorderRadius.all(
                                Radius.circular(18)),
                            boxShadow: [
                              BoxShadow(
                                  color: kRed.withOpacity(0.6),
                                  blurRadius: 8,
                                  spreadRadius: 4,
                              )
                            ]
                        ),
                        child: ButtonWidget(
                          onTap: () => Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) =>
                              const TasksScreens())),
                          icon: Icons.playlist_add_check_outlined,
                        ),
                      ),
                    ),
                    TaskContainerWidget(
                      position: size.height * 0.4 + 80,
                      checked: data.checkedOne,
                      index: 1,
                      text: 'Play guitar',
                      description: 'It\'s like learning sign language, then singing with my fingers.',
                      image: '1',
                    ),
                    TaskContainerWidget(
                      position: size.height * 0.2 + 100,
                      checked: data.checkedTwo,
                      index: 2,
                      text: 'Biking around the city',
                      description: 'Every city is different, but each has its own beauty, and when you’re on your bike you’ll reconnect with that beauty and remember just why it is you live there.',
                      image: '2',
                    ),
                    TaskContainerWidget(
                      position: 120,
                      checked: data.checkedThree,
                      index: 3,
                      text: 'Programming',
                      description: 'Computer programming or coding is the composition of sequences of instructions, called programs, that computers can follow to perform tasks. It involves designing and implementing algorithms, step-by-step specifications of procedures, by writing code in one or more programming languages.',
                      image: '3',
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        width: size.width * 0.95,
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






