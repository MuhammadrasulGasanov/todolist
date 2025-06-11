import 'package:flutter/material.dart';
import 'package:todolist/widgets/drop_down_filters.dart';

class TasksScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TasksScreenAppBar({super.key, required this.onLogout});
  final VoidCallback onLogout;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsPadding: EdgeInsets.all(12),
      actions: [IconButton(onPressed: onLogout, icon: Icon(Icons.logout))],
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
    );
  }
}
