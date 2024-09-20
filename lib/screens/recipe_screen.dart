import 'package:day/main_provider.dart';
import 'package:day/screens/main_screen.dart';
import 'package:day/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/boxes.dart';
import '../models/recipe_model.dart';
import 'create_recipe_screen.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

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
                  const SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonWidget(
                          onTap: () => Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) =>
                              const MainScreen())),
                          icon: Icons.arrow_back_ios_new),
                      ButtonWidget(
                          onTap: () => Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) =>
                              const CreateRecipeScreen())),
                          icon: Icons.add),
                    ],
                  ),
                  Expanded(
                    child: ValueListenableBuilder<Box<RecipeModel>>(
                        valueListenable: Boxes.addRecipeToBase().listenable(),
                        builder: (context, box, _){
                          final recipes = box.values.toList().cast<RecipeModel>();
                          return ListView.builder(
                            padding: const EdgeInsets.fromLTRB(12, 18, 12, 0),
                            itemCount: recipes.length,
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
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: size.width * 0.22,
                                        height: size.width * 0.22,
                                        clipBehavior: Clip.hardEdge,
                                        margin: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          // image: DecorationImage(
                                          //     image: AssetImage('assets/images/${tasks[index].icon}.png')),
                                          borderRadius: BorderRadius.all(Radius.circular(4)),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(recipes[index].name,
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
                                              child: Text(recipes[index].description,
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
                        }),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
