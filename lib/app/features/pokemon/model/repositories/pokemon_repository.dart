import 'package:pokedex/app/features/pokemon/model/entities/pokemon.dart';
import 'package:pokedex/app/features/pokemon/model/interface/pokemon_repository_interface.dart';
import 'package:pokedex/app/setup/pokemon_list_query_defaults.dart';
import 'package:pokedex/app/setup/setup_get_it_injector.dart';

class PokemonRepository extends PokemonRepositoryInterface {
  final PokemonListQueryDefaults defaults;

  PokemonRepository(PokemonListQueryDefaults? defaults)
    : defaults = defaults ?? getIt<PokemonListQueryDefaults>();

  @override
  Future<List<Pokemon>> fetchPokemonList({int? limit, int? offset}) async {
    return fetchPokemonList(
      limit: limit ?? defaults.limit,
      offset: offset ?? defaults.offset,
    );
  }
}
