import 'package:day/widgets/plan_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../main_provider.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: kBlack,
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.6 + 40,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PlanContainerWidget(
                          position: size.height * 0.4 + 40,
                          checked: true,
                          index: 1,
                          text: 'Play guitar',
                          description: 'It\'s like learning sign language, then singing with my fingers.',
                          image: '1',
                        ),
                        PlanContainerWidget(
                          position: size.height * 0.2 + 60,
                          checked: true,
                          index: 1,
                          text: 'Play guitar',
                          description: 'It\'s like learning sign language, then singing with my fingers.',
                          image: '1',
                        ),
                        const PlanContainerWidget(
                          position: 80,
                          checked: true,
                          index: 1,
                          text: 'Play guitar',
                          description: 'It\'s like learning sign language, then singing with my fingers.',
                          image: '1',
                        ),
                        Positioned(
                          top: 0,
                          child: Container(
                            height: 100,
                            width: size.width * 0.95,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: kRed,
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.3,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(right: 12),
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                        itemBuilder: (context, index){
                          return Container(
                            width: 120,
                            height: size.height * 0.3,
                            margin: const EdgeInsets.fromLTRB(12, 12, 0, 12),
                            decoration: const BoxDecoration(
                              color: kBlue,
                              borderRadius: BorderRadius.all(Radius.circular(12))
                            ),
                          );
                        }
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
