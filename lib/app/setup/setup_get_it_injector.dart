import 'package:get_it/get_it.dart';
import 'package:pokedex/core/http/dio_client.dart';
import 'package:pokedex/app/setup/pokemon_list_query_defaults.dart';
import 'package:pokedex/app/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/app/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex/app/features/pokemon/data/services/pokemon_api_service.dart';
import 'package:pokedex/app/features/pokemon/domain/usecases/get_pokemon_list.dart';
import 'package:pokedex/app/features/pokemon/domain/usecases/get_pokemon_details.dart';

final getIt = GetIt.instance;

void setupGetItInjector() {
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  getIt.registerLazySingleton<PokemonApiService>(
    () => PokemonApiService(getIt<DioClient>().dio),
  );

  getIt.registerLazySingleton(
    () => const PokemonListQueryDefaults(limit: 151, offset: 0),
  );

  getIt.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(getIt<PokemonApiService>()),
  );

  getIt.registerLazySingleton<GetPokemonList>(
    () => GetPokemonList(
      getIt<PokemonRepository>(),
      getIt<PokemonListQueryDefaults>(),
    ),
  );

  getIt.registerLazySingleton<GetPokemonDetails>(
    () => GetPokemonDetails(getIt<PokemonRepository>()),
  );
}
