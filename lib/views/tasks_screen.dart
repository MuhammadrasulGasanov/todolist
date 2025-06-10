import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/main.dart';
import 'package:todolist/providers/providers.dart';
import 'package:todolist/router.gr.dart';
import 'package:todolist/widgets/drop_down_filters.dart';
import 'package:todolist/widgets/task_list.dart';

@RoutePage()
class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(12),
        actions: [
          IconButton(
            onPressed: () async {
              await sharedPrefs.remove('token');
              if (context.mounted) {
                context.router.replaceAll([AuthRoute()]);
              }
            },
            icon: Icon(Icons.logout),
          ),
        ],
        title: Text('Задачи'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropDownFilters(),
            ),
          ),
        ),
      ),
      body: ref
          .watch(todoListNotifierProvider)
          .when(
            error: (e, st) => Center(child: Text('$e')),
            loading: () => Center(child: CircularProgressIndicator()),
            data: (tasks) {
              return tasks.isEmpty
                  ? ListTile(title: Text('Пусто'))
                  : Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: TaskList(
                      tasks: tasks,
                      onPressed: (task) async {
                        final notifier = ref.read(filterProvider.notifier);
                        if (task?.categoryId != null) {
                          notifier.state = await ref
                              .read(todoApiProvider)
                              .fetchCategoryById(task?.categoryId);
                        } else {
                          notifier.state = null;
                        }
                        if (context.mounted) {
                          context.pushRoute(
                            TaskEditorRoute(
                              task: task,
                              dropDownMode: DropDownMode.editing,
                            ),
                          );
                        }
                      },
                      onChecked:
                          (id, value) async => await ref
                              .read(todoListNotifierProvider.notifier)
                              .markTaskCompletion(id, value),
                      onDismissed:
                          (id) async => ref
                              .read(todoListNotifierProvider.notifier)
                              .delete(id),
                    ),
                  );
            },
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(filterProvider.notifier).state = null;
          context.pushRoute(TaskEditorRoute());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
