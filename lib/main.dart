import 'dart:async';

import 'package:api/api.dart';
import 'package:demo_login/utils/routers/routers.dart';
import 'package:flutter/material.dart';

import 'api/services/services.dart';

void main() {
  runZoned(() async {
    await ApiRequest.instance.init(
      baseUrl: URLAPI,
    );
    const MyApp();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      routerDelegate: goRouter.routerDelegate,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
