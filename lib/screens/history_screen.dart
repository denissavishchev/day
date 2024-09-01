import 'package:day/constants.dart';
import 'package:day/models/history_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import '../models/boxes.dart';
import '../widgets/button_widget.dart';
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
                      final history = box.values.toList().cast<HistoryModel>();
                      return ListView.builder(
                        itemCount: history.length,
                          itemBuilder: (context, index){
                          return Container(
                            width: size.width,
                            height: 104,
                            margin: const EdgeInsets.all(12),
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: kGrey,
                              borderRadius: BorderRadius.all(Radius.circular(4))
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Date ${DateFormat('dd.MM.yyyy').format(DateTime.parse(history[index].time))}'),
                                    const SizedBox(width: 8,),
                                    Text('Duration ${history[index].duration}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(history[index].name1),
                                    const SizedBox(width: 4,),
                                    Text(history[index].description1),
                                    const SizedBox(width: 4,),
                                    Text(history[index].status1),
                                    const SizedBox(width: 4,),
                                    Container(
                                      width: 5,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: history[index].status1 == 'true' ? Colors.green : kRed,
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(history[index].name2),
                                    const SizedBox(width: 4,),
                                    Text(history[index].description2),
                                    const SizedBox(width: 4,),
                                    Container(
                                      width: 5,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: history[index].status2 == 'true' ? Colors.green : kRed,
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(history[index].name3),
                                    const SizedBox(width: 4,),
                                    Text(history[index].description3),
                                    const SizedBox(width: 4,),
                                    Container(
                                      width: 5,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: history[index].status3 == 'true' ? Colors.green : kRed,
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
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
