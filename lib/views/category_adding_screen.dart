import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/data/models/category.dart';
import 'package:todolist/providers/providers.dart';
import 'package:todolist/utils.dart';

@RoutePage()
class CategoryAddingScreen extends ConsumerStatefulWidget {
  const CategoryAddingScreen({super.key});

  @override
  ConsumerState<CategoryAddingScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<CategoryAddingScreen> {
  final categoryController = TextEditingController();
  var _validateField = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Новая категория')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          spacing: 24,
          children: [
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                labelText: 'Новая категория',
                errorText: _validateField ? 'Введите название' : null,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final categoryName = trim(categoryController.text);
                setState(() {
                  _validateField = categoryName == null;
                });
                if (_validateField) return;
                final category = TaskCategory(name: categoryName!);
                await ref
                    .read(categoriesNotifierProvider.notifier)
                    .addCategory(category);
                if (context.mounted) context.maybePop(category);
              },
              child: Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}
