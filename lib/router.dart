import 'package:auto_route/auto_route.dart';
import 'package:todolist/main.dart';

import 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  late final List<AutoRouteGuard> guards = [
    AutoRouteGuard.simple((resolver, router) async {
      var token = sharedPrefs.getString('token');
      var isAuthenticated = token != null;

      if (isAuthenticated || resolver.route.name == AuthRoute.name) {
        resolver.next();
      } else {
        await resolver.redirectUntil(AuthRoute());
      }
    }),
  ];

  @override
  final routes = [
    AutoRoute(initial: true, page: TaskListRoute.page, keepHistory: true),
    AutoRoute(page: AuthRoute.page),
    AutoRoute(page: TaskEditorRoute.page),
    AutoRoute(page: CategoryAddingRoute.page),
  ];
}
