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
                    Stack(
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
                            height: size.height * 0.8,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 24, right: 12),
                              child: TextField(
                                controller: data.notesTextController,
                                cursorColor: kRed,
                                keyboardType: TextInputType.multiline,
                                maxLines: MediaQuery.viewInsetsOf(context).bottom != 0 ? 12 : 24,
                                style: const TextStyle(color: kRed, fontWeight: FontWeight.w500),
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent)
                                  ),
                                ),
                                onChanged: (value) => data.saveNote(value),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
      )
    );
  }
}
