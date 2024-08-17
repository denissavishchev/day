import 'package:day/main_provider.dart';
import 'package:day/widgets/day_switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey,
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
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 4,
                                  spreadRadius: 4,
                                  offset: Offset(0, -4)
                              )
                            ]
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.66 + 125 ,
                      child: Container(
                        height: size.height * 0.06,
                        width: size.width * 0.8,
                        decoration: const BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 4,
                                  spreadRadius: 4,

                              )
                            ]
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.4 + 120,
                      child: Container(
                        height: size.height * 0.2,
                        width: size.width,
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 4,
                                  spreadRadius: 4,
                                  offset: Offset(0, 4)
                              )
                            ]
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.2 + 130,
                      child: Container(
                        height: size.height * 0.2,
                        width: size.width,
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 4,
                                  spreadRadius: 4,
                                  offset: Offset(0, 4)
                              )
                            ]
                        ),
                      ),
                    ),
                    Positioned(
                      top: 130,
                      child: Container(
                        height: size.height * 0.2,
                        width: size.width,
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 4,
                                  spreadRadius: 4,
                                  offset: Offset(0, 4)
                              )
                            ]
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        width: size.width,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                  spreadRadius: 4,
                                  offset: Offset(0, 4)
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


