import 'package:day/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../widgets/button_widget.dart';
import 'main_screen.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlack,
      body: Consumer<MainProvider>(
          builder: (context, data, _){
            return SafeArea(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 18,),
                    ButtonWidget(
                      onTap: () => Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) =>
                          const MainScreen())),
                      icon: Icons.home,
                    ),
                    const SizedBox(height: 18,),
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.8,
                      child: PageView.builder(
                        controller: data.pageController,
                        itemCount: 3,
                          itemBuilder: (context, index){
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: size.width,
                                height: size.height * 0.8,
                                child: Image.asset('assets/images/blank.png', fit: BoxFit.fill,),
                              ),
                              Positioned(
                                top: 40,
                                child: SizedBox(
                                  width: size.width,
                                  height: MediaQuery.viewInsetsOf(context).bottom == 0
                                      ? size.height * 0.68
                                      : size.height * 0.38,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 24, right: 12),
                                    child: TextField(
                                      controller: index == 0
                                          ? data.notesTextControllerOne
                                          : index == 1
                                          ? data.notesTextControllerTwo
                                          : data.notesTextControllerThree,
                                      cursorColor: kRed,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      style: const TextStyle(color: kRed, fontWeight: FontWeight.w500),
                                      decoration: const InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.transparent)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.transparent)
                                        ),
                                      ),
                                      onChanged: (value) => data.saveNote(value, index),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                          }
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      )
    );
  }
}
