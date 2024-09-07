import 'package:day/constants.dart';
import 'package:day/models/history_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../models/boxes.dart';
import '../widgets/button_widget.dart';
import '../widgets/history_container_widget.dart';
import 'main_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: kBlue,
      body: SafeArea(
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
                child: ValueListenableBuilder<Box<HistoryModel>>(
                    valueListenable: Boxes.addHistoryToBase().listenable(),
                    builder: (context, box, _){
                      final history = box.values.toList().cast<HistoryModel>().reversed.toList();
                      return ListView.builder(
                        itemCount: history.length,
                          itemBuilder: (context, index){
                          return HistoryContainerWidget(
                            history: history,
                            index: index,
                          );
                          }
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


