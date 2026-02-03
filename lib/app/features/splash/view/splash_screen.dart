import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/app/features/pokemon/viewmodels/pokemon_list_view_model.dart';
import 'package:pokedex/app/features/splash/view/widgets/pikachu_running_widget.dart';
import 'package:pokedex/app/setup/setup_get_it_injector.dart';
import 'package:pokedex/core/constants/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int done = 0;
  int total = 151;

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    final vm = getIt<PokemonListViewModel>();

    await vm.preloadAll(
      onProgress: (d, t) {
        setState(() {
          done = d;
          total = t;
        });
      },
    );

    if (!mounted) return;
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : done / total;

    return Scaffold(
      backgroundColor: Color(0xFFF9FFA7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PikachuRunningWidget(),
            const SizedBox(height: 16),
            Text('Caçando Pokemon: $done/$total'),
            const SizedBox(height: 8),
            Text('Progresso: ${(progress * 100).toStringAsFixed(0)}%'),
          ],
        ),
      ),
    );
  }
}
