import 'package:go_router/go_router.dart';
import 'package:pokedex/app/features/home/view/home_page.dart';
import 'package:pokedex/app/features/splash/view/splash_screen.dart';
import 'package:pokedex/core/constants/app_routes.dart';

class AppRouter {
  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
