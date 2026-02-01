import 'package:get_it/get_it.dart';
import 'package:pokedex/app/features/pokemon/model/interface/pokemon_repository_interface.dart';
import 'package:pokedex/app/features/pokemon/model/repositories/pokemon_repository.dart';
import 'package:pokedex/app/features/pokemon/viewmodels/pokemon_list_view_model.dart';
import 'package:pokedex/core/http/dio_client.dart';
import 'package:pokedex/app/setup/pokemon_list_query_defaults.dart';
import 'package:pokedex/app/features/pokemon/model/services/pokemon_api_service.dart';

final getIt = GetIt.instance;

void setupGetItInjector() {
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  getIt.registerLazySingleton(
    () => const PokemonListQueryDefaults(limit: 151, offset: 0),
  );

  getIt.registerLazySingleton<PokemonApiService>(
    () => PokemonApiService(getIt<DioClient>().dio),
  );

  getIt.registerLazySingleton<PokemonRepositoryInterface>(
    () => PokemonRepository(
      getIt<PokemonApiService>(),
      getIt<PokemonListQueryDefaults>(),
    ),
  );

  getIt.registerLazySingleton<PokemonListViewModel>(
    () => PokemonListViewModel(
      getIt<PokemonRepositoryInterface>(),
      getIt<PokemonListQueryDefaults>(),
    ),
  );
}
