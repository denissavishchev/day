import 'package:day/main_provider.dart';
import 'package:day/screens/recipe_screen.dart';
import 'package:day/screens/tasks_screen.dart';
import 'package:day/widgets/button_widget.dart';
import 'package:day/widgets/day_switch_widget.dart';
import 'package:day/widgets/task_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'history_screen.dart';
import 'notes_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: kBlack,
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
                        width: size.width * 0.95,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [
                                  kBlue,
                                  kGrey
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight
                            ),
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(4)),
                            boxShadow: [
                              BoxShadow(
                                  color: kRed.withOpacity(0.4),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                  offset: const Offset(0, -1)
                              )
                            ]
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.66 + 90 ,
                      child: Stack(
                        children: [
                          Container(
                              height: size.height * 0.1,
                              width: size.width * 0.8,
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(4)),
                              ),
                              child: Image.asset('assets/images/cityBg.png', fit: BoxFit.cover,)),
                          Container(
                            height: size.height * 0.1,
                            width: size.width * 0.8,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: kRed.withOpacity(0.5),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4)),
                                boxShadow: [
                                  BoxShadow(
                                      color: kRed.withOpacity(0.8),
                                      blurRadius: 8,
                                      spreadRadius: 4,
                                  )
                                ]
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ButtonWidget(
                                  onTap: () => Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) =>
                                      const RecipeScreen())),
                                  icon: Icons.set_meal_outlined,
                                ),
                                const SizedBox(width: 32,),
                                ButtonWidget(
                                  onTap: () => Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) =>
                                      const TasksScreen())),
                                  icon: Icons.playlist_add_check_outlined,
                                ),
                                const SizedBox(width: 32,),
                                ButtonWidget(
                                  onTap: () => Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) =>
                                      const HistoryScreen())),
                                  icon: Icons.history,),
                                const SizedBox(width: 32,),
                                ButtonWidget(
                                  onTap: () {
                                    data.readNote();
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) =>
                                        const NotesScreen()));
                                  },
                                  icon: Icons.note_add,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    TaskContainerWidget(
                      position: size.height * 0.4 + 80,
                      checked: data.checkedOne,
                      index: 1,
                      text: data.box.get('name3') ?? '',
                      description: data.box.get('description3') ?? '',
                      icon: data.box.get('icon3') ?? 'placeholder',
                    ),
                    TaskContainerWidget(
                      position: size.height * 0.2 + 100,
                      checked: data.checkedTwo,
                      index: 2,
                      text: data.box.get('name2') ?? '',
                      description: data.box.get('description2') ?? '',
                      icon: data.box.get('icon2') ?? 'placeholder',
                    ),
                    TaskContainerWidget(
                      position: 120,
                      checked: data.checkedThree,
                      index: 3,
                      text: data.box.get('name1') ?? '',
                      description: data.box.get('description1') ?? '',
                      icon: data.box.get('icon1') ?? 'placeholder',
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        width: size.width * 0.95,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: kBlack,
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






