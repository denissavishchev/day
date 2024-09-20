import 'package:day/main_provider.dart';
import 'package:day/screens/recipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../widgets/button_widget.dart';

class CreateRecipeScreen extends StatelessWidget {
  const CreateRecipeScreen({super.key});

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
                              const RecipeScreen())),
                          icon: Icons.arrow_back_ios_new),
                      TextField(
                        controller: data.recipeNameTextController,
                        cursorColor: kRed,
                        decoration: textFieldDecoration.copyWith(
                            label: const Text('Name',)),
                        maxLength: 32,
                      ),
                      TextField(
                        controller: data.recipeDescriptionTextController,
                        cursorColor: kRed,
                        maxLines: 3,
                        decoration: textFieldDecoration.copyWith(
                            label: const Text('Description',)),
                        maxLength: 64,
                      ),
                      ButtonWidget(
                          onTap: () {
                            data.addRecipeBase();
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) =>
                                const RecipeScreen()));
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
