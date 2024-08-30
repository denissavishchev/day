import 'package:day/main_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'switch_button_widget.dart';

class TaskContainerWidget extends StatelessWidget {
  const TaskContainerWidget({
    super.key,
    required this.position,
    required this.checked,
    required this.index,
    required this.text,
    required this.description,
    required this.icon,
  });

  final double position;
  final bool checked;
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
                    width: size.width * 0.3,
                    height: size.width * 0.3,
                    clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.fromLTRB(12, 18, 12, 0),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                      color: kBlue,
                      image: DecorationImage(
                          image: AssetImage('assets/images/pizza.png')
                      )
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
                  SwitchButtonWidget(
                    checked: checked,
                    onTap: () => data.switchChecked(index)
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}