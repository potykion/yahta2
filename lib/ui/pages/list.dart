import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahta2/logic/habit/db.dart';
import 'package:yahta2/logic/habit/models.dart';

class HabitListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("План на сегодня"),
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) => IconButton(
                icon: Icon(Icons.add),
                onPressed: () => Scaffold.of(context)
                    .showBottomSheet((_) => AddNewHabitCard()),
              ),
            )
          ],
        ),
      );
}

class AddNewHabitCard extends StatefulWidget {
  const AddNewHabitCard({
    Key key,
  }) : super(key: key);

  @override
  _AddNewHabitCardState createState() => _AddNewHabitCardState();
}

class _AddNewHabitCardState extends State<AddNewHabitCard> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: SizedBox(
          height: 60,
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(hintText: "Чем займешься?"),
                  controller: controller,
                ),
              ),
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  context
                      .read<HabitRepository>()
                      .insertHabit(Habit(title: controller.text));
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}