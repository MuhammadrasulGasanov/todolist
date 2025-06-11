import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/modules/tasks/tasks_controller.dart';
import 'package:todolist/modules/tasks/widgets/appbar.dart';
import 'package:todolist/providers/providers.dart';
import 'package:todolist/widgets/task_list.dart';

@RoutePage()
class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(
      builder: (context) {
        final controller = ref.read(tasksControllerProvider);
        return Scaffold(
          appBar: TasksScreenAppBar(
            onLogout: () => controller.handleLogout(context),
          ),
          body: ref
              .watch(todoListNotifierProvider)
              .when(
                error: (e, st) => Center(child: Text('$e')),
                loading: () => const Center(child: CircularProgressIndicator()),
                data: (tasks) {
                  return RefreshIndicator(
                    onRefresh: controller.refreshTasks,
                    child:
                        tasks.isEmpty
                            ? const ListTile(title: Text('Пусто'))
                            : Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: TaskList(
                                tasks: tasks,
                                onPressed:
                                    (task) => controller.handleTaskPress(
                                      task,
                                      context,
                                    ),
                                onChecked: controller.handleTaskCompletion,
                                onDismissed: controller.handleTaskDeletion,
                              ),
                            ),
                  );
                },
              ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => controller.navigateToNewTask(context),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
