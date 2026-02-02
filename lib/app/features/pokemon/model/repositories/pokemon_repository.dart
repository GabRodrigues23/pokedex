import 'package:pokedex/app/features/pokemon/model/entities/pokemon.dart';
import 'package:pokedex/app/features/pokemon/model/interface/pokemon_repository_interface.dart';
import 'package:pokedex/app/features/pokemon/model/services/pokemon_api_service.dart';
import 'package:pokedex/app/features/pokemon/model/services/pokemon_type_cache.dart';
import 'package:pokedex/app/setup/pokemon_list_query_defaults.dart';
import 'package:pokedex/shared/enums/pokemon_type.dart';
import 'package:pokedex/shared/extensions/pokemon_type_extension.dart';

class PokemonRepository extends PokemonRepositoryInterface {
  final PokemonApiService api;
  final PokemonListQueryDefaults defaults;
  final PokemonTypeCache typeCache;

  PokemonRepository(this.api, this.defaults, this.typeCache);

  @override
  Future<List<Pokemon>> fetchPokemonList({int? limit, int? offset}) async {
    final dtos = await api.fetchPokemonList(
      limit: limit ?? defaults.limit,
      offset: offset ?? defaults.offset,
    );
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<PokemonType> fetchPokemonMainType(int id) async {
    await typeCache.load();

    final cached = typeCache.get(id);
    if (cached != null) return cached;

    final json = await api.fetchPokemonDetails(id);
    final type = _parseMainType(json);

    typeCache.set(id, type);
    return type;
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
    await typeCache.load();

    final total = list.length;
    final result = List<Pokemon>.from(list);

    var done = 0;

    final missingIndexes = <int>[];
    for (var i = 0; i < total; i++) {
      final p = result[i];
      final cached = typeCache.get(p.id);

      if (cached != null) {
        result[i] = p.copyWith(type: cached);
        done++;
      } else {
        missingIndexes.add(i);
      }
    }

    onProgress?.call(done, total);

    if (missingIndexes.isEmpty) return result;

    var next = 0;

    Future<void> worker() async {
      while (true) {
        final k = next++;
        if (k >= missingIndexes.length) return;

        final i = missingIndexes[k];
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
