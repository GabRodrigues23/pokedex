import 'package:pokedex/app/features/pokemon/model/entities/pokemon.dart';
import 'package:pokedex/app/features/pokemon/model/interface/pokemon_repository_interface.dart';
import 'package:pokedex/app/features/pokemon/model/services/pokemon_api_service.dart';
import 'package:pokedex/app/setup/pokemon_list_query_defaults.dart';

class PokemonRepository extends PokemonRepositoryInterface {
  final PokemonApiService api;
  final PokemonListQueryDefaults defaults;

  PokemonRepository(this.api, this.defaults);

  @override
  Future<List<Pokemon>> fetchPokemonList({int? limit, int? offset}) async {
    final dtos = await api.fetchPokemonList(
      limit: limit ?? defaults.limit,
      offset: offset ?? defaults.offset,
    );
    return dtos.map((dto) => dto.toEntity()).toList();
  }
}
