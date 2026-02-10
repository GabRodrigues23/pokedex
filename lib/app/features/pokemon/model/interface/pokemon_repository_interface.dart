import 'package:pokedex/app/features/pokemon/model/entities/pokemon.dart';
import 'package:pokedex/app/features/pokemon/model/entities/pokemon_details.dart';
import 'package:pokedex/shared/enums/pokemon_type.dart';

abstract class PokemonRepositoryInterface {
  Future<List<Pokemon>> fetchPokemonList({
    required int limit,
    required int offset,
  });

  Future<PokemonType> fetchPokemonMainType(int id);
  Future<List<Pokemon>> hydrateTypesForList(
    List<Pokemon> list, {
    int batchSize = 25,
    void Function(int done, int total)? onProgress,
  });

  Future<PokemonDetails> fetchPokemonDetails(int id);
}
