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
                    Row(
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
                                onTap: () => Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) =>
                                    const MainScreen())),
                                icon: Icons.home,
                              ),
                              ButtonWidget(
                                onTap: () {},
                                icon: Icons.add,
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: size.height * 0.06 + 36,
                            width: size.width * 0.6,
                            color: kBlack)
                      ],
                    ),
                    Expanded(
                      child: SizedBox(
                        width: size.width,
                        child: PageView.builder(
                            controller: data.futurePageController,
                            itemCount: 3,
                            onPageChanged: (index) => data.changeColor(index),
                            itemBuilder: (context, index){
                              return Row(
                                children: [
                                  Container(
                                    width: size.width * 0.4,
                                    color: data.futureColors[index],
                                  ),
                                  Container(
                                    width: size.width * 0.6,
                                    color: kBlack)
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