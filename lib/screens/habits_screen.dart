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
      backgroundColor: kBlue,
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
                          onTap: () => Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) =>
                              const MainScreen())),
                          icon: Icons.home,
                        ),
                        ButtonWidget(
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
                                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                                        color: kGrey.withOpacity(0.3),
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
                                                              ? kTangerine
                                                              : converted[i] == 0
                                                              ? kLime.withOpacity(0.4)
                                                              : kWhite.withOpacity(0.2),
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
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                HorizontalSwitchButtonWidget(
                                                  onTap: () => data.switchHabit(box, index, habits),
                                                  checked: habits[index].status,
                                                  index: index,),
                                                Text(habits[index].days.toString()),
                                                Text(habits[index].progress),
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