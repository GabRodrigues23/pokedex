import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/app/features/splash/view/widgets/pikachu_running_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _navTimer;

  @override
  void initState() {
    super.initState();
    _navTimer = Timer(const Duration(seconds: 10), () {
      if (!mounted) return;
      context.go('/home');
    });
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF9FFA7),
      body: Center(child: PikachuRunningWidget()),
    );
  }
}
