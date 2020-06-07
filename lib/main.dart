import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahta2/logic/habit/db.dart';
import 'package:yahta2/ui/pages/list.dart';

void main() {
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
        ],
        child: MaterialApp(
          home: HabitListPage(),
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              border: InputBorder.none,
            ),
          ),
        ),
      );
}
