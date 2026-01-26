import 'package:pokedex/app/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/app/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/app/setup/pokemon_list_query_defaults.dart';

class GetPokemonList {
  final PokemonRepository repository;
  final PokemonListQueryDefaults defaults;
  const GetPokemonList(this.repository, this.defaults);

  Future<List<Pokemon>> call({int? limit, int? offset}) {
    return repository.fetchPokemonList(
      limit: limit ?? defaults.limit,
      offset: offset ?? defaults.offset,
    );
  }
}
