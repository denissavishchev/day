import 'dart:convert';
import 'package:day/main_provider.dart';
import 'package:day/models/boxes.dart';
import 'package:day/models/tasks_model.dart';
import 'package:day/screens/main_screen.dart';
import 'package:day/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'dart:io';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: kBlack,
            body: SafeArea(
              child: Center(
                child: SizedBox(
                  width: size.width * 0.95,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.9,
                            width: size.width * 0.55,
                            clipBehavior: Clip.hardEdge,
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
                            child: ValueListenableBuilder<Box<TasksModel>>(
                                valueListenable: Boxes.addTaskToBase().listenable(),
                                builder: (context, box, _){
                                  final tasks = box.values.toList().cast<TasksModel>();
                                  return ListView.builder(
                                    padding: const EdgeInsets.only(top: 18),
                                    itemCount: tasks.length,
                                    itemBuilder: (context, index){
                                      return GestureDetector(
                                        onLongPress: () => box.deleteAt(index),
                                        child: Container(
                                          width: size.width * 0.5,
                                          height: size.height * 0.15,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.fromLTRB(4, 0, 4, 4),
                                          decoration: const BoxDecoration(
                                            color: kBlue,
                                            borderRadius: BorderRadius.all(Radius.circular(18)),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: size.width * 0.2,
                                                clipBehavior: Clip.hardEdge,
                                                margin: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: MemoryImage(base64Decode(tasks[index].photo)),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: kBlue,
                                                        spreadRadius: 1,
                                                      )
                                                    ]
                                                ),
                                                child: Image.asset('assets/images/shadow.png', fit: BoxFit.fill,),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                })
                          ),
                          SizedBox(
                            height: size.height * 0.8,
                            child: Column(
                              children: [
                                Container(
                                  height: size.height * 0.7,
                                  width: size.width * 0.38,
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
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 18, 8, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () => data.pickAnImage(),
                                          child: Container(
                                            height: size.height * 0.25,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: const BoxDecoration(
                                                color: kBlue,
                                                borderRadius: BorderRadius.all(Radius.circular(18))
                                            ),
                                            child: data.base64String == ''
                                                ? const Center(child: Icon(Icons.photo, color: kRed, size: 40,))
                                                : Image.file(File(data.file!.path), fit: BoxFit.fill,),
                                          ),
                                        ),
                                        TextField(
                                          controller: data.nameTextController,
                                          cursorColor: kRed,
                                          decoration: textFieldDecoration.copyWith(
                                              label: const Text('Task',)),
                                          maxLength: 32,
                                        ),
                                        TextField(
                                          controller: data.descriptionTextController,
                                          cursorColor: kRed,
                                          maxLines: 4,
                                          decoration: textFieldDecoration.copyWith(
                                              label: const Text('Description',)),
                                          maxLength: 64,
                                        ),
                                        ButtonWidget(
                                            onTap: () => data.addTaskBase(),
                                            icon: Icons.add
                                        ),
                                        const SizedBox(height: 8,),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                ButtonWidget(
                                    onTap: () => Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) =>
                                        const MainScreen())),
                                    icon: Icons.arrow_back_ios_new)
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
