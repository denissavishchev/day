import 'dart:async';
import 'package:day/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class DaySwitchWidget extends StatefulWidget {
  const DaySwitchWidget({
    super.key,
  });

  @override
  State<DaySwitchWidget> createState() => _DaySwitchWidgetState();
}

class _DaySwitchWidgetState extends State<DaySwitchWidget> {

  Timer? timer;

  @override
  void initState() {
    final data = Provider.of<MainProvider>(context, listen: false);
    data.initDay();
    data.updateTimer();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        data.updateTimer();
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            padding: const EdgeInsets.all(1),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.grey.withOpacity(0.9),
                    const Color(0xffdcdcdc).withOpacity(0.7)
                  ],
                  begin: data.day ? Alignment.centerRight : Alignment.centerLeft,
                  end: data.day ? Alignment.centerLeft : Alignment.centerRight
              ),
              borderRadius: const BorderRadius.all(Radius.circular(60)),
            ),
            child: AnimatedContainer(
              width: size.width * 0.9,
              height: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(60)),
                image: DecorationImage(
                    image: AssetImage('assets/images/${data.day ? 'day' : 'night'}.png'),
                    fit: BoxFit.fill
                ),
              ),
              duration: const Duration(milliseconds: 500),
              child: Stack(
                children: [
                  Positioned(
                    top: 14,
                      left: size.width * 0.1,
                      child: AnimatedOpacity(
                        opacity: data.day ? 0 : 1,
                        duration: Duration(milliseconds: data.day ? 200 : 500),
                        curve: Curves.easeInCubic,
                        child: Text(data.endTime == ''
                            ? ''
                            : 'The previous day lasted ${data.previousDayDuration}\nand ended at ${data.endTime}',
                          style: const TextStyle(color: kRed, fontWeight: FontWeight.bold),))),
                  Positioned(
                    bottom: 14,
                    left: size.width * 0.1,
                    child:
                    AnimatedOpacity(
                      opacity: data.day ? 0 : 1,
                      duration: Duration(milliseconds: data.day ? 200 : 500),
                        curve: Curves.easeInCubic,
                      child: const Text('Start your new day',
                        style: TextStyle(color: kRed, fontWeight: FontWeight.bold),))),
                  Positioned(
                      top: 14,
                      left: size.width * 0.3,
                      child: AnimatedOpacity(
                          opacity: data.day ? 1 : 0,
                          duration: Duration(milliseconds: data.day ? 600 : 200),
                          curve: Curves.easeInCubic,
                          child: Text('Your day started at ${data.startTime}',
                            style: const TextStyle(color: kBlue, fontWeight: FontWeight.bold),))),
                  Positioned(
                      bottom: 14,
                      left: size.width * 0.3,
                      child:
                      AnimatedOpacity(
                          opacity: data.day ? 1 : 0,
                          duration: Duration(milliseconds: data.day ? 600 : 200),
                          curve: Curves.easeInCubic,
                          child: Text('Day duration: ${data.dayDuration}',
                            style: const TextStyle(color: kBlack, fontWeight: FontWeight.bold),))),
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 500),
                    alignment: data.day ? Alignment.centerLeft : Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => data.switchDay(),
                      child: Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(60)),
                          boxShadow: [
                            BoxShadow(
                                color: kBlack.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 1
                            )
                          ],
                        ),
                        child: AnimatedCrossFade(
                          firstChild: Image.asset('assets/images/sun.png'),
                          secondChild: Image.asset('assets/images/moon.png'),
                          crossFadeState: data.day ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                          duration: const Duration(milliseconds: 500),
                        ),
                      ),
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
