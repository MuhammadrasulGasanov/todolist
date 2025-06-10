import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/data/models/auth_request.dart';
import 'package:todolist/data/models/auth_response.dart';
import 'package:todolist/main.dart';
import 'package:todolist/providers/providers.dart';
import 'package:todolist/router.gr.dart';
import 'package:todolist/utils.dart';

@RoutePage()
class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  var _authRequest = AuthRequest(username: '', password: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16,
          children: [
            Text(
              'Войти / Зарегистрироваться',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            FormBuilderTextField(
              name: 'login',
              validator: (value) => validateNotEmpty(value, 'Введите логин'),
              onChanged:
                  (value) =>
                      _authRequest = _authRequest.copyWith(
                        username: value ?? '',
                      ),
            ),
            FormBuilderTextField(
              name: 'password',
              validator: (value) => validateNotEmpty(value, 'Введите пароль'),
              onChanged:
                  (value) =>
                      _authRequest = _authRequest.copyWith(
                        password: value ?? '',
                      ),
            ),
            ElevatedButton(
              onPressed: () async {
                final api = ref.read(todoApiProvider);
                AuthResponse? response;
                try {
                  response = await api.registration(_authRequest);
                } catch (_) {}
                try {
                  response = await api.login(_authRequest);
                  sharedPrefs.setString('token', response?.token ?? '');
                  sharedPrefs.setString('username', response?.username ?? '');
                } catch (_) {}
                final token = response?.token;
                if (token != null && token.isNotEmpty && context.mounted) {
                  context.router.replaceAll([const TaskListRoute()]);
                }
              },
              child: Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
}
