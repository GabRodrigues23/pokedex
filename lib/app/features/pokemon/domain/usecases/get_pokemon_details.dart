import 'package:pokedex/app/features/pokemon/domain/entities/pokemon_details.dart';
import 'package:pokedex/app/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonDetails {
  final PokemonRepository repository;
  const GetPokemonDetails(this.repository);

  Future<PokemonDetails> call(int id) {
    return repository.fetchPokemonDetails(id);
  }
}
