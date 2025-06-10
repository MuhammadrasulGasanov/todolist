import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/data/models/category.dart';
import 'package:todolist/providers/providers.dart';

enum DropDownMode { filter, adding, editing }

class DropDownFilters extends ConsumerWidget {
  const DropDownFilters({this.dropDownMode = DropDownMode.filter, super.key});
  final DropDownMode dropDownMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(categoriesNotifierProvider)
        .when(
          loading: () => const LinearProgressIndicator(),
          error: (error, stack) => Text('Что-то пошло не так'),
          data: (categories) {
            return DropdownMenu<TaskCategory?>(
              width: MediaQuery.of(context).size.width - 32,
              initialSelection:
                  dropDownMode == DropDownMode.editing
                      ? ref.watch(filterProvider.notifier).state
                      : null,
              dropdownMenuEntries: [
                DropdownMenuEntry<TaskCategory?>(
                  value: null,
                  label:
                      dropDownMode == DropDownMode.filter
                          ? 'Все'
                          : 'Без категории',
                ),
                ...categories.map(
                  (e) => DropdownMenuEntry<TaskCategory?>(
                    value: e,
                    label: e?.name ?? '',
                    trailingIcon:
                        dropDownMode != DropDownMode.filter
                            ? IconButton(
                              onPressed: () async {
                                final notifier = ref.read(
                                  categoriesNotifierProvider.notifier,
                                );
                                await notifier.deleteCategory(e);
                                final selectedValue = ref.read(
                                  filterProvider.notifier,
                                );
                                if (e == selectedValue.state) {
                                  selectedValue.state = null;
                                }
                              },
                              icon: Icon(Icons.delete_outlined),
                            )
                            : null,
                  ),
                ),
              ],
              onSelected: (category) async {
                if (dropDownMode == DropDownMode.filter) {
                  ref
                      .read(todoListNotifierProvider.notifier)
                      .refresh(category?.id);
                }
                ref.read(filterProvider.notifier).state = category;
              },
              label: const Text('Категория'),
            );
          },
        );
  }
}
