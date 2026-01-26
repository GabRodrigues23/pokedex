import 'package:flutter/material.dart';
import 'package:pokedex/core/router/app_router.dart';

class BuildApp extends StatelessWidget {
  const BuildApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto', useMaterial3: true),
      routerConfig: AppRouter().router,
    );
  }
}
