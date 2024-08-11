import 'package:day/main_provider.dart';
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
            return Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                padding: const EdgeInsets.all(1),
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
                  child: AnimatedAlign(
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
                              color: Colors.black.withOpacity(0.1),
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
                ),
              ),
            );
          },
        )
    );
  }
}
