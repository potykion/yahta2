import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahta2/logic/habit/blocs.dart';
import 'package:yahta2/logic/habit/view_models.dart';

class HabitListPage extends StatefulWidget {
  @override
  _HabitListPageState createState() => _HabitListPageState();
}

class _HabitListPageState extends State<HabitListPage> {
  @override
  void initState() {
    super.initState();
    context.bloc<HabitBloc>().add(HabitsLoadStarted());
  }

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
        body: BlocBuilder<HabitBloc, HabitState>(
          builder: (_, state) => ListView.builder(
            itemBuilder: (_, index) =>
                HabitListTile(habit: state.habitVMs[index]),
            itemCount: state.habitVMs.length,
          ),
        ),
      );
}

enum HabitAction { edit, delete }

class HabitListTile extends StatelessWidget {
  final HabitVM habit;

  const HabitListTile({Key key, this.habit}) : super(key: key);

  @override
  Widget build(context) => Dismissible(
        key: Key(habit.id.toString()),
        child: ListTile(
          title: Text(
            habit.title,
            style: TextStyle(
              decoration: habit.done ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: PopupMenuButton<HabitAction>(
            onSelected: (action) {
              if (action == HabitAction.delete) {
                context.bloc<HabitBloc>().add(HabitDeleted(habit.id));
              } else if (action == HabitAction.edit) {
//                todo
              }
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<HabitAction>>[
              const PopupMenuItem<HabitAction>(
                value: HabitAction.edit,
                child: Text('Изменить'),
              ),
              const PopupMenuItem<HabitAction>(
                value: HabitAction.delete,
                child: Text('Удалить'),
              ),
            ],
          ),
        ),
        direction: habit.done ? null : DismissDirection.endToStart,
        confirmDismiss: (_) async {
          context.bloc<HabitBloc>().add(HabitDone(habit.id));
          return false;
        },
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
  Widget build(context) => Card(
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
                        .bloc<HabitBloc>()
                        .add(HabitCreated(controller.text));
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      );
}
