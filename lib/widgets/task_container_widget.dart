import 'package:day/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'button_widget.dart';

class TaskContainerWidget extends StatelessWidget {
  const TaskContainerWidget({
    super.key,
    required this.position,
    required this.checked,
    required this.index,
  });

  final double position;
  final bool checked;
  final int index;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.25,
                    clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/1.jpg'),fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
                        boxShadow: [
                          BoxShadow(
                              color: kBlue,
                              spreadRadius: 1,
                          )
                        ]
                    ),
                    child: Image.asset('assets/images/shadow.png', fit: BoxFit.fill,),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Play guitar'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: size.width * 0.2,
                    margin: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kBlue.withOpacity(0.7), width: 1),
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
                      boxShadow: [
                        BoxShadow(
                          color: kBlue.withOpacity(0.7),
                        ),
                        const BoxShadow(
                          color: kGrey,
                          spreadRadius: -4.0,
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: ButtonWidget(
                      icon: Icons.check_circle,
                      checked: checked,
                      onTap: () => data.switchChecked(index)
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}