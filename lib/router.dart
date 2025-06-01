import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  final routes = [
    AutoRoute(initial: true, page: TaskListRoute.page, keepHistory: true),
    AutoRoute(page: TaskEditorRoute.page),
    AutoRoute(page: CategoryAddingRoute.page),
  ];
}
