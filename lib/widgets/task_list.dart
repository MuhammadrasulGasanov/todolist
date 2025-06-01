import 'package:flutter/material.dart';
import 'package:todolist/data/models/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.tasks,
    required this.onPressed,
    required this.onDismissed,
    required this.onChecked,
  });

  final List<Task> tasks;
  final void Function(String? id) onDismissed;
  final void Function(String? id, bool value) onChecked;
  final void Function(Task? task) onPressed;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:
          tasks
              .map(
                (task) => Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    onDismissed(task.id);
                  },
                  child: ListTile(
                    leading: Checkbox(
                      value: task.completed,
                      onChanged: (value) {
                        if (value == null) return;
                        onChecked(task.id, value);
                      },
                    ),
                    onTap: () => onPressed(task),
                    title: Text(task.title),
                    subtitle:
                        task.description != null
                            ? Text(task.description ?? '')
                            : null,
                  ),
                ),
              )
              .toList(),
    );
  }
}
