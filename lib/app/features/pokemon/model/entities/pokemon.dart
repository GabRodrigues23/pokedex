import 'package:pokedex/shared/enums/pokemon_type.dart';

class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  PokemonType? type;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.type,
  });

  Pokemon copyWith({
    int? id,
    String? name,
    String? imageUrl,
    PokemonType? type,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: this.name,
      imageUrl: this.imageUrl,
      type: type,
    );
  }
}
