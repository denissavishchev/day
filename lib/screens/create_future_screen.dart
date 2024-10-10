import 'package:day/main_provider.dart';
import 'package:day/screens/future_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../widgets/button_widget.dart';
import '../widgets/kids_button_widget.dart';

class CreateFutureScreen extends StatelessWidget {
  const CreateFutureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Consumer<MainProvider>(
              builder: (context, data, _){
                return Stack(
                  children: [
                    SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Row(
                        children: [
                          Container(
                            width: size.width * 0.4,
                            color: kTangerine,
                          ),
                          Container(
                            width: size.width * 0.6,
                            color: kBlack,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: SizedBox(
                                  width: size.width * 0.4,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ButtonWidget(
                                        colorOne: kBlue,
                                        colorTwo: kBlack,
                                        iconColor: kTangerine,
                                        icon: Icons.home,
                                        onTap: () => Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (context) =>
                                            const FutureScreen())),
                                      ),
                                      ButtonWidget(
                                        colorOne: kBlue,
                                        colorTwo: kBlack,
                                        iconColor: kTangerine,
                                        icon: Icons.add,
                                        onTap: () => data.addFutureBase(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: SizedBox(
                                  width: size.width * 0.6,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      KidsButtonWidget(
                                        text: 'D',
                                        isOn: data.daniel,
                                        onTap: () => data.switchName('daniel'),
                                      ),
                                      KidsButtonWidget(
                                        text: 'L',
                                        isOn: data.leonard,
                                        onTap: () => data.switchName('leonard'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                children: [
                                  TextField(
                                    controller: data.futureNameTextController,
                                    decoration: orangeTextFieldDecoration,
                                    style: const TextStyle(color: kWhite),
                                  ),
                                  const SizedBox(height: 12,),
                                  TextField(
                                    controller: data.futureDescriptionTextController,
                                    maxLines: 10,
                                    decoration: orangeTextFieldDecoration,
                                    style: const TextStyle(color: kWhite),
                                  ),
                                  const SizedBox(height: 12,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(data.selectedDate != ''
                                        ? DateFormat('dd-MM-yyyy').format(DateTime.parse(data.selectedDate))
                                        : '',
                                        style: const TextStyle(color: kWhite, fontSize: 18, fontWeight: FontWeight.bold),),
                                      Visibility(
                                        visible: data.selectedDate != '',
                                        child: IconButton(
                                            onPressed: () => data.cleanDate(),
                                            icon: const Icon(Icons.close,color: kWhite,)
                                        ),
                                      ),
                                      const SizedBox(width: 20,),
                                      ButtonWidget(
                                        colorOne: kBlue,
                                        colorTwo: kBlack,
                                        iconColor: kTangerine,
                                        icon: Icons.calendar_month,
                                        onTap: () => data.showCalendar(context),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
          )
      ),
    );
  }
}

