import 'package:day/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/boxes.dart';
import '../models/habits_model.dart';
import '../widgets/button_widget.dart';
import '../widgets/horizontal_switch_button_widget.dart';
import 'main_screen.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: kIndigo,
      body: SafeArea(
        child: Consumer<MainProvider>(
            builder: (context, data, _){
              return Center(
                child: Column(
                  children: [
                    const SizedBox(height: 18,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonWidget(
                          colorOne: kIndigo,
                          colorTwo: kNavy,
                          iconColor: kGreen,
                          onTap: () => Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) =>
                              const MainScreen())),
                          icon: Icons.home,
                        ),
                        ButtonWidget(
                          colorOne: kIndigo,
                          colorTwo: kNavy,
                          iconColor: kGreen,
                          onTap: () => data.showToAddHabit(context),
                          icon: Icons.add,
                        ),
                      ],
                    ),
                    const SizedBox(height: 18,),
                    Expanded(
                      child: SizedBox(
                        width: size.width,
                        child: ValueListenableBuilder<Box<HabitsModel>>(
                            valueListenable: Boxes.addHabitToBase().listenable(),
                            builder: (context, box, _){
                              final habits = box.values.toList().cast<HabitsModel>();
                              return ListView.builder(
                                  itemCount: habits.length,
                                  itemBuilder: (context, index){
                                    return GestureDetector(
                                      onLongPress: () => data.deleteHabit(box, index),
                                      child: Container(
                                        width: size.width,
                                        margin: const EdgeInsets.only(bottom: 4),
                                        padding: const EdgeInsets.fromLTRB(18, 6, 18, 12),
                                        decoration: BoxDecoration(
                                          color: kNavy.withOpacity(0.3),
                                          borderRadius: const BorderRadius.all(Radius.circular(4))
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(habits[index].name,
                                                  style: const TextStyle(
                                                      color: kWhite,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18
                                                  ),),
                                                const SizedBox(height: 8,),
                                                SizedBox(
                                                  width: 240,
                                                  child: Wrap(
                                                    runAlignment: WrapAlignment.center,
                                                    runSpacing: 4,
                                                    children: List.generate(habits[index].days, (i){
                                                      List<int> converted = habits[index].progress.split('')
                                                      .map((v) => int.parse(v)).toList();
                                                      converted.addAll(List.filled(habits[index].days - converted.length, 3));
                                                      return Container(
                                                        margin: const EdgeInsets.only(right: 4),
                                                        width: 12,
                                                        height: 12,
                                                        decoration: BoxDecoration(
                                                          color: converted[i] == 1
                                                              ? kGreen
                                                              : converted[i] == 0
                                                              ? kNavy.withOpacity(0.2)
                                                              : kIndigo.withOpacity(0.2),
                                                            borderRadius: const BorderRadius.all(Radius.circular(3)),
                                                            border: Border.all(width: 1, color: kBlack)
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                habits[index].days == habits[index].progress.length
                                                    ? const Icon(Icons.history, color: kGreen, size: 32,)
                                                    : HorizontalSwitchButtonWidget(
                                                      onTap: () => data.switchHabit(box, index, habits),
                                                      checked: habits[index].status,
                                                      index: index,),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    Text(habits[index].days.toString(), style: kTextStyle,),
                                                    const Text(' days', style: kTextStyle,),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
        )
      ),
    );
  }
}