import 'package:pokedex/shared/enums/pokemon_type.dart';

extension PokemonTypeExtension on String {
  PokemonType toPokemonType() {
    return PokemonType.values.firstWhere(
      (filter) => filter.name == toLowerCase(),
      orElse: () => PokemonType.unknown,
    );
  }
}
