import 'package:day/models/tasks_model.dart';
import 'package:day/screens/main_screen.dart';
import 'package:day/widgets/button_widget.dart';
import 'package:day/widgets/plan_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../main_provider.dart';
import '../models/boxes.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: kBlack,
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.6 + 40,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PlanContainerWidget(
                          position: size.height * 0.4 + 40,
                          index: 3,
                          text: data.box.get('name3') ?? '',
                          description: data.box.get('description3') ?? '',
                          icon: data.box.get('icon3') ?? 'placeholder',
                        ),
                        PlanContainerWidget(
                          position: size.height * 0.2 + 60,
                          index: 2,
                          text: data.box.get('name2') ?? '',
                          description: data.box.get('description2') ?? '',
                          icon: data.box.get('icon2') ?? 'placeholder',
                        ),
                        PlanContainerWidget(
                          position: 80,
                          index: 1,
                          text: data.box.get('name1') ?? '',
                          description: data.box.get('description1') ?? '',
                          icon: data.box.get('icon1') ?? 'placeholder',
                        ),
                        Positioned(
                          top: 0,
                          child: Container(
                            height: 100,
                            width: size.width * 0.95,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: kRed,
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
                            child: Center(
                              child: ButtonWidget(
                                onTap: () => Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) =>
                                    const MainScreen())),
                                icon: Icons.home,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.3,
                    child: ValueListenableBuilder<Box<TasksModel>>(
                        valueListenable: Boxes.addTaskToBase().listenable(),
                        builder: (context, box, _){
                          final tasks = box.values.toList().cast<TasksModel>();
                          return ListView.builder(
                              padding: const EdgeInsets.only(right: 12),
                              scrollDirection: Axis.horizontal,
                              itemCount: tasks.length,
                              itemBuilder: (context, index){
                                return GestureDetector(
                                  onDoubleTap: () => data.addTaskToPlan(
                                      tasks[index].name,
                                      tasks[index].description,
                                      tasks[index].icon,
                                  ),
                                  child: Container(
                                    width: 120,
                                    height: size.height * 0.3,
                                    margin: const EdgeInsets.fromLTRB(12, 12, 0, 12),
                                    decoration: const BoxDecoration(
                                        color: kBlue,
                                        borderRadius: BorderRadius.all(Radius.circular(12))
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(tasks[index].name,
                                          style: const TextStyle(color: kWhite, fontSize: 18, fontWeight: FontWeight.bold),),
                                        const SizedBox(height: 4,),
                                        Container(
                                          width: size.width * 0.27,
                                          height: 1,
                                          decoration: const BoxDecoration(
                                            color: kGrey,
                                            borderRadius: BorderRadius.all(Radius.elliptical(150, 10)),
                                          ),
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Text(tasks[index].description,
                                              style: TextStyle(color: kWhite.withOpacity(0.8), fontSize: 16, fontWeight: FontWeight.bold),),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                          );
                        }
                    )
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
