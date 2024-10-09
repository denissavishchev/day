import 'package:day/main_provider.dart';
import 'package:day/screens/create_future_screen.dart';
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
                return Stack(
                  children: [
                    SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Row(
                        children: [
                          Container(
                            width: size.width * 0.4,
                            color: kTangerine,
                          ),
                          Container(
                            width: size.width * 0.6,
                            color: kBlack,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: SizedBox(
                              width: size.width * 0.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ButtonWidget(
                                    colorOne: kBlue,
                                    colorTwo: kBlack,
                                    iconColor: kTangerine,
                                    icon: Icons.home,
                                    onTap: () => Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) =>
                                        const MainScreen())),
                                  ),
                                  ButtonWidget(
                                    colorOne: kBlue,
                                    colorTwo: kBlack,
                                    iconColor: kTangerine,
                                    icon: Icons.add,
                                    onTap: () => Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) =>
                                        const CreateFutureScreen())),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
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
                                        Container(
                                          height: double.maxFinite,
                                          width: size.width * 0.34,
                                          margin: const EdgeInsets.all(4),
                                          alignment: data.fu[index] == 0
                                              ? Alignment.centerLeft
                                              : data.fu[index] == 1
                                              ? Alignment.center
                                              : Alignment.centerRight,
                                          decoration: const BoxDecoration(
                                              color: kTangerine,
                                              borderRadius: BorderRadius.all(Radius.circular(4))
                                          ),
                                          child: GestureDetector(
                                            onTap: () => data.switchFutureButton(index),
                                            child: Container(
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
                                                        : kTangerine,),
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
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
          )
      ),
    );
  }
}