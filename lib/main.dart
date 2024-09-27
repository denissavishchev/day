import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'main_provider.dart';
import 'models/habits_model.dart';
import 'models/history_model.dart';
import 'models/tasks_model.dart';
import 'screens/main_screen.dart';
import 'package:permission_handler/permission_handler.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TasksModelAdapter());
  Hive.registerAdapter(HistoryModelAdapter());
  Hive.registerAdapter(HabitsModelAdapter());
  await Hive.openBox<TasksModel>('tasks');
  await Hive.openBox<HistoryModel>('stories');
  await Hive.openBox<HabitsModel>('habits');
  await Hive.openBox('plans');
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'scheduled',
            channelGroupKey: 'basic_channel_group',
            channelName: 'Scheduled Notifications',
            importance: NotificationImportance.High,
            channelShowBadge: true,
            channelDescription: 'Notification channel for basic tests')
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: false
  );
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

