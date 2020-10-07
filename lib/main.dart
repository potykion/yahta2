import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
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
  Widget build(context) => MultiProvider(
        providers: [
          Provider<MyDatabase>(create: (_) => MyDatabase()),
          Provider<HabitRepository>(
            create: (context) => HabitRepository(context.read<MyDatabase>()),
          ),
          Provider<SettingsRepository>(create: (_) => SettingsRepository()),
          BlocProvider<HabitBloc>(
            create: (context) => HabitBloc(
              habitRepo: context.read<HabitRepository>(),
              settingsRepository: context.read<SettingsRepository>(),
            ),
          )
        ],
        child: MaterialApp(
          home: HabitListPage(),
          theme: ThemeData(
            // Цвет апп-бара
            primaryColor: Color(0xFF191923),
            inputDecorationTheme: InputDecorationTheme(
              // Удаление обводки у инпутов
              border: InputBorder.none,
            ),
            // Незаполненная часть прогресс-индикатора
            backgroundColor: Colors.white,
            // Заполненная часть прогресс-индикатора
            accentColor: Colors.yellow[100],
            // Курсор без стрелочки
            cursorColor: Color(0xFF191923),
            // Стрелочка-курсор
            textSelectionHandleColor: Color(0xFF191923),
            // Цвет выделения текста
            textSelectionColor: Colors.yellow[100],
            timePickerTheme: TimePickerThemeData(
              // Цвет текста в таймпикере
              hourMinuteTextColor: Color(0xFF191923),
              // Цвет стрелок в таймпикере
              dialHandColor: Color(0xFF191923),
            ),
            // Хайлайт выбора часа/минут в таймпикере
            colorScheme:
                Theme.of(context).colorScheme.copyWith(primary: Colors.yellow),
            // Цвет кнопок в таймпикере
            buttonTheme: ButtonThemeData(
              colorScheme: Theme.of(context)
                  .colorScheme
                  .copyWith(primary: Color(0xFF191923)),
            ),
            // Бекграунд циркл-аватара
            primaryColorLight: Colors.yellow[100],
            primaryTextTheme: TextTheme(
              subtitle1: TextStyle(
                // Цвет текста (форграунд) циркл-аватара
                color: Color(0xFF191923),
                // Размер текста в циркл-аватаре
                fontSize: 10,
              ),
            ),
          ),
          routes: {
            HabitListPage.routeName: (_) => HabitListPage(),
            HabitFormPage.routeName: (_) => HabitFormPage(),
          },
        ),
      );
}
