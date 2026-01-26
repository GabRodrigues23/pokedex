import 'package:go_router/go_router.dart';
import 'package:pokedex/app/features/pokemon/domain/usecases/get_pokemon_list.dart';
import 'package:pokedex/app/features/pokemon/ui/viewmodels/pokemon_list_view_model.dart';
import 'package:pokedex/app/features/pokemon/ui/views/pokemon_list_page.dart';
import 'package:pokedex/app/features/splash/view/splash_screen.dart';
import 'package:pokedex/app/setup/setup_get_it_injector.dart';
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
        builder: (context, state) => PokemonListPage(
          viewModel: PokemonListViewModel(getIt<GetPokemonList>()),
        ),
      ),
    ],
  );
}
