import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/stores/auth_store.dart';

class AuthGuard extends StatefulWidget {
  final Widget child;

  const AuthGuard({super.key, required this.child});

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  final _authStore = GetIt.I<AuthStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_authStore.user == null) {
          return const LoginPage();
        }
        return widget.child;
      },
    );
  }
}
