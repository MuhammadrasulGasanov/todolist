import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/data/models/category.dart';
import 'package:todolist/data/models/task.dart';
import 'package:todolist/providers/providers.dart';
import 'package:todolist/router.gr.dart';
import 'package:todolist/widgets/drop_down_filters.dart';

@RoutePage()
class TaskEditorScreen extends ConsumerStatefulWidget {
  const TaskEditorScreen({
    this.dropDownMode = DropDownMode.adding,
    this.task,
    super.key,
  });

  final Task? task;
  final DropDownMode dropDownMode;

  @override
  ConsumerState<TaskEditorScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskEditorScreen> {
  late final Task _task;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  var _validateTite = false;

  @override
  void initState() {
    if (widget.task != null) {
      _task = widget.task!.copyWith();
      titleController.text = _task.title;
      descriptionController.text = _task.description ?? '';
    } else {
      _task = Task(title: '');
    }
    super.initState();
  }

  Future<void> _saveTask(BuildContext context) async {
    setState(() {
      _validateTite = titleController.text.trim().isEmpty;
    });
    if (_validateTite) return;

    final updatedTask = _task.copyWith(
      title: titleController.text,
      description: descriptionController.text,
      categoryId: ref.read(filterProvider.notifier).state?.id,
    );

    updatedTask.id == null
        ? await ref.read(todoApiProvider).addTask(updatedTask)
        : await ref
            .read(todoApiProvider)
            .updateTask(updatedTask.id, updatedTask);

    ref.read(todoListNotifierProvider.notifier).refresh();
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Добавить задачу')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              maxLength: 70,
              decoration: InputDecoration(
                labelText: 'Название',
                errorText: _validateTite ? 'Введите название' : null,
              ),
            ),
            TextField(
              controller: descriptionController,
              maxLength: 300,
              decoration: InputDecoration(labelText: 'Описание'),
            ),
            SizedBox(height: 32),
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: DropDownFilters(dropDownMode: widget.dropDownMode),
                ),
                IconButton(
                  onPressed: () async {
                    final TaskCategory? category = await context.pushRoute(
                      CategoryAddingRoute(),
                    );
                    if (category != null) {
                      ref.read(filterProvider.notifier).state = category;
                    }
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () => _saveTask(context),
                child: Text('Сохранить'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
