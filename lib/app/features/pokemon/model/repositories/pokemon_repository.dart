import 'package:pokedex/app/features/pokemon/model/entities/pokemon.dart';
import 'package:pokedex/app/features/pokemon/model/interface/pokemon_repository_interface.dart';
import 'package:pokedex/app/setup/pokemon_list_query_defaults.dart';

class PokemonRepository extends PokemonRepositoryInterface {
  final PokemonListQueryDefaults defaults;

  PokemonRepository(this.defaults);

  @override
  Future<List<Pokemon>> fetchPokemonList({int? limit, int? offset}) async {
    return fetchPokemonList(limit: defaults.limit, offset: defaults.offset);
  }
}
