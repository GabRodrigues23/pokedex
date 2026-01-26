import 'package:pokedex/app/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/app/features/pokemon/domain/entities/pokemon_details.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> fetchPokemonList({
    required int limit,
    required int offset,
  });

  Future<PokemonDetails> fetchPokemonDetails(int id);
}
