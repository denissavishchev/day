import 'package:day/main_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class PlanContainerWidget extends StatelessWidget {
  const PlanContainerWidget({
    super.key,
    required this.position,
    required this.index,
    required this.text,
    required this.description,
    required this.icon,
  });

  final double position;
  final int index;
  final String text;
  final String description;
  final String icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Positioned(
            top: position,
            child: GestureDetector(
              onDoubleTap: () => data.deleteTaskFromPlan(index),
              child: Container(
                height: size.height * 0.2,
                width: size.width * 0.95,
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
                          color: kBlack.withOpacity(0.6),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: const Offset(0, 1)
                      )
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.25,
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
                          boxShadow: [
                            BoxShadow(
                              color: kBlue,
                              spreadRadius: 1,
                            )
                          ]
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 28, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(text,
                              style: const TextStyle(color: kWhite, fontSize: 18, fontWeight: FontWeight.bold),),
                            Text(icon,
                              style: const TextStyle(color: kWhite, fontSize: 18, fontWeight: FontWeight.bold),),
                            const SizedBox(height: 4,),
                            Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: size.width * 0.4,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.elliptical(150, 10)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: kBlack.withOpacity(0.5),
                                              blurRadius: 20,
                                              spreadRadius: 1.5,
                                              offset: const Offset(0, 10)
                                          )
                                        ]
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.45,
                                    height: 1,
                                    decoration: const BoxDecoration(
                                      color: kGrey,
                                      borderRadius: BorderRadius.all(Radius.elliptical(150, 10)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Text(description,
                                  style: TextStyle(color: kWhite.withOpacity(0.8), fontSize: 16, fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.25,
                      margin: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: kBlue,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(18))
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}