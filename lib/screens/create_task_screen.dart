import 'package:day/main_provider.dart';
import 'package:day/screens/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../widgets/button_widget.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlack,
      body: Consumer<MainProvider>(
          builder: (context, data, _){
            return Container(
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
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
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
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 20,),
                    ButtonWidget(
                        onTap: () => Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) =>
                            const TasksScreen())),
                        icon: Icons.arrow_back_ios_new),
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
                      maxLines: 3,
                      decoration: textFieldDecoration.copyWith(
                          label: const Text('Description',)),
                      maxLength: 64,
                    ),
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      children: List.generate(data.icons.length, ((i){
                        return GestureDetector(
                          onTap: () => data.updateIcon(data.icons[i]),
                          child: Container(
                            width: size.height * 0.07,
                            height: size.height * 0.07,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: data.icon == data.icons[i]
                                          ? kRed
                                          : kBlack.withOpacity(0),
                                      blurRadius: 2,
                                      spreadRadius: 2
                                  )
                                ],
                                gradient: const LinearGradient(
                                    colors: [
                                      kGrey,
                                      kWhite
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(4))
                            ),
                            child: Image.asset('assets/images/${data.icons[i]}.png'),
                          ),
                        );
                      })),
                    ),
                    ButtonWidget(
                        onTap: () {
                          data.addTaskBase();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) =>
                              const TasksScreen()));
                        },
                        icon: Icons.add
                    ),
                    const SizedBox(height: 8,),
                  ],
                ),
              ),
            );
          }
      )
    );
  }
}
