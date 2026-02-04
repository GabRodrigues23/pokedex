import 'package:pokedex/shared/enums/pokemon_type.dart';

class PokemonDetails {
  final int id;
  final String name;
  final String description;
  final String pokemonGif;
  final double height;
  final double weight;
  final List<PokemonType> type;

  PokemonDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.pokemonGif,
    required this.height,
    required this.weight,
    this.type = const [PokemonType.unknown],
  });

  PokemonDetails copyWith({
    int? id,
    String? name,
    String? description,
    String? pokemonGif,
    double? height,
    double? weight,
    List<PokemonType>? type,
  }) {
    return PokemonDetails(
      id: id ?? this.id,
      name: this.name,
      description: this.description,
      pokemonGif: this.pokemonGif,
      height: this.height,
      weight: this.weight,
      type: type ?? this.type,
    );
  }
}
