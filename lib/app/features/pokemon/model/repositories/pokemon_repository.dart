import 'package:pokedex/app/features/pokemon/model/entities/pokemon.dart';
import 'package:pokedex/app/features/pokemon/model/interface/pokemon_repository_interface.dart';
import 'package:pokedex/app/features/pokemon/model/services/pokemon_api_service.dart';
import 'package:pokedex/app/setup/pokemon_list_query_defaults.dart';
import 'package:pokedex/shared/enums/pokemon_type.dart';
import 'package:pokedex/shared/extensions/pokemon_type_extension.dart';

class PokemonRepository extends PokemonRepositoryInterface {
  final PokemonApiService api;
  final PokemonListQueryDefaults defaults;

  PokemonRepository(this.api, this.defaults);

  @override
  Future<List<Pokemon>> fetchPokemonList({int? limit, int? offset}) async {
    final dtos = await api.fetchPokemonList(
      limit: limit ?? defaults.limit,
      offset: offset ?? defaults.offset,
    );
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<PokemonType> fetchPokemonMainType(id) async {
    final json = await api.fetchPokemonDetails(id);
    return _parseMainType(json);
  }

  PokemonType _parseMainType(Map<String, dynamic> json) {
    final types = (json['types'] as List?) ?? [];
    if (types.isEmpty) return PokemonType.unknown;

    final typeName = types.first['type']?['name'] as String?;
    if (typeName == null) return PokemonType.unknown;

    return typeName.toPokemonType();
  }

  @override
  Future<List<Pokemon>> hydrateTypesForList(
    List<Pokemon> list, {
    int batchSize = 60,
    void Function(int done, int total)? onProgress,
  }) async {
    final total = list.length;
    final result = List<Pokemon>.from(list);

    var done = 0;
    var nextIndex = 0;

    Future<void> worker() async {
      while (true) {
        final i = nextIndex;
        nextIndex++;
        if (i >= total) return;

        final p = result[i];

        try {
          final type = await fetchPokemonMainType(p.id);
          result[i] = p.copyWith(type: type);
        } catch (_) {}

        done++;
        onProgress?.call(done, total);
      }
    }

    final workers = List.generate(batchSize, (_) => worker());
    await Future.wait(workers);

    return result;
  }
}
