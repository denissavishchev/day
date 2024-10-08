import 'package:day/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/boxes.dart';
import '../widgets/button_widget.dart';
import 'main_screen.dart';

class FutureScreen extends StatelessWidget {
  const FutureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: Consumer<MainProvider>(
              builder: (context, data, _){
                return Column(
                  children: [
                    SizedBox(
                       width: size.width,
                      height: size.height * 0.06 + 36,
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            width: size.width * 0.4,
                            color: data.futureColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ButtonWidget(
                                  colorOne: kBlue,
                                  colorTwo: kBlack,
                                  iconColor: data.futureColor,
                                  icon: Icons.home,
                                  onTap: () => Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) =>
                                      const MainScreen())),
                                ),
                                ButtonWidget(
                                  colorOne: kBlue,
                                  colorTwo: kBlack,
                                  iconColor: data.futureColor,
                                  icon: Icons.add,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                          Container(
                              width: size.width * 0.6,
                              color: kBlack)
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: size.width,
                        child: PageView.builder(
                            controller: data.futurePageController,
                            itemCount: 3,
                            onPageChanged: (index) => data.changeColor(index),
                            itemBuilder: (context, index){
                              return Stack(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: size.width * 0.4,
                                        color: data.futureColors[index],
                                      ),
                                      Container(
                                        width: size.width * 0.6,
                                        color: kBlack)
                                    ],
                                  ),
                                  ListView.builder(
                                    itemCount: 10,
                                      itemBuilder: (context, index){
                                      return Container(
                                        width: size.width,
                                        height: 50,
                                        margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                                          gradient: LinearGradient(
                                              colors: [
                                                kBlack,
                                                kBlack,
                                                kBlack,
                                                Colors.transparent.withOpacity(0.1),
                                                Colors.transparent.withOpacity(0),
                                                Colors.transparent.withOpacity(0),
                                              ],
                                            stops: const [0.1, 0.2, 0.4, 0.7, 0.9, 1]
                                          )
                                        ),
                                        child: Row(
                                          children: [
                                            AnimatedContainer(
                                              duration: const Duration(milliseconds: 300),
                                              height: double.maxFinite,
                                              width: size.width * 0.34,
                                              margin: const EdgeInsets.all(4),
                                              alignment: data.fu[index] == 0
                                                  ? Alignment.centerLeft
                                                  : data.fu[index] == 1
                                                  ? Alignment.center
                                                  : Alignment.centerRight,
                                              decoration: BoxDecoration(
                                                color: data.futureColor,
                                                borderRadius: const BorderRadius.all(Radius.circular(4))
                                              ),
                                              child: GestureDetector(
                                                onTap: () => data.switchFutureButton(index),
                                                child: AnimatedContainer(
                                                  duration: const Duration(milliseconds: 300),
                                                  height: double.maxFinite,
                                                  width: size.width * 0.13,
                                                  margin: const EdgeInsets.all(4),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: data.fu[index] == 0
                                                          ? kWhite.withOpacity(0.1)
                                                          : data.fu[index] == 1
                                                          ? kWhite
                                                          : kBlack,
                                                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: data.fu[index] == 1
                                                          ? kWhite.withOpacity(0.3)
                                                          : kBlue.withOpacity(0.5),
                                                        spreadRadius: 1,
                                                        blurRadius: 1,
                                                        offset: Offset(data.fu[index] == 0 ? -1 : 2, 2)
                                                      )
                                                    ]
                                                  ),
                                                  child: SizedBox.expand(
                                                    child: Container(
                                                      margin: const EdgeInsets.all(1),
                                                      decoration: const BoxDecoration(
                                                          gradient: LinearGradient(
                                                            colors: [
                                                              kBlack,
                                                              kBlue,
                                                            ],
                                                            begin: Alignment.topLeft,
                                                            end: Alignment.bottomRight,
                                                          ),
                                                          borderRadius: BorderRadius.all(Radius.circular(4))
                                                      ),
                                                      child: Icon(Icons.lightbulb,
                                                        color: data.fu[index] == 0
                                                            ? kBlack
                                                            : data.fu[index] == 1
                                                            ? kWhite
                                                            : data.futureColor,),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 4,),
                                            const Text('Do something...',
                                              style: TextStyle(
                                                  color: kWhite,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  )
                                ],
                              );
                            }
                        ),
                      ),
                    )
                  ],
                );
              }
          )
      ),
    );
  }
}