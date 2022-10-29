import 'package:demo_login/pages/pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum Routers {
  home,
  profile,
  login,
}

extension RoutersName on Routers {
  String get name {
    switch (this) {
      case Routers.home:
        return '/';
      case Routers.profile:
        return 'profile';
      case Routers.login:
        return 'login';
    }
  }

  String get path {
    switch (this) {
      case Routers.home:
        return '/';
      case Routers.profile:
        return '/profile';
      case Routers.login:
        return '/login';
    }
  }

  Widget widget(GoRouterState state) {
    switch (this) {
      case Routers.home:
        return const HomePage();
      case Routers.profile:
        return const ProfilePage();
      case Routers.login:
        return const LoginPage();
    }
  }
}

GoRouter get goRouter => GoRouter(
      routes: [
        for (final item in Routers.values)
          GoRoute(
            path: item.path,
            name: item.name,
            builder: (_, state) => item.widget(state),
            redirect: (context, state) {
              if (kDebugMode) {
                return null;
              }
              return null;
            },
          ),
      ],
    );
