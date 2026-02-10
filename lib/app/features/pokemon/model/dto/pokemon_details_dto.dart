import 'package:pokedex/app/features/pokemon/model/entities/pokemon_details.dart';
import 'package:pokedex/core/constants/pokemon_assets.dart';
import 'package:pokedex/shared/enums/pokemon_type.dart';
import 'package:pokedex/shared/extensions/pokemon_type_extension.dart';

class PokemonDetailsDto {
  final String name;
  final String urlGif;
  final String urlDescription;
  final double height;
  final double weight;
  final List<PokemonType> types;

  const PokemonDetailsDto({
    required this.name,
    required this.urlGif,
    required this.urlDescription,
    required this.height,
    required this.weight,
    required this.types,
  });

  factory PokemonDetailsDto.fromJson(
    Map<String, dynamic> pokemonJson,
    Map<String, dynamic> speciesJson,
  ) {
    final typesJson = (pokemonJson['types'] as List?) ?? [];
    final parsedTypes = typesJson
        .map((t) => t['type']?['name'] as String?)
        .whereType<String>()
        .map((name) => name.toPokemonType())
        .toList();

    final entries = (speciesJson['flavor_text_entries'] as List?) ?? const [];
    Map<String, dynamic>? entry;
    for (final e in entries) {
      final map = e as Map<String, dynamic>;
      final lang = (map['language'] as Map<String, dynamic>?)?['name'];
      if (lang == 'en') {
        entry = map;
        break;
      }
    }

    final rawFlavor =
        (entry ??
                (entries.isNotEmpty
                    ? entries.first as Map<String, dynamic>
                    : null))?['flavor_text']
            as String? ??
        '';

    final cleanFlavor = rawFlavor
        .replaceAll('\n', ' ')
        .replaceAll('\f', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    return PokemonDetailsDto(
      name: pokemonJson['name'] as String,
      urlGif:
          pokemonJson['sprites']?['other']?['showdown']?['front_default']
              as String? ??
          '',
      urlDescription: cleanFlavor,
      height: (pokemonJson['height'] as num).toDouble(),
      weight: (pokemonJson['weight'] as num).toDouble(),
      types: parsedTypes,
    );
  }

  PokemonDetails toEntity(int id) => PokemonDetails(
    id: id,
    name: name,
    description: urlDescription,
    pokemonGif: '${PokemonAssets.gifBaseUrl}/$id.gif',
    height: height,
    weight: weight,
    type: types,
  );
}
