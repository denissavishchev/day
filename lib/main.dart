import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'main_provider.dart';
import 'models/history_model.dart';
import 'models/tasks_model.dart';
import 'screens/main_screen.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TasksModelAdapter());
  Hive.registerAdapter(HistoryModelAdapter());
  await Hive.openBox<TasksModel>('tasks');
  await Hive.openBox<HistoryModel>('history');
  await Hive.openBox('plans');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainProvider>(
      create: (_) => MainProvider(),
      builder: (context, _){
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainScreen(),
        );
      }
    );
  }
}

