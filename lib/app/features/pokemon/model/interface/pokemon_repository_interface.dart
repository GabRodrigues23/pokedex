import 'package:pokedex/app/features/pokemon/model/entities/pokemon.dart';

abstract class PokemonRepositoryInterface {
  Future<List<Pokemon>> fetchPokemonList({
    required int limit,
    required int offset,
  });
}
