import 'package:pokedex/app/features/pokemon/data/dto/pokemon_details.dto.dart';
import 'package:pokedex/app/features/pokemon/data/dto/pokemon_dto.dart';
import 'package:pokedex/app/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/app/features/pokemon/domain/entities/pokemon_details.dart';
import 'package:pokedex/core/constants/pokemon_assets.dart';

class PokemonMapper {
  static Pokemon toEntity(PokemonDto dto) {
    final id = int.parse(dto.url.split('/').where((e) => e.isNotEmpty).last);

    return Pokemon(
      id: id,
      name: dto.name,
      imageUrl: '${PokemonAssets.spriteBaseUrl}/$id.png',
    );
  }

  static PokemonDetails toDetailsEntity(PokemonDetailsDto dto) {
    return PokemonDetails(
      id: dto.id,
      name: dto.name,
      types: dto.types,
      imageUrl: '${PokemonAssets.spriteBaseUrl}/${dto.id}.png',
    );
  }
}
