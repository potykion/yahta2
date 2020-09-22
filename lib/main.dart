import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yahta2/logic/habit/blocs.dart';
import 'package:yahta2/logic/habit/db.dart';
import 'package:yahta2/ui/pages/form.dart';
import 'package:yahta2/ui/pages/list.dart';

var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(
      AndroidInitializationSettings('app_icon'),
      IOSInitializationSettings(),
    ),
  );

  await flutterLocalNotificationsPlugin.showDailyAtTime(
    0,
    'Все сделал?',
    'Проверь, все ли привычки отмечены',
    Time(12, 0, 0),
    NotificationDetails(
      AndroidNotificationDetails(
        'all-checked',
        'Все сделал?',
        'Кидается в ~12 по мск, спрашивает, все ли привычки отмечены',
      ),
      IOSNotificationDetails(),
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(context) =>
      MultiProvider(
        providers: [
          Provider<MyDatabase>(create: (_) => MyDatabase()),
          Provider<HabitRepository>(
            create: (context) => HabitRepository(context.read<MyDatabase>()),
          ),
          Provider<SettingsRepository>(create: (_) => SettingsRepository()),
          BlocProvider<HabitBloc>(
            create: (context) =>
                HabitBloc(
                  habitRepo: context.read<HabitRepository>(),
                  settingsRepository: context.read<SettingsRepository>(),
                ),
          )
        ],
        child: MaterialApp(
          home: HabitListPage(),
          theme: ThemeData(
              primarySwatch: Colors.yellow,
              inputDecorationTheme: InputDecorationTheme(
                border: InputBorder.none,
              ),
              chipTheme: Theme
                  .of(context)
                  .chipTheme
                  .copyWith(
                secondaryLabelStyle: TextStyle(color: Colors.black),
                secondarySelectedColor: Colors.yellow,
              ),
              backgroundColor: Colors.yellow[100]),
          routes: {
            HabitListPage.routeName: (_) => HabitListPage(),
            HabitFormPage.routeName: (_) => HabitFormPage(),
          },
        ),
      );
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('DraggableScrollableSheet'),
//       ),
//       body: SizedBox.expand(
//         child:,
//       ),
//     );
//   }
// }
