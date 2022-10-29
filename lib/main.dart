import 'dart:async';
import 'dart:developer';

import 'package:api/api.dart';
import 'package:demo_login/utils/routers/routers.dart';
import 'package:flutter/material.dart';

import 'api/services/services.dart';

void main() {
  runZonedGuarded(() async {
    await ApiRequest.instance.init(
      baseUrl: URLAPI,
    );
    runApp(const MyApp());
  }, (error, stack) {
    log('error main app: $error');
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
