import 'package:pokedex/app/features/pokemon/model/entities/pokemon.dart';
import 'package:pokedex/core/constants/pokemon_assets.dart';
import 'package:pokedex/shared/enums/pokemon_type.dart';

class PokemonDto {
  final String name;
  final String url;

  const PokemonDto({required this.name, required this.url});

  factory PokemonDto.fromJson(Map<String, dynamic> json) {
    return PokemonDto(name: json['name'], url: json['url']);
  }

  int get id {
    final uri = Uri.parse(url);
    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    return int.parse(segments.last);
  }

  String get imageUrl => '${PokemonAssets.spriteBaseUrl}/$id.png';

  Pokemon toEntity() => Pokemon(
    id: id,
    name: name,
    imageUrl: imageUrl,
    type: PokemonType.unknown,
  );
}
