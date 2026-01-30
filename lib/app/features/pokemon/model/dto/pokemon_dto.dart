import 'package:pokedex/shared/enums/pokemon_type.dart';
import 'package:pokedex/shared/extensions/pokemon_type_extension.dart';

class PokemonDto {
  final String name;
  final String url;
  final PokemonType type;

  const PokemonDto({required this.name, required this.url, required this.type});

  factory PokemonDto.fromJson(Map<String, dynamic> json) {
    return PokemonDto(
      name: json['name'],
      url: json['url'],
      type: json['type'] != null
          ? (json['type'].toString().toPokemonType())
          : PokemonType.unknown,
    );
  }
}
